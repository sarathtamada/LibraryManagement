public with sharing class Trains {

    public String colour { get; set; }

    public PageReference changeBank() {
                        
          PageReference page=new PageReference('https://ap1.salesforce.com/a0N/e?retURL=%2Fa0N%2Fo');
          page.setRedirect(true);   
          return page;
    }
    
    //public String Bank;

public List<SelectOption> getItems()
{
 List<SelectOption> Options =new List<SelectOption>();
 options.add(new SelectOption( 'None' , 'Select Bank'));
 options.add(new SelectOption( 'SBI' , 'SBI'));
 options.add(new SelectOption( 'ICICI' , 'ICICI'));
 options.add(new SelectOption( 'HDFC' , 'HDFC'));
 options.add(new SelectOption( 'IDBI' , 'IDBI'));
 return options;
 }


    public String items { get; set; }

    public String Bank { get; set; }
}