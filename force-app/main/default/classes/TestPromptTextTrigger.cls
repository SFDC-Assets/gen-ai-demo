@isTest
private class TestPromptTextTrigger {
    
    // Helper method to create a Template_Text__c record
    private static Template_Text__c createTestRecord(String templateType, String apiName) {
        return new Template_Text__c(
            Template_Type__c = templateType,
            API_Name__c = apiName
        );
    }
    
    // Test method for 'Prompt' picklist value
    @isTest static void testTemplateTextTriggerWithPrompt() {
        // Create test data with 'Prompt' picklist value
        string name1 = '';
        string name2 = '';
        Template_Text__c testRecordPrompt = createTestRecord('Prompt', 'APIExample1');
        
        Test.startTest();
        insert testRecordPrompt;
        Template_Text__c insertedRecordPrompt = [SELECT Name,Template_Type__c FROM Template_Text__c WHERE Id = :testRecordPrompt.Id];
        name1 = insertedRecordPrompt.name;
        insertedRecordPrompt.Template_Type__c = 'Copilot Action';
        update insertedRecordPrompt;
        Test.stopTest();
        insertedRecordPrompt = [SELECT Name FROM Template_Text__c WHERE Id = :testRecordPrompt.Id];
        name2 = insertedRecordPrompt.name;
  
        System.assertEquals('Prompt:- APIExample1', name1, 'The Name field is not correctly concatenated on insert for Prompt.');
 
        System.assertEquals('Copilot Action:- APIExample1', name2, 'The Name field is not correctly concatenated on update after changing picklist value.');
    }  
}