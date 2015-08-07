public class SinglepicklistforMyAccount 
{
    public string selectedValue { get;set; }
    public List<SelectOption> statusOptions { get;set; }
    
    public void autoRun()
    {
        Schema.DescribeFieldResult statusFieldDescription = Account.Rating.getDescribe();
        statusOptions = new list<SelectOption>();
        
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            statusOptions.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
    }

    public void checkValue()
    {
        System.debug('----------------'+selectedValue);
    }
}