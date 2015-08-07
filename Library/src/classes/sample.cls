global class sample 
{
   // public String accountName { get; set; }
    public static Account account { get; set; }
   // public sample() { }
    
    @RemoteAction
    global static Account getAccount(String accName) 
    {
        account = [select id, name, phone, type, numberofemployees from Account where name = :accName ];
        return account;
    }
}