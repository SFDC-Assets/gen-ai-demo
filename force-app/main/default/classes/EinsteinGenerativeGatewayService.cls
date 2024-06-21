public with sharing class EinsteinGenerativeGatewayService {
    
    public static String getPromptTemplateResponse(String promptTemplateDeveloperName, ConnectApi.EinsteinPromptTemplateGenerationsInput input) {
        
        try{
            // Call the service
            ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate(promptTemplateDeveloperName, input);
            
            // Consume response
            ConnectApi.EinsteinLLMGenerationItemOutput response = generationsOutput.generations[0];
            //System.debug('Response: ' + response.text);
            return response.text;
        } catch(exception e){
            System.debug( 'ERROR EinsteinGenerativeGatewayService catch exception line' );
            throw new EinsteinGenerativeGatewayException(e.getMessage());
        } 
    }
    
    public class EinsteinGenerativeGatewayException extends Exception {}
    
    
}

/*
*
public with sharing class EinsteinGenerativeGatewayService {

    public static String getPromptTemplateResponse(String promptTemplateDeveloperName, ConnectApi.EinsteinPromptTemplateGenerationsInput input) {

      try{
         // Call the service
         ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate(promptTemplateDeveloperName, input);

         // Consume response
         ConnectApi.EinsteinLLMGenerationItemOutput response = generationsOutput.generations[0];
         System.debug('Response: ' + response.text);
         return response.text;
      } catch(exception e){
          throw new EinsteinGenerativeGatewayException(e.getMessage());
      } 
  }

  public class EinsteinGenerativeGatewayException extends Exception {}

    
}
*/