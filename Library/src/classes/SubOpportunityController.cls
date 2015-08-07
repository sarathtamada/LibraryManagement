public class SubOpportunityController {
    public String subOpportunityName {get;set;}
    public Date closeDate{get;set;}
    public String selectedStage{ get;set;}
    public List<SelectOption> subTypes {get;set;}
    public List<SelectOption> stages{get;set;}
    private Opportunity opportunity;
    public String selectedType{get;set;}
    
    public SubOpportunityController(ApexPages.StandardController controller){
         subTypes=new List<SelectOption>();
        stages=new List<SelectOption>();
        Id id=ApexPages.currentPage().getParameters().get('id');
        //opportunity=[select name,Amount,CloseDate,ExpectedRevenue,ForecastCategoryName,Sub_Type__c,LeadSource,NextStep,IsPrivate,Probability,TotalOpportunityQuantity,StageName,Parent_Opportunity__c  from opportunity where id=:id];
        opportunity=[select Type from opportunity where id=:id];
        System.debug('SubOpportunityController.Opportunity   : '+opportunity);
        if(opportunity.Type.equalsIgnoreCase('Banking')){
            subTypes.add(new SelectOption('Checking','Checking'));
            subTypes.add(new SelectOption('Saving','Saving'));
        }
        else if(opportunity.Type.equalsIgnoreCase('Credit Card')){
            subTypes.add(new SelectOption('Master','Master'));
            subTypes.add(new SelectOption('Visa','Visa'));
            subTypes.add(new SelectOption('Amex','Amex'));
        }
        else if(opportunity.Type.equalsIgnoreCase('Loan')){
            Id profileId= UserInfo.getProfileId();
            Profile profile=[Select name from profile where Id =:profileId Limit 1];
            if(profile.Name.equalsIgnoreCase('Sales Master')){
                subTypes.add(new SelectOption('Auto','Auto'));
                subTypes.add(new SelectOption('Personal','Personal'));
            }
            else if(profile.Name.equalsIgnoreCase('Sales Person')){
                subTypes.add(new SelectOption('Housing','Housing'));
                subTypes.add(new SelectOption('Personal','Personal'));
            }
        }
        
        stages.add(new SelectOption('Prospecting','Prospecting'));
        stages.add(new SelectOption('Qualification','Qualification'));
        stages.add(new SelectOption('Needs Analysis','Needs Analysis'));
        stages.add(new SelectOption('Value Proposition','Value Proposition'));
        stages.add(new SelectOption('Id. Decision Maker','Id. Decision Maker'));
        stages.add(new SelectOption('Perception Analysis','Perception Analysis'));
        stages.add(new SelectOption('Proposal/PriceQuote','Proposal/PriceQuote'));
        stages.add(new SelectOption('Negotiation/Review','Negotiation/Review'));
        stages.add(new SelectOption('ClosedWon','ClosedWon'));
        stages.add(new SelectOption('ClosedLost','ClosedLost'));
        
    }
    
    public SubOpportunityController(){
       
        
    }
    
    public void createSubOpportunity(){
        Opportunity subOpportunity= new opportunity();
        subOpportunity.Name=this.subOpportunityName;
        subOpportunity.CloseDate=this.closeDate;
        subOpportunity.StageName=this.selectedStage;
        subOpportunity.Sub_Type__c=this.selectedType;
        subOpportunity.Parent_Oportunity__c=ApexPages.currentPage().getParameters().get('id');
        
        insert subOpportunity;
        if(opportunity.Opportunity_Type__c == NULL)
        {
           Apexpages.addMessage( new ApexPages.Message (ApexPages.Severity.ERROR, 'Opportunity Type field is must be selected. '));
        }
    }
    
    
    
}