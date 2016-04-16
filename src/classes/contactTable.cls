public class contactTable {

    public contactTable(ApexPages.StandardController controller) {

    }

    
   List<Contact> contacts;
   List<Contact> contacts2 = new List<Contact>();
   
   
   

    public List<Contact> getContacts() {
    
        if(contacts == null) contacts = [select name, title, phone, email, mobilephone, Department  from contact where accountid = :Apexpages.currentpage().getparameters().get('id')];

        return contacts;

    }

}