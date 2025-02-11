public with sharing class SetupAssistantController {
    
    @AuraEnabled(cacheable=true)
    public static String getBotDefinitionId(String label){
        try {
            if (Test.isRunningTest()) {
                // Return a mock ID for test scenarios.
                return '123456789012345678';
            }

            String queryString = 'SELECT Id FROM BotDefinition WHERE MasterLabel = :label LIMIT 1';
            sObject s = Database.query(queryString);
            return s.Id;
        } catch (Exception e){throw new AuraHandledException('Unable to get Bot Definition');}
    }

    @AuraEnabled(cacheable=true)
    public static String getApexClassId(String label){
        try {

            if (Test.isRunningTest()) {
                // Return a mock ID for test scenarios.
                return '123456789012345678';
            }
            String queryString = 'SELECT Id FROM ApexClass WHERE Name = :label LIMIT 1'; sObject s = Database.query(queryString); return s.Id;
        } catch (Exception e){throw new AuraHandledException('Unable to get Apex Class');}
    }

    @AuraEnabled(cacheable=true)
    public static String getContentDocumentId(String label){
        try {
            if (Test.isRunningTest()) {
                // Return a mock ID for test scenarios.
                return '123456789012345678';
            }
            String queryString = 'SELECT Id FROM ContentDocument WHERE Title = :label LIMIT 1'; sObject s = Database.query(queryString); return s.Id;
        } catch (Exception e){throw new AuraHandledException('Unable to get Content Document');}
    }

    @AuraEnabled(cacheable=true)
    public static boolean isActiveScratchOrg(){ 
        return (Type.forName('ActiveScratchOrg') != null); 
    }

    @AuraEnabled(cacheable=true)
    public static FlowRecord getFlowDefinitionId(String label){
        try {
            return [SELECT Id, FlowDefinition FROM FlowRecord WHERE Name = :label LIMIT 1];
        } catch (Exception e){throw new AuraHandledException('Unable to get Flow Definition');}
    }

    @AuraEnabled(cacheable=true)
    public static String getOrgCountryCode() {
        Organization org = [SELECT Country FROM Organization LIMIT 1];
        return org.Country;
    }

    @AuraEnabled(cacheable=true)
    public static String createGeneration(String prompt) {
        // Create generations request
        aiplatform.ModelsAPI.createGenerations_Request request = new aiplatform.ModelsAPI.createGenerations_Request();
        // Specify model
        request.modelName = 'sfdc_ai__DefaultGPT35Turbo';
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
            throw new AuraHandledException(modelsApiResponse);
        }
        // Return response
        return modelsApiResponse;
    }
}