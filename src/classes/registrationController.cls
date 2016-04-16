public with sharing class registrationController {

    public Account course;
    public List <String> courseNotAllowed = new List <String>();
    public List <Grade__c> courseToBeInserted = new List<Grade__c>();
    private Set<ID> courseRegistered = new set<ID>();
    Public List<string> leftselected{get;set;}
    Public List<string> rightselected{get;set;}
    Set<string> leftvalues = new Set<string>();
    Set<string> rightvalues = new Set<string>();
    Set<string> leftvaluesID = new Set<string>();
    Set<string> rightvaluesID = new Set<string>();
    private String message='';
    String conID = ApexPages.currentPage().getParameters().get('id');
    

    public registrationController(ApexPages.standardController controller){
    	for (Grade__c g : [Select course__c from Grade__c where user__c = :UserInfo.getUserID() ]){
    		courseRegistered.add(g.course__c);
    	}
        leftselected = new List<String>();
        rightselected = new List<String>();
        for (account temp : [select name, id from account where id not in :courseRegistered]){
                leftvalues.add(temp.name);
                leftvaluesID.add(temp.id);
        }
    }
    public PageReference selectclick(){
        rightselected.clear();
        for(String s : leftselected){
            leftvalues.remove(s);
            rightvalues.add(s);
        }
        for(String s : leftselected){
            leftvaluesID.remove(s);
            rightvaluesID.add(s);
        }
        return null;
    }
     
    public PageReference unselectclick(){
        leftselected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftvalues.add(s);
        }
        for(String s : rightselected){
            rightvaluesID.remove(s);
            leftvaluesID.add(s);
        }
        return null;
    }
    public List<SelectOption> getunSelectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        tempList.sort();
        for(string s : tempList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
    public List<SelectOption> getSelectedValues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }
    public void Message(){
        String errors = '';
        integer size = courseNotAllowed.size();
       
        if (size > 0){
            for (integer a = 0; a < size; a++){
                    errors += courseNotAllowed[a];
                    
                    if (a < size - 1 ){
                            errors += ', ';
                    }
                    
            }
            Apexpages.addMessage(new Apexpages.Message(Apexpages.SEVERITY.ERROR, 'Registration Failed: Some courses have a prerequisite that have not yet been taken or have not yet been passed:' + '\n' + errors));
        	courseNotAllowed.clear();
        	courseToBeInserted.clear();        
        }
    }
    public PageReference onSave(){
	    Account accountID;
		for (String s: rightValues){
	        String courseName = String.valueOf(s); 
	        accountid = [Select id from account where name = :courseName];
	        ID courseID = accountid.id;
	       	Grade__c grade = new Grade__c();
	       	grade.course__c = courseID;
	       	grade.user__c = UserInfo.getUserID();
	        for (Account acc: [Select id, name, parent.name from Account where name = :courseName]){
	            if (acc.parent.name != null){                                      	
	            	list <Grade__c> gradeList = [Select user__r.id, Course__r.id, final_grade__c from Grade__c where user__r.id = :UserInfo.getUserID() and course__r.name = :acc.parent.name and final_grade__c = 'Passed'];	
	            	if (gradeList.size() > 0){
	            		courseToBeInserted.add(grade);
	            
	            	}else{
	            		courseNotAllowed.add(courseName);
	            	}
	        	}else{
	        		courseToBeInserted.add(grade);
	        	} 
	        }      
		}
        if (courseNotAllowed.size() > 0){
            message();
            return null;
                        
        }else{           
            insert (courseToBeInserted);
            return new PageReference('/apex/Summary?sfdc.tabName='+apexpages.currentPage().getParameters().get('sID'));
            
        }   
	}
}