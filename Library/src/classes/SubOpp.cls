public class SubOpp {
    
    public String subOpportunityName {get;set;}
    public Date closeDate{get;set;}
    public String selectedStage{ get;set;}
    public String subTypes {get;set;}
   public String stages{get;set;}
   
    public String selectedType{get;set;}
   
    private Opportunity MyOpportunity{get;set;}
    
    public string name{get;set;}

    public SubOpp(ApexPages.StandardController controller) {
    
        MyOpportunity = new Opportunity();
            
        List<SelectOption> subTypes=new List<SelectOption>();
        
        Id id=ApexPages.currentPage().getParameters().get('id');
        MyOpportunity=[select Opportunity_Type__c from opportunity where id=:id];
       
        if(MyOpportunity.Opportunity_Type__c.equalsIgnoreCase('Banking'))
        {
            subTypes.add(new SelectOption('Checking','Checking'));
            subTypes.add(new SelectOption('Saving','Saving'));
        }
        else if(MyOpportunity.Opportunity_Type__c.equalsIgnoreCase('Credit Card'))
        {
            subTypes.add(new SelectOption('Master','Master'));
            subTypes.add(new SelectOption('Visa','Visa'));
            subTypes.add(new SelectOption('Amex','Amex'));
        }
        else if(MyOpportunity.Opportunity_Type__c.equalsIgnoreCase('Loan'))
        {
            Id profileId= UserInfo.getProfileId();
            Profile profile=[Select name from profile where Id =:profileId Limit 1];
            if(profile.Name.equalsIgnoreCase('Sales Master'))
            {
                subTypes.add(new SelectOption('Auto','Auto'));
                subTypes.add(new SelectOption('Personal','Personal'));
            }
            else if(profile.Name.equalsIgnoreCase('Sales Person'))
            {
                subTypes.add(new SelectOption('Housing','Housing'));
                subTypes.add(new SelectOption('Personal','Personal'));
            }
        }
        List<SelectOption> stages=new List<SelectOption>();
        {
            stages.add(new SelectOption('None','None'));
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
     }
        public void createNewSubOpportunity()
    {
        Opportunity subOpportunity=new Opportunity();
        subOpportunity=MyOpportunity.clone(false);
    /* subOpportunity.Name=this.subOpportunityName;
        subOpportunity.Stage=this.selectedStage;
        subOpportunity.CloseDate=this.closeDate;
        subOpportunity.Opportunity_Type__c=this.selectedOpportunity_Type__c;
        subOpportunity.Sub_Type__c=this.selectedType; 
        subOpportunity.Name=Name;
        subOpportunity.CloseDate=CloseDate;
        
        subOpportunity.selectedStage=selectedStage;
        
        subOpportunity.SubOpportunityType__c=SubOpportunityType__c; */
        subOpportunity.Parent_Oportunity__c=ApexPages.currentPage().getParameters().get('id');
        
        insert subOpportunity;
    } 
    

}