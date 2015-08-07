public class ErrorMsgController {
public void DisplayError(){
Apexpages.addMessage( new ApexPages.Message (ApexPages.Severity.ERROR, 'Required fields are missing. ')); //FATAL, WARNING, INFO, CONFIRM
}
}