/**
 *@desription this handles the process of leave application
 *@author Created By Noy De Goma
 *@date Created Date Aug 8, 2013
*/
public with sharing class LeaveApplicationCC {
	list <Employee__c> empList = new list<Employee__c>();
	public string searchTxt {get;set;}
	String filter;
	/**
	 *@description this is the constructor for this class
	 *@author Created By Noy De Goma
	 *@date Created Date Aug 9, 2013
	 *@return N/A
	 *@param N/A
	*/
	public LeaveApplicationCC(){
		
	}
	public void applyForLeave(){
		apexpages.addMessage(new apexpages.message(apexpages.severity.info, ''+system.currentpagereference().getparameters().get('id')));
	}
	public void onSearch(){
		filter = '%' + searchTxt + '%';
	}
	public list<Employee__c> getEmployees(){
		//if (empList.isEmpty()){
			empList = [Select id, name, first_name__c, last_name__c from Employee__c where name like :filter or first_name__c like :filter or last_name__c like :filter];
		//}
		return empList;
	}
	
	

}