public with sharing class ApproveOrRejectLeaveApplicationCC {
	public list <Leave__c> leaveList{get;set;}
	public map <id, list <leaveAppWrapper>>leaveMap{get;set;}
	public list <leaveAppWrapper> tempList  {get;set;}
	id projectManagerID = apexpages.currentpage().getparameters().get('id');
	public ApproveOrRejectLeaveApplicationCC(){
		leaveMap = new map <id, list <leaveAppWrapper>>();
		tempList = new list<leaveAppWrapper>();
		leaveList = new list<Leave__c>();
		loadLeave();
	}
	public void loadLeave(){
		for (Leave__c leave : [select Id from Leave__c /*where Employee__r.Project__c = :projectManagerID*/]){
			tempList.add(new leaveAppWrapper(leave, false));
			leaveMap.put(leave.id, tempList);
		}
	}
	public void onReject(){
		for (id leaveID: leaveMap.keySet()){
			system.debug('------------------------------------'+leaveMap.get(leaveID).get(1).selected);
			/*if (leaveMap.get(leaveID)){
				Leave__c tempLeave = new Leave__c();
				tempLeave.id = leaveID;
				tempLeave.Status__c = 'Rejected';
				leaveList.add(tempLeave);
			}*/
		}
		update leaveList;
	}
	public class leaveAppWrapper{
		public boolean selected{get;set;}
		public Leave__c leave{get;set;}
		public leaveAppWrapper(Leave__c leave, boolean selected){
			this.selected = selected;
			this.leave = leave;
		}	
	}
}