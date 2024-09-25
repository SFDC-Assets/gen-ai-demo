Id personAccountRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

Id HouseholdRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('IndustriesHousehold').getRecordTypeId();

List<Account> personAccounts = new List<Account>();

personAccounts.add(new Account(FirstName='Kiran',LastName='Singh',RecordTypeId=personAccountRecordTypeId,BillingStreet='10 Bay Street',BillingCity='Toronto',BillingState='ON',BillingPostalCode='M5J 2S3',BillingCountry='Canada',ShippingStreet='10 Bay Street',ShippingCity='Toronto',ShippingState='ON',ShippingPostalCode='M5J 2S3',ShippingCountry='Canada',Phone='(416) 555-7410',PersonMobilePhone='6471203214',PersonTitle='Small Business Owner',PersonBirthdate=date.parse('4/17/1990'),PersonEmail='kiran.singh@example.com',Type='Customer - Direct',Industry='Other',FinServ__LastInteraction__c=date.parse('4/17/2023'),FinServ__NextInteraction__c=date.parse('10/17/2024')));

personAccounts.add(new Account(FirstName='Saira',LastName='Singh',RecordTypeId=personAccountRecordTypeId,BillingStreet='10 Bay Street',BillingCity='Toronto',BillingState='ON',BillingPostalCode='M5J 2S3',BillingCountry='Canada',ShippingStreet='10 Bay Street',ShippingCity='Toronto',ShippingState='ON',ShippingPostalCode='M5J 2S3',ShippingCountry='Canada',Phone='(416) 555-7410',PersonMobilePhone='3495854349',PersonTitle='Small Business Owner',PersonBirthdate=date.parse('4/17/2010'),PersonEmail='saira.singh@example.com',Type='Customer - Direct',Industry='Other',FinServ__LastInteraction__c=date.parse('4/17/2023'),FinServ__NextInteraction__c=date.parse('10/17/2024')));

personAccounts.add(new Account(FirstName='Vishal',LastName='Singh',RecordTypeId=personAccountRecordTypeId,BillingStreet='10 Bay Street',BillingCity='Toronto',BillingState='ON',BillingPostalCode='M5J 2S3',BillingCountry='Canada',ShippingStreet='10 Bay Street',ShippingCity='Toronto',ShippingState='ON',ShippingPostalCode='M5J 2S3',ShippingCountry='Canada',Phone='(416) 555-7410',PersonMobilePhone='3495854349',PersonTitle='Small Business Owner',PersonBirthdate=date.parse('4/17/2012'),PersonEmail='vishal.singh@example.com',Type='Customer - Direct',Industry='Other',FinServ__LastInteraction__c=date.parse('4/17/2023'),FinServ__NextInteraction__c=date.parse('10/17/2024')));

personAccounts.add(new Account(FirstName='Virat',LastName='Singh',RecordTypeId=personAccountRecordTypeId,BillingStreet='10 Bay Street',BillingCity='Toronto',BillingState='ON',BillingPostalCode='M5J 2S3',BillingCountry='Canada',ShippingStreet='10 Bay Street',ShippingCity='Toronto',ShippingState='ON',ShippingPostalCode='M5J 2S3',ShippingCountry='Canada',Phone='(416) 555-7410',PersonMobilePhone='3495854349',PersonTitle='Small Business Owner',PersonBirthdate=date.parse('4/17/2000'),PersonEmail='virat.singh@example.com',Type='Customer - Direct',Industry='Other',FinServ__LastInteraction__c=date.parse('4/17/2023'),FinServ__NextInteraction__c=date.parse('10/17/2024')));

personAccounts.add(new Account(Name='Singh Household',RecordTypeId=HouseholdRecordTypeId));

insert personAccounts;

List<FinServ__AccountAccountRelation__c> acctRelationships = new List<FinServ__AccountAccountRelation__c>();
List<Account> singhs = [SELECT Id,Name FROM Account WHERE Name IN ('Kiran Singh','Saira Singh','Vishal Singh','Virat Singh')];

String householdId = [SELECT Id FROM Account WHERE Name='Singh Household' LIMIT 1].Id;
String roleId = [SELECT Id FROM FinServ__ReciprocalRole__c WHERE Name='Proprietor' LIMIT 1].Id;

for (Account acct : singhs) {
    acctRelationships.add(new FinServ__AccountAccountRelation__c(FinServ__Account__c=acct.Id,FinServ__Active__c=true,FinServ__RelatedAccount__c=householdId,FinServ__Role__c=roleId));
}

insert acctRelationships;