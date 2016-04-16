/**
* @description handles the result of te exam
* @author Created By Noy De Goma
* @date Created On July 31, 2013
*/
public with sharing class ExamResultCC {
	public string result{get;set;}
	public string score{get;set;}
	private ID gradeID = apexpages.currentpage().getparameters().get('id');
	private ID tabID = apexpages.currentpage().getparameters().get('sID');
	/**
	* @description constructor for this class
	* @author Created By Noy De Goma
	* @date Created On July 31, 2013
	* @param N/A
	* @return N/A
	*/
	public ExamResultCC(){
		
	}
	/**
	* @description show the resulr whether you passed or failed
	* @author Created By Noy De Goma
	* @date Created On Aug 2, 2013
	* @param N/A
	* @return N/A
	*/
	public void UpdateGrade(){
		//checks if the url parameter result is null
		if (System.currentpagereference().getparameters().get('result')==null){
			result='Oppppsss! You run out of time... You failed...';
			//Grade__c gr = [select final_grade__c from Grade__c where id = :gradeID];
			//updates the grade
        	//gr.final_grade__c = 'Failed';
        	//update gr;
		}else{
			result=System.currentpagereference().getparameters().get('result');
			score=System.currentpagereference().getparameters().get('score');
		}
	}
	public pageReference onReturn(){
		Pagereference ref = new Pagereference('/Apex/Summary?sfdc.tabName='+tabID);
		ref.setRedirect(true);
		return ref;
	}
}