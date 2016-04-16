trigger HelloWorld on Account (before update) {
    
    
    for (Account Acc : Trigger.new)

    {

        Acc.Hello__c = 'World';

    }

}