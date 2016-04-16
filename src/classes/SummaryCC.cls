/**
	* @description peroforms the activity in the summary page
	* @author Created By Noy De Goma
	* @date Created On Aug 2, 2013
	*/
public with sharing class SummaryCC {
	public map <String,Exam_Type__c> examMap {get;set;}
	public ID tabID {get;set;} 
	public string examType {get;set;}
	//public Question__c q {get; set;}
	/**
	* @description constructor for this class
	* @author Created By Noy De Goma
	* @date Created On Aug 2, 2013
	* @param N/A
	* @return N/A
	*/
	public SummaryCC(){
		//tabID;// =  apexpages.currentpage().getparameters().get('sfdc.tabName');
		//calls the function LoadUser
		LoadExam();
	}
	private void LoadExam(){
		//handles the rendered value of the take exam button
		examMap = Exam_Type__c.getAll();
		
	}
	/**
	* @description redirect to the exam page
	* @author Created By Noy De Goma
	* @date Created On Sept 1, 2013
	* @param N/A
	* @return PageReference - exam page
	*/
	public PageReference onRedirectToExam(){
		examType = System.currentPageReference().getParameters().get('examType');
		pageReference ref = new pageReference ('/apex/Exam?Exam Type='+examType);//return new PageReference('/apex/Exam?Exam Type='+examType+'&sID='+tabID);
		ref.setRedirect(true);
		return ref;
	}
	

}