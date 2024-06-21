public class SimpsonsData1 {
    // Create data class. exists simple to create data used in the transactional Security demo from static resource file.
    // https://salesforce.vidyard.com/watch/TGfe2FhCThsbUJS68haeG9?&_gl=1*2tys8a*_ga*Mzc4ODE4NDkuMTY3MTExMzAwOQ..*_ga_H6M98GGB18*MTY3MTM5NTc2MC41LjEuMTY3MTM5NTc2MS4wLjAuMA..&_ga=2.48409248.700554486.1671394439-37881849.1671113009
    // See Also https://trailhead.salesforce.com/trailblazer-community/groups/0F94S000000GwXk
    // search for Fins Cabin 8 - Shield Event Monitoring you don’t know what you are missing.
    Public static HttpResponse CreateData(){
        
   // List<account> lAcc = [SELECT id FROM Account WHERE name = 'Butler249 Inc'];
    //    If(lAcc.size() <> 0 ) {
   //         System.debug('DATA CREATION ALREADY RUN .......... ABORTING JOB');
    //        HttpResponse res = new HttpResponse();
    //        res.setStatusCode(405);
    //        return res;
    //    }   
        
    StaticResource sr = [SELECT Id, Body,Name FROM StaticResource WHERE Name = 'SimpsonDataPersonAcc' LIMIT 1];
	String body = sr.Body.toString();    
        // Instantiate a new Http object
    Http h = new Http();

    // Instantiate a new HTTP request
    // Specify request properties such as the endpoint, the POST method, etc. 
    HttpRequest req = new HttpRequest();
    //string myUrl = Url.getOrgDomainURL()  + '/services/data/v60.0/composite/tree/personaccount'; 
    string myUrl = 'https://d1q000001eofjuaa.my.salesforce.com/services/data/v60.0/composite/tree/PersonAccount';
    req.setEndpoint(myUrl);
    req.setMethod('POST');
    req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());     
    req.setHeader('Content-Type', 'application/json');
    req.setBody(body);

    // Send the request, and return a response
    HttpResponse res = h.send(req);
    System.debug(res.getBody());
    System.debug(res.getStatusCode());
    return res;    
  }    
}