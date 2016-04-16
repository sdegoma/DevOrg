public with sharing class TestAccountCC {

    public TestAccountCC() {

    }

    User usr = new User();
    public list <wrapper> listWrap {get;set;}
    public TestAccountCC(ApexPages.StandardController controller) {
        listWrap = new list <wrapper>();
        loadValue();
    }
    public void loadValue(){
        for (Account acc: [Select id,Name from Account]){
            listWrap.add(new wrapper(usr, acc, false));
        }
    }
    public void onsave(){
        for (wrapper w : listWrap){
            apexpages.addmessage(new apexpages.message(apexpages.severity.info, '' +w));
        }
    }
    public class wrapper{
        public User usr {get;set;}
        public Account acc {get;set;}
        public boolean selected{get;set;}
        public wrapper(user usr, account acc, boolean sel){
            this.usr = usr;
            this.acc = acc;
            this.selected = sel;
            
        }
    }
    

}