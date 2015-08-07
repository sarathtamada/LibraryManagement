public with sharing class RemotingObjectsController {

    @RemoteAction
    public static void addAccounts(List<Account> accounts){
        insert accounts;
        system.debug('RemotingObjectsController .accounts-->'+accounts);
    }

}