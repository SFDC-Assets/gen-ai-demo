public with sharing class BurnsTest {
    
    @AuraEnabled
    public static String generate(String contactId) {

        ConnectApi.EinsteinPromptTemplateGenerationsInput promptGenerationsInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
        Map<String, ConnectApi.WrappedValue> inputParams = new Map<String, ConnectApi.WrappedValue>();
        Map<String, String> productInput = new Map<String, String>();

        productInput.put('id', contactId);
        // Add wrapped values
        ConnectApi.WrappedValue productValueMap = new ConnectApi.WrappedValue();
        productValueMap.value = productInput;
        inputParams.put('Input:Contact', productValueMap);

        promptGenerationsInput.inputParams = inputParams;
        promptGenerationsInput.additionalConfig                = new ConnectApi.EinsteinLlmAdditionalConfigInput();
        promptGenerationsInput.additionalConfig.numGenerations = 1;
        promptGenerationsInput.additionalConfig.maxTokens      = 10000;
        promptGenerationsInput.additionalConfig.model          = 'gpt-35-turbo';
        promptGenerationsInput.additionalConfig.enablePiiMasking  = false;
        promptGenerationsInput.additionalConfig.applicationName   = 'PromptBuilderPreview';
        
        promptGenerationsInput.isPreview = false;
        promptGenerationsInput.inputParams = inputParams;

        return EinsteinGenerativeGatewayService.getPromptTemplateResponse('Burns_test', promptGenerationsInput);
    }
}