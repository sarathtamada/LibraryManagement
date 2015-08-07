public class SearchListController{
 
    public String objectName {get;set;}
    public List<String> objectFields {get;set;}
    public List<SObject> SObjectListToShow {get;set;}
    public SearchListController(){
        objectName= 'MyObject__c';
        SObjectListToShow = getSObjectList();
    }
    public List<SObject> getSObjectList(){
 
    //Getting field list for the sObject 
        objectFields =  new List<String>();
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType sObjType = globalDescription.get(objectName);
 
        Schema.DescribeSObjectResult res = sObjType.getDescribe();
 
        Map<String , Schema.SObjectField> mapFieldList = res.fields.getMap();
        for(Schema.SObjectField field : mapFieldList.values())
        {
            Schema.DescribeFieldResult fieldResult = field.getDescribe();
            if(fieldResult.isAccessible())
            {
                objectFields.add(fieldResult.getName());
            }
        }
 
        //Building Query with the fields
        Integer i = 0;
        String fieldsToFetch = '';
        Integer len = objectFields.size();
        for(String temp:objectFields)
        {
 
            if(i==len-1)
            {
                  fieldsToFetch = fieldsToFetch + temp;
            }
            else
            {
                  fieldsToFetch = fieldsToFetch + temp + ',';
            }
            i++;
        }
            String qryStr = 'Select ' + fieldsToFetch + ' From ' + objectName  ;
            return  Database.Query(qryStr);
    }
}