@isTest
public class SetupAssistantControllerTest {

    @isTest
    static void testGetBotDefinitionId_Success() {
        Test.startTest();
        // Call the method with any label since it's mocked.
        String result = SetupAssistantController.getBotDefinitionId('Test Bot');
        
        // Verify the result matches the mock value.
        System.assertEquals('123456789012345678', result, 'Mock ID should be returned.');
        Test.stopTest();
    }

    @isTest
    static void testApexId_Success() {
        Test.startTest();
        // Call the method with any label since it's mocked.
        String result = SetupAssistantController.getApexClassId('Test Apex');
        
        // Verify the result matches the mock value.
        System.assertEquals('123456789012345678', result, 'Mock ID should be returned.');
        Test.stopTest();
    }

    @isTest
    static void testContentDocId_Success() {
        Test.startTest();
        // Call the method with any label since it's mocked.
        String result = SetupAssistantController.getContentDocumentId('Test Content Doc');
        
        // Verify the result matches the mock value.
        System.assertEquals('123456789012345678', result, 'Mock ID should be returned.');
        Test.stopTest();
    }

    @isTest public static void testisActiveScratchOrg(){
        TEST.startTest(); 
        Boolean isActiveScratchOrg = SetupAssistantController.isActiveScratchOrg();
        system.assertNotEquals(null, isActiveScratchOrg);
        TEST.stopTest(); 
    }

    @isTest
    static void testGetOrgCountryCode() {
        // Call the method to get the country code.
        String countryCode = SetupAssistantController.getOrgCountryCode();

        // Retrieve the existing country code from the Organization object directly.
        Organization org = [SELECT Country FROM Organization LIMIT 1];

        // Assert that the method's output matches the value in the Organization object.
        System.assertEquals(org.Country, countryCode);
    }

}