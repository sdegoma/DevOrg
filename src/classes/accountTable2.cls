public class accountTable2{
	public accountTable2(ApexPages.StandardController controller){
		
	}
	 
	public List <Account> getAccounts(){
		return [select name, phone, fax,  website, accountnumber, NumberOfEmployees from Account];
		
	}

}