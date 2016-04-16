global class GenerateUniqueIdNumber {
	webService static String GenerateExtID(list <SObject__c> SObjectList){
        Integer generatedId;
        SObject__c SObjToUpdate;
        set <Integer> extIdSet = new set <Integer>();
        list <SObject__c> SObjListToUpdate = new list <SOBject__c>();
        //get all the accounts that have a site id and put it to a map 
        for (SObject__c so : [SELECT Id, External_Id__c FROM SObject__c WHERE External_Id__c != null]){
            //siteIdMap.put(a.Site_ID__c, a);
            extIdSet.add(Integer.valueOf(so.External_Id__c));
        }
        for(SObject__c so : SObjectList){
        	// check if the Global Id is not null and the site id is null
            if (so.External_Id__c == null || so.External_Id__c == ''){
            	
                    generatedId = GeneratedId();

                    while (extIdSet.contains(generatedId) && !extIdSet.isEmpty()){            	
                        generatedId = GeneratedId();
                    }
                    SObjToUpdate = new SObject__c(
                        Id = so.Id,
                        External_Id__c = String.valueOf(generatedId).leftPad(10,'0')
                    );  

                extIdSet.add(Integer.valueOf(SObjToUpdate.External_Id__c)); 
            }
            SObjListToUpdate.add(SObjToUpdate);
        }
        
        try{	
        	update SObjListToUpdate;
        }catch(DMLException ex){
        	System.debug('Error: ' + ex.getMessage());
        }
        return String.valueOf(SObjToUpdate.External_Id__c);
    }
    // this method will generate the External Id
    public static integer GeneratedId(){
        Integer genId;
        // will generate random numbers
        genId = (Integer)(Math.Random() * 2147483647);
        return genId;   
    }
}