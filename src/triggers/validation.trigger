trigger validation on EnrolleeInformation_Tbl__c (before insert, before update) {
    
    
    Id myId;
    String output='';
    List <String> error = new List <String> ();
    for ( EnrolleeInformation_Tbl__c ei : trigger.new){
        myId = ei.ID;
    
       
        
        //boolean check = pattern.matches('[a-zA-Z]+',age);
       // if (ei.Age__c.isNull){
	        String age = String.valueOf(ei.Age__c);
	        boolean check = pattern.matches('[0-9]+',age);
	        if (!check){
	        	error.add('Input numeric value fo arge');
	        }
	        //if (!age.isNumeric()){
	        	// error.add('input numeric value for age'); 
	        //}
        //}
        String bday = '([0-9]{2})/\\1/[0-9]{4}';
        boolean check1 = pattern.matches(bday, ei.birthdate__c);
        if (!check1){
        	error.add('the valid format for birthdate is mm/dd/yyyy');
        }
       /* if (ei.birthdate__c.isNull){
	        String bday = '([0-9]{2,2})\\([0-9]{2,2})\\([0-9]{4,4})';
	        Pattern myPattern1 = pattern.compile(bday);
	        Matcher myMatcher1 = myPattern1.matcher(ei.birthdate__c);
	        if (!myMatcher1.matches()){
	            error.add('The valid format for birthdate is mm/dd/yyy');
	        }
        }*/
        
        String email = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
        //String email = '[a-zA-Z0-9]@[a-zA-Z].[a-zA-Z].[a-zA-Z]';
        //Pattern myPattern = pattern.compile(email);
        //Matcher myMatcher = myPattern.matcher(ei.email__c);
        Boolean check2 = pattern.matches (email, ei.email__c);
        if (!check2){
            error.add('input a valid email address');
        }
        
        if(error.size()>0){
        	for (integer a = 0; a < error.size(); a++){
        		output += error[a];
        		if (a< error.size() - 1){
        			output += ' and ';
        		}
        	}	
        	ei.Error_Message__c = output;
        }
        else{
            //error.clear();        	
            ei.Error_Message__c = '';
        }
    }
    
}