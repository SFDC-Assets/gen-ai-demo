public with sharing class GetHerokuData {
    // This is the method that can be called by a Flow
    @InvocableMethod(label='Make API Callout' description='Makes a callout to the Heroku API endpoint')
    public static List<ResponseWrapper> makeCallout(List<RequestWrapper> requests) {
        // Assuming there's only one request from the flow for simplicity
        RequestWrapper request = requests[0];
        
        // Prepare the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Heroku/' + request.endpoint); //Named Credential must be named 'Heroku', otherwise change 'callout:Heroku' to your Named Credential's name
        req.setMethod('GET');
        req.setTimeout(120000); // Set timeout to 2 minutes just in case
        
        // Make the callout
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        // Prepare the response to return to the Flow
        ResponseWrapper response = new ResponseWrapper();
        response.statusCode = res.getStatusCode();
        response.body = res.getBody();
        
        return new List<ResponseWrapper>{response};
    }
    
    // This class is used to receive input from the Flow
    public class RequestWrapper {
        @InvocableVariable(label='Endpoint' required=true)
        public String endpoint;
    }
    
    // This class is used to send the response back to the Flow
    public class ResponseWrapper {
        @InvocableVariable(label='Status Code')
        public Integer statusCode;
        
        @InvocableVariable(label='Response Body')
        public String body;
    }
}