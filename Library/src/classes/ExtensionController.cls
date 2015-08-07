public with sharing class ExtensionController{
Public Opportunity opp      {get;set;}
 public ApexPages.StandardController standardCon;
 
 public ExtensionController(ApexPages.StandardController con){
 standardCon = con;
 }
 
 public void populateRelAccFields(){
 Opportunity opp = (Opportunity) standardCon.getRecord();
 opp.Account = [select Phone, Type from Account where id =: opp.AccountId];
 }
}