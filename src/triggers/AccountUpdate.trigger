trigger AccountUpdate on Account (before update) {

    ID conID;
    String newName;
    
    for (Account acc : Trigger.new){
    
        conID = acc.id;
        newName = acc.name;
    
    }
    List <Contact> conList = [Select id from contact where accountid = :conID];

    for (Contact con : conList){
        Con.walk_in_the_park__c = 'updated by '+ newName;
    }

    update conList;
 
}