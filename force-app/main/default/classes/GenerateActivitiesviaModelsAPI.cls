global class GenerateActivitiesviaModelsAPI {

    global static String generateText(String prompt) {
        String result;
 
     //    Check if running in test context
        if (Test.isRunningTest()) {
            // Return mock data directly for testing
            return '{"itineraryName": "Paris Trip", "destination": "Paris", "startDate": "2024-08-20", "endDate": "2024-08-21", "accommodation": "Paris Boutique Hotel", "transportation": "Paris Rails", "activities": [{"name": "Visit Eiffel Tower", "location": "Eiffel Tower", "localdate": "2024-08-20", "localtime": "09:00", "outdoor": true}]}';
        }
 
        // Create generate text request
        system.debug('prompt in GenerateActivitiesviaModelsAPI: ' + prompt);
        aiplatform.ModelsAPI.createGenerations_Request request = new aiplatform.ModelsAPI.createGenerations_Request();
 
        // Specify model
        request.modelName = 'sfdc_ai__DefaultGPT35Turbo';
 
        // Create request body
        aiplatform.ModelsAPI_GenerationRequest requestBody = new aiplatform.ModelsAPI_GenerationRequest();
        request.body = requestBody;
 
        // Add prompt to body
        requestBody.prompt = prompt;
 
        // Make request
        try {
            aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();
            aiplatform.ModelsAPI.createGenerations_Response response = modelsAPI.createGenerations(request);
            result = response.Code200.generation.generatedText;
            return result;
        } catch(aiplatform.ModelsAPI.createGenerations_ResponseException e) {
            System.debug('Response code: ' + e.responseCode);
            System.debug('The following exception occurred: ' + e);
        }
        return result;
    }
 }