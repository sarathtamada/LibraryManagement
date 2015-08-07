trigger AccountRecordLock on Account (after update, after insert) {
 
  for (Account a : Trigger.New) {
    
    if (a.Rating == 'Cold') {
      // Create an approval request for the account
      Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Automatic submit.');
     
      req1.setObjectId(a.id);

      // Submit the approval request for the account
      Approval.ProcessResult result = Approval.process(req1);
    }
  }
}