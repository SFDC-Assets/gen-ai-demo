global class GenerateActivitiesViaSFAPInvocable {
    @InvocableMethod(label='Generate Trip Itinerary' description='Generate Trip itinerary based on a destination')
    public static List<Itinerary__c> getActivitiesList(List<ApexWithMultipleInput> ids ) {
       // Step 1 Initialize the lists
        List<Itinerary__c> Itinerarylist = new List<Itinerary__c>();
        List<TravelActivity__C> actlist = new List<TravelActivity__c>();
        
        
        //Step 2 : get the json from models api
        String jsonstring=  getJsonFromPrompt(ids[0].destination, ids[0].traveler);
       
        // Step 3: read the json 
        Itinerary itinerary = parseItinerary(jsonString);
             
        // Step 4: insert record
        // Create the Itinerary sObject 
        
        Itinerary__c itin = new Itinerary__c(destination__c=itinerary.destination, contact__c=ids[0].traveler.id,status__c='Planned',start_date__c=itinerary.startdate, end_date__c=itinerary.enddate,accommodation__c=itinerary.accommodation, transportation__c= itinerary.transportation);
        // Insert the account by using DML
        insert itin;
        // Get the new ID on the inserted sObject argument
        ID itinID = itin.Id;
        Itinerarylist.add(itin);
        for (Activity act : itinerary.activities) {
            TravelActivity__c TA = new TravelActivity__c(itinerary__c=itinID, name=act.name,status__c='Planned', outdoor__c=Boolean.valueOf(act.outdoor), date__c=act.localdate,time__c=act.localtime, location__c=act.location );
            actList.add(TA);
        }
        insert actList;
        return Itinerarylist;
    }
    public static String getJsonFromPrompt(String destination, Contact c){
         // Query the TravelerProfile related to the Contact
        // Query the Contact to get the related TravelerProfile
        Contact c1 = [
            SELECT Id, Traveler_Profile__c, Traveler_Profile__r.Interests__c, Traveler_Profile__r.Special_Requirements__c
            FROM Contact
            WHERE Id = :c.Id
            LIMIT 1
        ];
        
 String prompt = 'You are helping a travel agent plan the best itinerary for a traveler\'s upcoming trip to '+ destination+'. The traveler has shared their profile and interests with you. '
  + 'Ensure the itinerary aligns with the traveler\'s preferences and interests as listed here: '
 + c1.Traveler_Profile__r.Interests__c + '. '
  + 'Traveler has special requirements: '
 + c1.Traveler_Profile__r.Special_Requirements__c + '. '
  + 'Based on this information, provide an itinerary that includes accommodation options, must-visit attractions, local experiences, dining recommendations, and transportation activities. Show only three activities. '
  + 'Generate a JSON output with the following structure: '
  + '{"itineraryName": "Paris Trip", '
  + '"destination": "Paris", '
  + '"startDate": "2024-08-20", '
  + '"endDate": "2024-08-21", '
  + '"accommodation": "Paris Boutique Hotel", '
  + '"transportation": "Paris Rails", '
  + '"activities": ['
  + '{"name": "Visit Eiffel Tower", "location": "Eiffel Tower", "localdate": "2024-08-20", "localtime": "09:00", "Outdoor": true}]}';
      
      //Generate the activities via Models API 
     String activity = GenerateActivitiesviaModelsAPI.generateText(prompt);
        //## Sample JSON structure of the activity returned by the abive call
        String samplectivity = '{"itineraryName": "Paris Trip", "destination": "Paris", "startDate": "2024-08-20", "endDate": "2024-08-21", "accommodation": "Paris Boutique Hotel", "transportation": "Paris Rails",'+
            '"activities":[{"name": "Visit Louvre Museum", "location": "Louvre Museum", "localdate": "2024-08-20","localtime": "10:00","outdoor": false},'+
            ' { "name": "Explore Montmartre", "location": "Montmartre",  "localdate": "2024-08-20",  "localtime": "14:00", "outdoor": true},'+
            '{ "name": "Dine at Le Potager du Marais", "location": "Le Potager du Marais", "localdate": "2024-08-20", "localtime": "19:00", "outdoor": false } ]}';            
    
       return activity;  
       //return sampleactivity; 
        
    }
    
    
    
    // Inner classes used for serialization by the parser. 
    
    public class Itinerary {
        public String itineraryName;
        public String destination;
        public Date startDate;
        public Date endDate;
        public String accommodation;
        public String transportation;
        public List<Activity> activities;
        
        public Itinerary(String itineraryName, String status, String dest, Date stdt, Date enddt,String acco, String transport, List<Activity> actList) {
            itineraryName = itineraryName;
            destination = dest;
            startdate = stdt;
            enddate=enddt;
            accommodation = acco;
            transportation = transport; 
            status= status;       
            activities = actList;
        }
    }
    public class Activity {
        public String name;
        public String location;
        public Date localdate;
        public String localtime;
        public Boolean outdoor;
        public String status;
        
        public Activity(String name, String location, Date localdate, String localtime, Boolean outdoor,String status) {
            name = name;
            location = location;
            localdate = localdate;
            localtime=localtime;
            outdoor = outdoor;
            status= status;       
        }
   
  }
    // Method to parse JSON string into an Itinerary object
    public static Itinerary parseItinerary(String jsonStr) {
        
        // Parse JSON string into Itinerary object
        Itinerary itinerary = (Itinerary)JSON.deserialize(jsonStr, Itinerary.class);
        
        return itinerary;
        
    }
   public class ApexWithMultipleInput {
        @InvocableVariable(description='Destination')
        public String destination;
        @invocableVariable(description='Traveler')
        public Contact traveler;
        
    }
}