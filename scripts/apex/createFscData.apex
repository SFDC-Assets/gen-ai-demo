//Account Record Types
Id personAccountRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

Id HouseholdRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('IndustriesHousehold').getRecordTypeId();

//Financial Account Record Types
Id bankAccountRecordTypeId =  Schema.SObjectType.FinServ__FinancialAccount__c.getRecordTypeInfosByDeveloperName().get('Bank Account').getRecordTypeId();

Id investmentAccountRecordTypeId =  Schema.SObjectType.FinServ__FinancialAccount__c.getRecordTypeInfosByDeveloperName().get('Investment Account').getRecordTypeId();



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


//Creating Financial Accounts

Id bankAccountRecordTypeId =  Schema.SObjectType.FinServ__FinancialAccount__c.getRecordTypeInfosByDeveloperName().get('BankingAccount').getRecordTypeId();

Id investmentAccountRecordTypeId =  Schema.SObjectType.FinServ__FinancialAccount__c.getRecordTypeInfosByDeveloperName().get('InvestmentAccount').getRecordTypeId();

String jointOwnerId = [SELECT Id FROM Account WHERE Name='Virat Singh' LIMIT 1].Id;
String primaryOwnerId = [SELECT Id FROM Account WHERE Name='Kiran Singh' LIMIT 1].Id;

List<FinServ__FinancialAccount__c> financialAccounts = new List<FinServ__FinancialAccount__c>();

financialAccounts.add(new FinServ__FinancialAccount__c(Name ='Joint Checking',RecordTypeId=bankAccountRecordTypeId,
                                                       FinServ__Balance__c=103245,FinServ__FinancialAccountNumber__c='5999912345',
                                                       FinServ__FinancialAccountType__c='Checking',FinServ__JointOwner__c=jointOwnerId,
                                                       FinServ__Household__c=householdId,FinServ__OwnerType__c=primaryOwnerId,
                                                       FinServ__Ownership__c='Joint',FinServ__PrimaryOwner__c=primaryOwnerId,
                                                       FinServ__Status__c='Open',FinServ__AccrualFrequency__c='Daily'));
                      
financialAccounts.add(new FinServ__FinancialAccount__c(Name ='High Yield Savings',RecordTypeId=bankAccountRecordTypeId,
                                                       FinServ__Balance__c=52500,FinServ__FinancialAccountNumber__c='5555554321',
                                                       FinServ__FinancialAccountType__c='Savings',FinServ__JointOwner__c=jointOwnerId,
                                                       FinServ__Household__c=householdId,FinServ__OwnerType__c=primaryOwnerId,
                                                       FinServ__Ownership__c='Joint',FinServ__PrimaryOwner__c=primaryOwnerId,
                                                       FinServ__Status__c='Open',FinServ__AccrualFrequency__c='Daily'));
                      
financialAccounts.add(new FinServ__FinancialAccount__c(Name ='The Singh Family Trust Account',RecordTypeId=investmentAccountRecordTypeId,
                                                       FinServ__Balance__c=782388,
                                                       FinServ__FinancialAccountType__c='Managed Account',FinServ__JointOwner__c=jointOwnerId,
                                                       FinServ__Household__c=householdId,FinServ__OwnerType__c=primaryOwnerId,
                                                       FinServ__Ownership__c='Trust',FinServ__PrimaryOwner__c=primaryOwnerId,
                                                       FinServ__Status__c='Open',FinServ__AccrualFrequency__c='Daily'));

financialAccounts.add(new FinServ__FinancialAccount__c(Name ='RESP - Vishal',RecordTypeId=investmentAccountRecordTypeId,
                                                       FinServ__Balance__c=138902,
                                                       FinServ__FinancialAccountType__c='Mutual Fund',
                                                       FinServ__Household__c=householdId,FinServ__OwnerType__c=primaryOwnerId,
                                                       FinServ__Ownership__c='Individual',FinServ__PrimaryOwner__c=primaryOwnerId,
                                                       FinServ__Status__c='Open',FinServ__AccrualFrequency__c='Daily'));

financialAccounts.add(new FinServ__FinancialAccount__c(Name ='RESP - Saira',RecordTypeId=investmentAccountRecordTypeId,
                                                       FinServ__Balance__c=64265,
                                                       FinServ__FinancialAccountType__c='Mutual Fund',
                                                       FinServ__Household__c=householdId,FinServ__OwnerType__c=primaryOwnerId,
                                                       FinServ__Ownership__c='Individual',FinServ__PrimaryOwner__c=primaryOwnerId,
                                                       FinServ__Status__c='Open',FinServ__AccrualFrequency__c='Daily'));
                      
insert financialAccounts;


//Creating Financial Assets & Liabilities

Id assetRecordTypeId =  Schema.SObjectType.FinServ__AssetsAndLiabilities__c.getRecordTypeInfosByDeveloperName().get('NonfinancialAsset').getRecordTypeId();

Id liabilityRecordTypeId =  Schema.SObjectType.FinServ__AssetsAndLiabilities__c.getRecordTypeInfosByDeveloperName().get('Liability').getRecordTypeId();


List<FinServ__AssetsAndLiabilities__c> financialAssetsAndLiabilities = new List<FinServ__AssetsAndLiabilities__c>();

financialAssetsAndLiabilities.add(new FinServ__AssetsAndLiabilities__c(Name ='First Mortgage',RecordTypeId=liabilityRecordTypeId,
                                                                       FinServ__Amount__c=509222,FinServ__AssetsAndLiabilitiesType__c='Mortgage',
                                                                       FinServ__Description__c='For Primary Residence', FinServ__Household__c=householdId,
                                                                       FinServ__JointOwner__c=jointOwnerId,FinServ__OwnerType__c=primaryOwnerId,
                                                                       FinServ__Ownership__c='Joint',FinServ__PrimaryOwner__c=primaryOwnerId
                                                                      
                                                                      ));
                      
financialAssetsAndLiabilities.add(new FinServ__AssetsAndLiabilities__c(Name ='Primary Residence',RecordTypeId=assetRecordTypeId,
                                                                       FinServ__Amount__c=987000,FinServ__AssetsAndLiabilitiesType__c='Real Estate',
                                                                       FinServ__Description__c='Clark Street Property', FinServ__Household__c=householdId,
                                                                       FinServ__JointOwner__c=jointOwnerId,FinServ__OwnerType__c=primaryOwnerId,
                                                                       FinServ__Ownership__c='Joint',FinServ__PrimaryOwner__c=primaryOwnerId                                                 
                                                                      ));
                      
                     
insert financialAssetsAndLiabilities;

//Creating Opportunities
Id opportunityWalletShareRecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('WalletShareOpportunity').getRecordTypeId();

Id opportunityRetirementPlanningRecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('RetirementPlanning').getRecordTypeId();

List<Opportunity> opptys = new List<Opportunity>();

opptys.add(new Opportunity(Name ='Personal Loan - 2100000',RecordTypeId=  opportunityWalletShareRecordTypeId,
                          Description='Cottage Expenses',StageName='Develop Proposal',Amount=2100000,FinServ__Household__c=householdId,
                          Type='New Business',CloseDate=date.parse('1/24/2025'),AccountId = primaryOwnerId
                          ));
                      
opptys.add(new Opportunity(Name ='100K CD - Kiran Singh',RecordTypeId=  opportunityWalletShareRecordTypeId,
                          Description='New funds',StageName='Client Presentation',Amount=697000,FinServ__Household__c=householdId,
                          Type='New Business',CloseDate=date.parse('6/26/2025'),AccountId = primaryOwnerId
                          ));

opptys.add(new Opportunity(Name ='RRSP Rollover 2023',RecordTypeId= opportunityRetirementPlanningRecordTypeId,
                          Description='New funds',StageName='Closed Won',Amount=41000,FinServ__Household__c=householdId,
                          Type='Existing Business',CloseDate=date.parse('5/18/2024'),AccountId = primaryOwnerId
                          ));
                      
                     
insert opptys;
