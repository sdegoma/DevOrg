public class TestMapJSCC {
    public map <String, Fields__c> fieldsMap {get;set;}
    public String serializedFields {get;set;}
    public TestMapJSCC(){
        fieldsMap = getFields();
        serializedFields  = JSON.serialize(fieldsMap);
        System.debug('\n\n\n**********serializedFields****** ' + serializedFields);
    }
    public map <String, Fields__c> getFields(){
        return Fields__c.getAll();
    }
}