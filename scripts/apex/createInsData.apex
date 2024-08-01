Account singh = [SELECT Id,PersonContactId FROM Account WHERE Name='Kiran Singh'];
Account frost = [SELECT Id,PersonContactId FROM Account WHERE Name='Anne Frost'];
Account johnson = [SELECT Id,PersonContactId FROM Account WHERE Name='Will Johnson'];
Account welch = [SELECT Id,PersonContactId FROM Account WHERE Name='Mike Welch'];

List<InsurancePolicy> policies = new List<InsurancePolicy>();

policies.add(new InsurancePolicy(Name='Auto Policy',PolicyType='Auto',Status='Initial',Substatus='Draft',
EffectiveDate=Date.newInstance(2023, 05, 05),ExpirationDate=Date.newInstance(2024, 05, 05),
SaleDate=Date.newInstance(2023, 05, 05),RenewalDate=Date.newInstance(2024, 05, 05),
UniversalPolicyNumber='110-3948543',PolicyName='Auto Policy',policyterm='Annual',NameInsuredId=singh.Id,
StandardFeeAmount=100,StandardPremiumAmount=1000,StandardTaxAmount=100,
vlocity_ins_fsc__PremiumCalculationMethod__c='Daily',vlocity_ins_fsc__PremiumPaymentType__c='Advance',
PremiumAmount=1200,GrossWrittenPremium=1200,
PolicyDescription=''));

policies.add(new InsurancePolicy(Name='Auto Policy',PolicyType='Auto',Status='Initial',Substatus='Draft',
EffectiveDate=Date.newInstance(2023, 04, 30),ExpirationDate=Date.newInstance(2024, 04, 15),
SaleDate=Date.newInstance(2023, 02, 29),RenewalDate=Date.newInstance(2024, 02, 29),
UniversalPolicyNumber='110-49584304',PolicyName='Auto Policy',policyterm='Annual',NameInsuredId=frost.Id,
StandardFeeAmount=200,StandardPremiumAmount=1500,StandardTaxAmount=150,
vlocity_ins_fsc__PremiumCalculationMethod__c='Daily',vlocity_ins_fsc__PremiumPaymentType__c='Advance',
PremiumAmount=2400,GrossWrittenPremium=2400,
PolicyDescription=''));

policies.add(new InsurancePolicy(Name='Home Policy Premium',PolicyType='Home',Status='In Force',Substatus='Published',
EffectiveDate=Date.newInstance(2024, 04, 30),ExpirationDate=Date.newInstance(2025, 04, 15),
SaleDate=Date.newInstance(2024, 02, 29),RenewalDate=Date.newInstance(2025, 02, 29),
UniversalPolicyNumber='111-349583456',PolicyName='Home Policy Premium',policyterm='Annual',NameInsuredId=frost.Id,
StandardFeeAmount=1000,StandardPremiumAmount=10000,StandardTaxAmount=1000,
vlocity_ins_fsc__PremiumCalculationMethod__c='Daily',vlocity_ins_fsc__PremiumPaymentType__c='Advance',
PremiumAmount=10000,GrossWrittenPremium=12000,
PolicyDescription=''));

policies.add(new InsurancePolicy(Name='Gold Auto Policy',PolicyType='Auto',Status='In Force',Substatus='Published',
EffectiveDate=Date.newInstance(2024, 04, 16),ExpirationDate=Date.newInstance(2025, 04, 18),
SaleDate=Date.newInstance(2024, 02, 23),RenewalDate=Date.newInstance(2025, 02, 23),
UniversalPolicyNumber='110-394853454',PolicyName='Auto Policy',policyterm='Annual',NameInsuredId=frost.Id,
StandardFeeAmount=34,StandardPremiumAmount=45645,StandardTaxAmount=345,
vlocity_ins_fsc__PremiumCalculationMethod__c='Daily',vlocity_ins_fsc__PremiumPaymentType__c='Advance',
PremiumAmount=3465,GrossWrittenPremium=5685,
PolicyDescription=''));

policies.add(new InsurancePolicy(Name='Home Policy',PolicyType='Home',Status='Initial',Substatus='Draft',
EffectiveDate=Date.newInstance(2023, 10, 19),ExpirationDate=Date.newInstance(2024, 11, 15),
SaleDate=Date.newInstance(2023, 10, 18),RenewalDate=Date.newInstance(2024, 11, 20),
UniversalPolicyNumber='111-349584524',PolicyName='Home Policy',policyterm='Annual',NameInsuredId=johnson.Id,
StandardFeeAmount=400,StandardPremiumAmount=4000,StandardTaxAmount=600,
vlocity_ins_fsc__PremiumCalculationMethod__c='Daily',vlocity_ins_fsc__PremiumPaymentType__c='Advance',
PremiumAmount=4000,GrossWrittenPremium=4000,
PolicyDescription=''));

policies.add(new InsurancePolicy(Name='Home Policy',PolicyType='Home',Status='Initial',Substatus='Draft',
EffectiveDate=Date.newInstance(2023, 04, 30),ExpirationDate=Date.newInstance(2024, 04, 15),
SaleDate=Date.newInstance(2023, 02, 29),RenewalDate=Date.newInstance(2024, 02, 29),
UniversalPolicyNumber='111-345983454',PolicyName='Home Policy',policyterm='Annual',NameInsuredId=welch.Id,
StandardFeeAmount=300,StandardPremiumAmount=3000,StandardTaxAmount=150,
vlocity_ins_fsc__PremiumCalculationMethod__c='Daily',vlocity_ins_fsc__PremiumPaymentType__c='Advance',
PremiumAmount=3000,GrossWrittenPremium=3000,
PolicyDescription=''));

insert policies;

// List<PersonLifeEvent> lifeEvents = new List<PersonLifeEvent>();

// lifeEvents.add(new PersonLifeEvent(Name='Birth',EventType='Birth',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(1996, 03, 15)));
// lifeEvents.add(new PersonLifeEvent(Name='Baby: Saira Singh',EventType='Baby',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2023, 06, 06)));
// lifeEvents.add(new PersonLifeEvent(Name='Baby: Virat Singh',EventType='Baby',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2021, 08, 28)));
// lifeEvents.add(new PersonLifeEvent(Name='College Graduation',EventType='Graduation',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2017, 05, 30)));
// lifeEvents.add(new PersonLifeEvent(Name='Married to Virat',EventType='Marriage',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2017, 10, 10)));
// lifeEvents.add(new PersonLifeEvent(Name='Moved to NYC',EventType='Relocation',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2018, 04, 09)));
// lifeEvents.add(new PersonLifeEvent(Name='Opened Pharmacy',EventType='Job',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2018, 07, 28)));
// lifeEvents.add(new PersonLifeEvent(Name='Purchased Home',EventType='Home',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2020, 05, 02)));
// lifeEvents.add(new PersonLifeEvent(Name='Tesla Model Y',EventType='Car',PrimaryPersonId=singh.PersonContactId,EventDate=Date.newInstance(2021, 04, 04)));

// insert lifeEvents;

InsurancePolicy anneAutoPolicy = [SELECT Id FROM InsurancePolicy WHERE Name='Gold Auto Policy'];
InsurancePolicy anneHomePolicy = [SELECT Id FROM InsurancePolicy WHERE Name='Home Policy Premium'];

List<InsurancePolicyAsset> assets = new List<InsurancePolicyAsset>();

assets.add(new InsurancePolicyAsset(AssetName='Tesla Model Y',InsurancePolicyId=anneAutoPolicy.Id));
assets.add(new InsurancePolicyAsset(AssetName='Home building',InsurancePolicyId=anneAutoPolicy.Id));
assets.add(new InsurancePolicyAsset(AssetName='Tesla Model Y',InsurancePolicyId=anneAutoPolicy.Id));

insert assets;

List<Claim> claims = new List<Claim>();

claims.add(new Claim(Name='394854', AccountId=frost.Id, EstimatedAmount=39485,ActualAmount=34958,ApprovedAmount=34584,Severity='Low',
Status='Closed',FnolChannel='Phone',ClaimType='Auto',LossType='Repairs',PolicyNumberId=anneAutoPolicy.id));

claims.add(new Claim(Name='4578567', AccountId=frost.Id, EstimatedAmount=386567,ActualAmount=348654,ApprovedAmount=486654,Severity='High',
Status='Closed',FnolChannel='Phone',ClaimType='Auto',LossType='Repairs',PolicyNumberId=anneAutoPolicy.id));

claims.add(new Claim(Name='4545656', AccountId=frost.Id, EstimatedAmount=4678,ActualAmount=789675,ApprovedAmount=19865,Severity='Med',
Status='Closed',FnolChannel='Phone',ClaimType='Auto',LossType='Repairs',PolicyNumberId=anneAutoPolicy.id));

claims.add(new Claim(Name='2467545', AccountId=frost.Id, EstimatedAmount=45746,ActualAmount=5674,ApprovedAmount=78967,Severity='Low',
Status='Closed',FnolChannel='Phone',ClaimType='Auto',LossType='Repairs',PolicyNumberId=anneAutoPolicy.id));

claims.add(new Claim(Name='5678567', AccountId=frost.Id, EstimatedAmount=345645,ActualAmount=5678,ApprovedAmount=678967,Severity='Low',
Status='Closed',FnolChannel='Phone',ClaimType='Home',LossType='Repairs',PolicyNumberId=anneHomePolicy.id));

insert claims;