public with sharing class login {

    public String Password { get; set; }

    public String Username { get; set; }
    
     //testing for login github
    public PageReference login() {
    
          PageReference page=new PageReference('https://ap1.salesforce.com/a0N/e?retURL=%2Fa0N%2Fo');
          page.setRedirect(true);   
          return page;
    }
    
    //testing for signup github
    public PageReference signup() {
    
     PageReference pages=new PageReference('https://c.ap1.visual.force.com/apex/Registration');
          pages.setRedirect(true);   
          return pages;
        
    }
}