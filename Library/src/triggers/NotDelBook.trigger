trigger NotDelBook on Book__c (AFTER INSERT) {

LIST<Book__c> deleterows  = new  LIST<Book__c>();
FOR(Book__c b :[SELECT Id FROM Book__c WHERE Id IN : Trigger.NEW])
{
    deleterows.add(b);
}
IF(deleterows.SIZE() != 0){
{
    Database.DeleteResult[] deleterows_del = Database.DELETE(deleterows);
    FOR(Database.DeleteResult del: deleterows_del)
        {
            IF(del.isSuccess())
                {
                    SYSTEM.DEBUG(' Deleted record(Book__c)Id  :'+del.getId());
                }
                ELSE
                {
                    SYSTEM.DEBUG('ERROR : Error occurs unable to delete (Book__c)record :'+del.getErrors());
                }
        }



}
}
}