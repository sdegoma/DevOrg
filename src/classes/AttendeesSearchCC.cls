/**
 * @description Controller for the AttendeeSearch page. responsible for adding new attendees to a report
 * @author Noy De Goma
 * @created date 23.JUL.2013
 * @last modified date 25.JUL.2013
 */
public with sharing class AttendeesSearchCC {
        //pass the value of the page id to a variable CRid
        private String CRid = ApexPages.CurrentPage().getParameters().get('id');
        public String inputSearch {get; set;}
        public boolean allSelected {get; set;}
        public boolean allRemove {get; set;}
        public String message {get; set;}
        public List <attendeeWrapper> attendeeList {get; set;}
        public List <attendeeWrapper> attendeeListSelected {get; set;}
        public Set <ID> attendeesToBeAdded {get; set;}
        public Set <User> usrSelected {get; set;}
        List<Attendees__c> addedAttendeesList = new List <Attendees__c>();
        string filter;
        /**
         * @description Constructor for this class.
         * @author Noy De Goma
         * @created date 23.JUL.2013
         * @last modified date 25.JUL.2013
         */
        public AttendeesSearchCC(ApexPages.StandardController Controller){
                this.inputSearch='Search...';
                this.usrSelected = new Set<User>();
                this.attendeesToBeAdded = new Set<ID>();
                this.attendeeList = new List <attendeeWrapper>();
                this.attendeeListSelected = new List <attendeeWrapper>();
        }
        /**
         * @description updates the table of attendees the matches the criteria of the inputText.
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return null
         * @param N/A
         */
        public PageReference onSearch(){
                //Check if the input length is greater than or equals 3 characters
                if (inputSearch.trim().length() < 3){
                        //dislpays error message in the visual force page
                         ApexPages.Message errorMessage = new ApexPages.message(ApexPages.SEVERITY.ERROR, 'Search Input must be 3 characters or more');
                         ApexPages.addMessage(errorMessage);
                }else{
                        //pass the value of the input text to a variable filter
                        filter = '%' + inputSearch.trim() + '%';
                        //calls the method loadAttendees
                        loadAttendees();
                }
                if (allSelected == true){
                        allSelected = false;
                }
                if (allRemove == true){
                        allRemove = false;
                }
                return null;
        }
        /**
         * @description remove the list of selected attendees and add it to another table
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return null
         * @param N/A
         */
        public PageReference onSelect(){
                attendeeWrapper awrap;
                for (Integer a = attendeeList.size() - 1; a >=0 ; a--){
                        awrap = attendeeList[a];
                        //checks if the checbox is ticked
                        if (attendeeList[a].selected == true){
                                //adds a value to the attendeeListSelected wrapper
                                attendeeListSelected.add(new attendeeWrapper(awrap.attendeeID, awrap.attendeeFname, awrap.attendeeLname, awrap.attendeeEmail, false));
                                //adds a value to the set of ID
                                attendeesToBeAdded.add(awrap.attendeeID);
                                //removes a value to the attendeeList wrapper
                                attendeeList.remove(a);
                        }
                }
                return null;
        }
        /**
         * @description remove the list of selected attendees and add it to another table
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return null
         * @param N/A
         */
        public Pagereference onRemove(){
                attendeeWrapper awrap;
                for (Integer a = attendeeListSelected.size() - 1; a >=0 ; a--){
                        awrap = attendeeListSelected[a];
                        //checks if the checbox is ticked
                        if (attendeeListSelected.get(a).selected == true){
                                //adds a value to the attendeeList wrapper
                                attendeeList.add(new attendeeWrapper(awrap.attendeeID, awrap.attendeeFname, awrap.attendeeLname, awrap.attendeeEmail, false));
                                //removes a value to the set of ID
                                attendeesToBeAdded.remove(awrap.attendeeID);
                                //adds a value to the attendeeListSelected wrapper
                                attendeeListSelected.remove(a);
                        }
                }
                return null;
        }
        /**
         * @description insert all the selected attendees
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return Pagereference
         * @param N/A
         */
        public PageReference onSave(){
                for (attendeeWrapper aw: attendeeListSelected){
                        //create a new instance of Attendees object
                        Attendees__c att = new Attendees__c();
                        att.Call_Report__c = CRid;
                        att.attendeeID__c = aw.attendeeid;
                        att.first_name__c = aw.attendeeFname;
                        att.last_name__c = aw.attendeeLName;
                        att.email__c = aw.attendeeEmail;
                        //adds the new instance to a List
                        addedAttendeesList.add(att);
                }
                //insert the list of Attendees to the object
                insert (addedAttendeesList);
                //redirect back to the parent page
                return new Pagereference('/'+CRid);
        }
        /**
         * @description cancels the process and redirect back to the parent page
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return Pagereference
         * @param N/A
         */
        public PageReference onCancel(){
                //redirect back to the parent page
                return new Pagereference('/'+CRid);
        }
        /**
         * @description method to update the table for the attendees
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return N/A
         * @param N/A
         */
        public void loadAttendees(){
                //clear the list of attendees
                attendeeList.clear();
                Set <ID> savedAttendees = new Set <ID>();
                //adds the id of the attendee to a set
                for (Attendees__c att : [Select attendeeID__c from Attendees__c where Call_Report__r.id = :CRid]){      
                        savedAttendees.add(att.attendeeID__c);
                }
                //adds the contact information to the list of attendees that matches the criteria
                for (contact c: [Select id, firstname, lastname, email from Contact where id not in :attendeesToBeAdded and ID not in :savedAttendees and name like :filter ]){
                        attendeeList.add(new attendeeWrapper(c.id, c.firstname, c.lastname, c.email, false));
                }
                //adds the user information to the list of attendees that matches the criteria
                for (User u: [Select id, firstname, lastname, email from User  where id not in :attendeesToBeAdded and ID not in :savedAttendees and name like :filter]){
                        attendeeList.add(new attendeeWrapper(u.id, u.firstname, u.lastname, u.email, false));
                }
        }
        
        /**
         * @description combines the user and contact into a list
         * @author Noy De Goma
         * @created date 24.JUL.2013
         * @last modified date 25.JUL.2013
         * @return N/A
         * @param N/A
         */
        public class attendeeWrapper{
                public ID attendeeID {get; set;}
                public String attendeeFname {get; set;}
                public String attendeeLname {get; set;}
                public String attendeeEmail {get; set;}
                public boolean selected {get; set;}
                /**
                 * @author Noy De Goma
                 * @created date 24.JUL.2013
                 * @last modified date 25.JUL.2013
                 * @return N/A
                 * @param id = id of the attendee, fname = firstname of the attendee, lname = lastname of the attendee, email, email of the attendee, checked = state of the checkbox true if ticked false if not
                 */
                public attendeeWrapper(ID id, String fName, String lName, String email, boolean checked){
                        this.attendeeID = id;
                        this.attendeeFname = fName;
                        this.attendeeLname = lName;
                        this.attendeeEmail = email;
                        this.selected = checked;
                }
        }
}