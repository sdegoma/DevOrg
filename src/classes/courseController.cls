public class courseController {

   public courseController() {

    }

 
   //List<Account> accounts = [select name, phone, fax,  website, accountnumber, NumberOfEmployees from account ];



    public List<Account> getCourses() {
    

        /*if(accounts == null){
             accounts = [select name, phone, fax, website, accountnumber, NumberOfEmployees from account ];
        }*/
        
        return [select name, parent.name from account ];

    }


   

}