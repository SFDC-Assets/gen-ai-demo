global class GenerateWeatherRelatedActivities {
    // Define the input structure for the invocable method
    public class ItineraryInput {
        @InvocableVariable(required=true)
        public Id itineraryId;
    }

    // Define the output structure for the invocable method
    public class ActivityRecommendation {
        @InvocableVariable
        public String recommendedActivities;
    }

    // Main invocable method
    @InvocableMethod(label='Recommend Activities for weather' description='Evaluates an itinerary for weather appropriateness and returns recommended activities')
    public static List<ActivityRecommendation> evaluateItinerary(List<ItineraryInput> inputs) {
        List<ActivityRecommendation> results = new List<ActivityRecommendation>();
        for (ItineraryInput input : inputs) {
            // Step 1: Fetch the itinerary and its associated activities
            Itinerary__c itinerary = [SELECT Id, Destination__c, Start_Date__c, End_Date__c FROM Itinerary__c WHERE Id = :input.itineraryId LIMIT 1];
            List<TravelActivity__c> activities = [SELECT Id, Name, Location__c, Outdoor__c FROM TravelActivity__c  WHERE Itinerary__c = :input.itineraryId];

            // Step 2: Call weather.com API to check if the activities are weather appropriate
            
            String weatherCondition = getWeatherCondition_Mock(itinerary.Destination__c);
           // system.debug(weatherCondition);
     
            // Step 3: Evaluate activities based on weather
            String activityPrompt = generateActivityPrompt(activities, weatherCondition);

            // Step 4: Call OpenAI API to get recommended activities
            String recommendedActivities = getModelsAPIRecommendations(activityPrompt);

            // Prepare the result
            ActivityRecommendation recommendation = new ActivityRecommendation();
            recommendation.recommendedActivities = recommendedActivities;
            results.add(recommendation);
        }

        return results;
    }

   
    // Method to generate the prompt for Models API based on activities and weather
   public static String generateActivityPrompt(List<TravelActivity__c> activities, String weatherCondition) {
        String prompt = 'Given the following activities and weather condition: ' + weatherCondition + '. Here are the activities: ';
        for (TravelActivity__c activity : activities) {
            prompt += activity.Name + (activity.Outdoor__c ? ' (Outdoor)' : ' (Indoor)') + ', ';
        }
        prompt += 'Please recommend the most suitable activities.';
        return prompt;
    } 

    // Method to get recommendations from Models API
    private static String getModelsAPIRecommendations(String prompt) {
        // Create generations request
        aiplatform.ModelsAPI.createGenerations_Request request = new aiplatform.ModelsAPI.createGenerations_Request();

        // Specify model
        request.modelName = 'sfdc_ai__DefaultAzureOpenAIGPT35Turbo';

        // Create request body
        aiplatform.ModelsAPI_GenerationRequest body = new aiplatform.ModelsAPI_GenerationRequest();
        request.body = body;

        // Add prompt to body
        body.prompt = prompt;

        String modelsApiResponse = '';

        try {
            // Make request
            aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();
            aiplatform.ModelsAPI.createGenerations_Response response = modelsAPI.createGenerations(request);

            // Add response to return value
            modelsApiResponse = response.Code200.generation.generatedText;

        // Handle error
        } catch(aiplatform.ModelsAPI.createGenerations_ResponseException e) {
            System.debug('Response code: ' + e.responseCode);
            System.debug('The following exception occurred: ' + e);

            // Add error to the return value
            modelsApiResponse = 'Unable to get a valid response. Error code: ' + e.responseCode;
        }

        // Return response
        return modelsApiResponse;
    }

    // Mock method simulating weather API response
    public static String getWeatherCondition_Mock(String location){
    //## Uncomment weatherCondition String to experiment with weather conditons.
    // Observe how LLM responds to different weather conditions in the prompt
    String  weatherCondition='Weather is not suitable for outdoor activties due to heavy rainfall.';
    //String weatherCondition ='Dense fog reduces visibility, making outdoor activities unsafe.';
    //String weatherCondition = 'Perfect clear skies today—ideal for outdoor adventures and exploring!';

      return weatherCondition;  
    }

    // Actual method to call the weather API (commented out to avoid hitting limits)
    /*
    public static String getWeatherCondition_API(String location){
    String API_KEY = '<YOUR API KEY>';
    String BASE_URL1 = 'http://api.openweathermap.org/data/2.5/weather';
    String BASE_URL = 'http://api.openweathermap.org/data/3.0/onecall/overview';

    String requestUrl1 = BASE_URL1 + '?q=' + location +'&units=metric&appid=' + API_KEY;
    
       String lon; String lat;
       
      // Step1: get longitude /latitude of the location
        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint(requestUrl1);
        req1.setMethod('GET');
        req1.setTimeout(60000); // 60 seconds timeout
        
    //Step2: send the request
        Http http1 = new Http();
        HttpResponse res1 = http1.send(req1);

        if (res1.getStatusCode() == 200) {
            // Parse the JSON response
            Map<String, Object> responseMap1 = (Map<String, Object>) JSON.deserializeUntyped(res1.getBody());
            Map<String, Object> coord = (Map<String, Object>) responseMap1.get('coord');
            lon= coord.get('lon').toString();
            lat=coord.get('lat').toString();
            
           }
        Step2: Pass the longitude and latitude to genarate the wether overview
        String requestUrl = BASE_URL + '?q=' + location + '&lon='+ lon + '&lat='+ lat+'&units=metric&appid=' + API_KEY;
    
        HttpRequest req = new HttpRequest();
        req.setEndpoint(requestUrl);
        req.setMethod('GET');
        req.setTimeout(60000); // 60 seconds timeout

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            // Parse the JSON response
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            String mainData = responseMap.get('weather_overview').toString();
            system.debug(mainData);
           // String weatheroverview = mainData.get('weather_overview');
            return mainData;
        } else {
            throw new CalloutException('Failed to get temperature: ' + res.getStatus() + ' ' + res.getStatusCode());
        } 
    }
    */
    
}