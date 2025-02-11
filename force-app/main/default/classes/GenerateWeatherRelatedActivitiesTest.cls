@isTest
public class GenerateWeatherRelatedActivitiesTest {

    // Mock class for Models API
    public class ModelsAPIMock implements HttpCalloutMock {
        private Boolean isSuccess;

        public ModelsAPIMock(Boolean isSuccess) {
            this.isSuccess = isSuccess;
        }

        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');

            if (isSuccess) {
                response.setStatusCode(200);
                response.setBody('{"id":"1234","object":"generation","created":1234567890,"model":"gpt-3.5-turbo","generation":{"role":"assistant","content":"Based on the weather, I recommend the indoor activities.","generatedText":"Based on the weather, I recommend the indoor activities."}}');
            } else {
                response.setStatusCode(400);
                // Including the required errorCode in the error response
                response.setBody('{"error": {"message": "Test error message", "type": "invalid_request_error", "errorCode": "INVALID_REQUEST"}}');
            }
            return response;
        }
    }

    @TestSetup
    static void setupTestData() {
        // Create test Itinerary
        Itinerary__c testItinerary = new Itinerary__c(
            Destination__c = 'Test City',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(7)
        );
        insert testItinerary;

        // Create test Activities
        List<TravelActivity__c> activities = new List<TravelActivity__c>();
        activities.add(new TravelActivity__c(
            Name = 'Hiking',
            Location__c = 'Mountain Trail',
            Outdoor__c = true,
            Itinerary__c = testItinerary.Id
        ));
        activities.add(new TravelActivity__c(
            Name = 'Museum Visit',
            Location__c = 'City Center',
            Outdoor__c = false,
            Itinerary__c = testItinerary.Id
        ));
        insert activities;
    }

    @isTest
    static void testEvaluateItinerary_Success() {
        // Get test itinerary
        Itinerary__c testItinerary = [SELECT Id FROM Itinerary__c LIMIT 1];

        // Create input for invocable method
        GenerateWeatherRelatedActivities.ItineraryInput input = new GenerateWeatherRelatedActivities.ItineraryInput();
        input.itineraryId = testItinerary.Id;
        List<GenerateWeatherRelatedActivities.ItineraryInput> inputs = new List<GenerateWeatherRelatedActivities.ItineraryInput>{input};

        // Set mock callout behavior
        Test.setMock(HttpCalloutMock.class, new ModelsAPIMock(true));

        Test.startTest();
        List<GenerateWeatherRelatedActivities.ActivityRecommendation> results = GenerateWeatherRelatedActivities.evaluateItinerary(inputs);
        Test.stopTest();

        // Verify results
        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(1, results.size(), 'Should return one recommendation');
        System.assertNotEquals(null, results[0].recommendedActivities, 'Recommended activities should not be null');
    }

    @isTest
    static void testEvaluateItinerary_NoActivities() {
        // Create new itinerary without activities
        Itinerary__c emptyItinerary = new Itinerary__c(
            Destination__c = 'Empty City',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(7)
        );
        insert emptyItinerary;

        // Create input
        GenerateWeatherRelatedActivities.ItineraryInput input = new GenerateWeatherRelatedActivities.ItineraryInput();
        input.itineraryId = emptyItinerary.Id;
        List<GenerateWeatherRelatedActivities.ItineraryInput> inputs = new List<GenerateWeatherRelatedActivities.ItineraryInput>{input};

        // Set mock callout behavior
        Test.setMock(HttpCalloutMock.class, new ModelsAPIMock(true));

        Test.startTest();
        List<GenerateWeatherRelatedActivities.ActivityRecommendation> results = GenerateWeatherRelatedActivities.evaluateItinerary(inputs);
        Test.stopTest();

        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(1, results.size(), 'Should return one recommendation');
    }

    @isTest
    static void testGenerateActivityPrompt() {
        // Get test activities
        List<TravelActivity__c> activities = [SELECT Id, Name, Location__c, Outdoor__c FROM TravelActivity__c];
        String weatherCondition = 'Sunny';

        Test.startTest();
        String prompt = GenerateWeatherRelatedActivities.generateActivityPrompt(activities, weatherCondition);
        Test.stopTest();

        // Verify prompt contains weather condition and activities
        System.assert(prompt.contains('Sunny'), 'Prompt should contain weather condition');
        System.assert(prompt.contains('Hiking'), 'Prompt should contain outdoor activity');
        System.assert(prompt.contains('Museum Visit'), 'Prompt should contain indoor activity');
    }

    @isTest
    static void testGetWeatherCondition_Mock() {
        Test.startTest();
        String weatherCondition = GenerateWeatherRelatedActivities.getWeatherCondition_Mock('Test City');
        Test.stopTest();

        System.assertNotEquals(null, weatherCondition, 'Weather condition should not be null');
        System.assert(weatherCondition.contains('Weather'), 'Weather condition should contain description');
    }
}