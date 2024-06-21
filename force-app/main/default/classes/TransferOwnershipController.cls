public with sharing class TransferOwnershipController {
    // Method to transfer ownership of all accounts, related opportunities, and cases to the current user
    @AuraEnabled
    public static void transferOwnershipToCurrentUser() {
        // Get the current user's ID
        Id currentUserId = UserInfo.getUserId();
        
        List<Account> allAccounts = [SELECT Id FROM Account];
        List<Case> allCases = [SELECT Id FROM Case];
        List<Opportunity> allOpps = [SELECT Id FROM Opportunity];
        List<Lead> allLeads = [SELECT Id FROM Lead WHERE LeadType__c != null];

        
        for(Account r: allAccounts){
            r.OwnerId = currentUserId;
        }
        
        if(!allAccounts.isEmpty()) {
            update allAccounts;
        }
        
        for(Case c: allCases){
            c.OwnerId = currentUserId;
        }
        
        if(!allCases.isEmpty()) {
            update allCases;
        }
        
        for(Opportunity o: allOpps){
            o.OwnerId = currentUserId;
        }
        
        if(!allOpps.isEmpty()) {
            update allOpps;
        }
        
        for(Lead l: allLeads){
            l.OwnerId = currentUserId;
        }
        
        if(!allLeads.isEmpty()) {
            update allLeads;
        }
    }
}