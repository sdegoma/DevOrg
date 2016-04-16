public class accountTable {

   public accountTable(ApexPages.StandardController controller) {
   //this is a test
   }

 
   //List<Account> accounts = [select name, phone, fax,  website, accountnumber, NumberOfEmployees from account ];



    public List<Account> getAccounts() {
    

        /*if(accounts == null){
        	 accounts = [select name, phone, fax, website, accountnumber, NumberOfEmployees from account ];
        }*/
        
        return [select name, phone, fax,  website, accountnumber, NumberOfEmployees from account ];

    }

}