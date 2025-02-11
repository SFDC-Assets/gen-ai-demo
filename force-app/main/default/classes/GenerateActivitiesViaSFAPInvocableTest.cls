@IsTest
public class GenerateActivitiesViaSFAPInvocableTest {

    private class ModelsAPICalloutMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            // Updated the mock response to ensure the itinerary data matches expectations
            String mockResponseBody = '{"Code200": {"generation": {"id": "unique-id-123", "generatedText": "{\\"itineraryName\\": \\"Paris Trip\\", \\"destination\\": \\"Paris\\", \\"startDate\\": \\"2024-08-20\\", \\"endDate\\": \\"2024-08-21\\", \\"accommodation\\": \\"Paris Boutique Hotel\\", \\"transportation\\": \\"Paris Rails\\", \\"activities\\": [{\\"name\\": \\"Visit Eiffel Tower\\", \\"location\\": \\"Eiffel Tower\\", \\"localdate\\": \\"2024-08-20\\", \\"localtime\\": \\"09:00\\", \\"outdoor\\": true, \\"status\\": \\"Active\\"}]}"}}}';
            res.setBody(mockResponseBody);
            return res;
        }
    }

    @TestSetup
    static void setupTestData() {
        Traveler_Profile__c travelerProfile = new Traveler_Profile__c(
            Interests__c = 'Adventure, Cultural Experiences',
            Special_Requirements__c = 'Vegetarian, Wheelchair Access'
        );
        insert travelerProfile;

        Contact traveler = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Traveler_Profile__c = travelerProfile.Id
        );
        insert traveler;
    }

    @IsTest
    static void testGetActivitiesList() {
        Contact traveler = [SELECT Id FROM Contact WHERE LastName = 'Doe' LIMIT 1];

        GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput testInput = new GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput();
        testInput.destination = 'Paris';
        testInput.traveler = traveler;

        List<GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput> inputList = new List<GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput> { testInput };

        Test.setMock(HttpCalloutMock.class, new ModelsAPICalloutMock());

        Test.startTest();
        List<Itinerary__c> itineraries = GenerateActivitiesViaSFAPInvocable.getActivitiesList(inputList);
        Test.stopTest();

        System.assertNotEquals(0, itineraries.size(), 'At least one itinerary should be created');
        System.assertEquals('Paris', itineraries[0].destination__c, 'Destination should be Paris');

        // Create an instance of the Itinerary class to cover the constructor
        List<GenerateActivitiesViaSFAPInvocable.Activity> activities = new List<GenerateActivitiesViaSFAPInvocable.Activity>();
        activities.add(new GenerateActivitiesViaSFAPInvocable.Activity('Visit Eiffel Tower', 'Eiffel Tower', Date.newInstance(2024, 8, 20), '09:00', true, 'Active'));

        GenerateActivitiesViaSFAPInvocable.Itinerary itinerary = new GenerateActivitiesViaSFAPInvocable.Itinerary('Paris Trip', 'Active', 'Paris', Date.newInstance(2024, 8, 20), Date.newInstance(2024, 8, 21), 'Paris Boutique Hotel', 'Paris Rails', activities);
        // Assertions to ensure the itinerary is created correctly
        // System.assertEquals('Paris Trip', itinerary.itineraryName, 'Itinerary name should match');
        System.assertEquals('Paris', itinerary.destination, 'Destination should match');
        System.assertEquals(Date.newInstance(2024, 8, 20), itinerary.startdate, 'Start date should match');
        System.assertEquals(Date.newInstance(2024, 8, 21), itinerary.enddate, 'End date should match');
        System.assertEquals('Paris Boutique Hotel', itinerary.accommodation, 'Accommodation should match');
    }

    @IsTest
    static void testGetJsonFromPrompt() {
        Contact traveler = [SELECT Id FROM Contact WHERE LastName = 'Doe' LIMIT 1];

        Test.setMock(HttpCalloutMock.class, new ModelsAPICalloutMock());

        Test.startTest();
        String jsonResponse = GenerateActivitiesviaModelsAPI.generateText('Generate itinerary for Paris');
        Test.stopTest();

        System.assertNotEquals(null, jsonResponse, 'The response should not be null');

        // Deserialize the JSON response to an Itinerary object
        GenerateActivitiesViaSFAPInvocable.Itinerary itinerary = (GenerateActivitiesViaSFAPInvocable.Itinerary)JSON.deserialize(jsonResponse, GenerateActivitiesViaSFAPInvocable.Itinerary.class);

        // Assertions to ensure the itinerary is populated correctly
        System.assertEquals('Paris Trip', itinerary.itineraryName, 'Itinerary name should match');
        System.assertEquals('Paris', itinerary.destination, 'Destination should match');
        System.assertEquals(Date.newInstance(2024, 8, 20), itinerary.startdate, 'Start date should match');
        System.assertEquals(Date.newInstance(2024, 8, 21), itinerary.enddate, 'End date should match');
    }

    @IsTest
    static void testActivityCreation() {
        Contact traveler = [SELECT Id FROM Contact WHERE LastName = 'Doe' LIMIT 1];

        Test.setMock(HttpCalloutMock.class, new ModelsAPICalloutMock());

        GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput testInput = new GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput();
        testInput.destination = 'Paris';
        testInput.traveler = traveler;

        List<GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput> inputList = new List<GenerateActivitiesViaSFAPInvocable.ApexWithMultipleInput> { testInput };

        Test.startTest();
        List<Itinerary__c> itineraries = GenerateActivitiesViaSFAPInvocable.getActivitiesList(inputList);
        Test.stopTest();

        List<TravelActivity__c> activities = [SELECT Id, Name, Location__c, outdoor__c FROM TravelActivity__c];
        System.assertNotEquals(0, activities.size(), 'At least one activity should be created');
        System.assertEquals('Visit Eiffel Tower', activities[0].Name, 'First activity name should match');
        System.assertEquals('Eiffel Tower', activities[0].Location__c, 'First activity location should match');
    }
}