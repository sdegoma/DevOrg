/**
 * @description Custom Controller for the Dev401Page - this handles the activity in the page
 * @author Created By Noy De Goma
 * @date Created On July 29, 2013co
*/
public with sharing class ExamCC {
    //Public Variables - This Variables can be used outside of this class; 
    public map <integer, Question__c> questionMap{get; set;}
    public map <integer, list <choicesWrapper>> choicesWrap {get;set;}
    public map <integer, boolean> qToReview{get;set;}
    public List <QandAWrapper> QandAWrapperList {get;set;}
    public boolean marker{get;set;}
    public boolean start {get;set;}
    public boolean nextVisibility{get; set;}
    public integer correctAnswer {get;set;}
    public integer ctr{get;set;}
    public boolean markReview {get;set;}
    public boolean submitVisibility {get;set;}
    public boolean finVisibility{get;set;}
    public boolean visibility {get; set;}
    public boolean rVisibility {get; set;}
    public boolean buttonsBlockVisibility {get;set;}
    public boolean showResultVisibility{get;set;}
    public boolean correctAnswerVisibility{get;set;}
    public integer qLimit {get;set;}
    public string timeTaken {get;set;} 
    public String result{get;set;}
    public integer timeLimit {get;set;}
    //Private Varibles - This Variables can only be used within the class
    private ID examinee = UserInfo.getUserID();
    private Id questionId;
    private integer correct {get;set;}
    private integer checked{get;set;}
    private ID tabID;// = apexpages.currentpage().getparameters().get('sID');
    private boolean mark = false;
    private boolean review = false;
    private list<integer> randNum = new list<integer>();
    private boolean cont = false;
    private integer temp=0;
    private pageReference ref;
    private String examType;
    map <string, Exam_Type__c> examTypeMap;
    decimal passing;
    integer count;
    private list<Question__c> questionList;
    list <Id> tempList = new list <Id> ();
    /**
     * @description performs the initialization of the variables
     * @author Created By Noy De Goma
     * @date Created On July 29, 2013
     * @return N/A
     * @param N/A
    */  
    public ExamCC(){
        examTypeMap = Exam_Type__c.getAll();
        examType = apexpages.currentPage().getParameters().get('Exam Type');
        passing = examTypeMap.get(examType).Passing_Percentage__c;
        timeLimit =integer.valueOf(examTypeMap.get(examType).Time__c);
        qLimit = integer.valueOf(examTypeMap.get(examType).Number_Of_Question__c);
        questionList = new list <Question__c>();
        questionMap = new map <integer, Question__c>();
        choicesWrap = new map <integer, list <choicesWrapper>>();
        qToReview = new Map <integer, boolean>();
        start = false;
        result = '';
        timeTaken = '';
        buttonsBlockVisibility = true;
        visibility = true;
        rVisibility = false;
        finVisibility = true;
        nextVisibility = true;
        marker = true;
        showResultVisibility = false;
        correctAnswerVisibility = false;
        markReview = false;
        correctAnswer = 0;
        ctr = 0;
        PopulateListOfQuestions();
        random();
        LoadQandA();
    }
    /**
     * @description populates the list of questions
     * @author Created By Noy De Goma
     * @date Created On Aug 31, 2013
     * @return N/A
     * @param N/A
    */ 
    private void PopulateListOfQuestions(){
        questionList = [Select id, Question__c, Number_Of_Answer__c, Question_Number__c, (Select Question_ID__c, Option__c, Correct_Value__c from Question_Options__r WHERE Active__c = TRUE) from Question__c where Exam_Type__c = :examType];
        //counts the number of question
        count = questionList.size();
        //change the value of the qLimit if the size of the retrieved question for a specific exam is less than qLimit
        if (count < qlimit){
            qLimit = count;
        }  
    }
    /**
     * @description performs randomization
     * @author Created By Noy De Goma
     * @date Created On Aug 1, 2013
     * @return N/A
     * @param N/A
    */  
    public void Random(){
            //qLimit = 3;
            //populates the randNum list with a value of -1 for each 
            for (integer a = 0; a < qLimit ;a++){ 
               randNum.add(-1); 
            }
            //randomize a number and populates the list if the random number generated is unique
            set <integer> randomSet = new set <integer>();
            for (integer a = 0; a < qlimit ;a++){    
                cont = false;
                //will continue the loop until a unique number is generated ramdomly
                do{
                    //cont=true;
                    //generates random number
                    temp = (integer)((Math.random() * count));
                    if (randomSet.contains(temp)){
                        cont = false;
                        //break;
                    }else{
                        randomSet.add(temp);
                        cont = true;
                    }
                }while (cont == false);
                //populates the list with the unique random number that was generated   
                randNum[a]=temp;
            }
            
        
        
    }
    /**
     * @description loads all the question and options
     * @author Created By Noy De Goma
     * @date Created On July Aug 29, 2013
     * @return N/A
     * @param N/A
    */ 
    public void LoadQandA(){
        	//ctr = 0;
            QandAWrapperList = new List<QandAWrapper>();
            //populates the questionMap with the values of the questionList
            //questionMap.put(ctr, questionList[randNum[ctr-1]]);
            //converts the decimal value to integer
            //questionId = questionList[randNum[ctr-1]].Id;
            //iterates the question_option__c that meets the criteria and put the value in a list
            /*for (Question_Option__c qop : [Select Question_ID__c, Option__c, Correct_Value__c from Question_Option__c where Question_ID__c = :questionId]){
                QandAWrapperList.add(new choicesWrapper(qop));
            }*/
            for (integer i = 0; i < randNum.size() ; i++){
	            Question__c question = questionList[randNum[i]];            
	            QandAWrapperList.add(new QandAWrapper(question, i+1));
            }
            
            //instanctiate the QandAWrapperList
            //choicesWrap.put(ctr,QandAWrapperList);
            
            
            //tempList.add(questionId);
            //for (integer a = 0; a < ctr; a++)
            //Apexpages.addmessage(new Apexpages.message(apexpages.severity.info , '' + randNum[a] + '--------' + tempList[a] ));  
         
    }
    /**
     * @description does nothing
     * @author Created By Noy De Goma
     * @date Created On Aug 1, 2013
     * @return N/A
     * @param N/A
    */  
    public pagereference doNothing(){
        
        
        return null;
        
    }
    /**
     * @description perporms the checking of the score of the examinee
     * @author Created By Noy De Goma
     * @date Created On Aug 1, 2013
     * @return N/A
     * @param N/A
    */  
    public void SubmitExam(){
        //iterates to check how many correct answers the examinee have
        for (QandAWrapper q : QandAWrapperList){
            correct = 0;
            checked = 0;
            //integer numberOfCorrect = 1;//integer.valueOf(questionMap.get(i).Number_Of_Answer__c);
            for (choicesWrapper cW : q.choiceWrapList){
                if (cW.selected){
                    //checks if the selected choice is correct
                    if (cW.questOp.Correct_Value__c){
                        correct++;
                    }
                    checked++;
                }
            }
            if (checked > q.numberOfCorrect){
                // do nothing if the number of selected answers is greater than the number of correct answer
            }else{
                //increments the correctAnswer if the examinee selects the correct answer(s)
                if (correct == q.numberOfCorrect){
                    correctAnswer++;
                }
            }
            
            
        }
        //checks wether the examinee hava passed or failed
        if (correctAnswer >= (qlimit * passing) / 100){
             Grade__c gr = new Grade__c(User__c = examinee, Exam__c = examType, Score__c = correctAnswer, 
                                        Total__c = qLimit, Passing_Percentage__c = passing, Final_Grade__c = 'Passed');
             insert gr;
             result = 'Congratulations! You have PASSED';
        }else{
             Grade__c gr = new Grade__c(User__c = examinee, Exam__c = examType, Score__c = correctAnswer, 
                                        Total__c = qLimit, Passing_Percentage__c = passing, Final_Grade__c = 'Failed');
             insert gr;
             result = 'Sorry... You have FAILED';
        }
        
        visibility = false;
        rvisibility = false;
        buttonsBlockVisibility = false;
        showResultVisibility = true;
        marker  = false;
        start = false;
        
    }
    /**
     * @description hides and unhide some of the object on the page
     * @author Created By Noy De Goma
     * @date Created On July 30, 2013
     * @return N/A
     * @param N/A
    */  
    public void onReviewAnswer(){
        visibility = true;
        rvisibility = false;
        finVisibility = false;
        submitVisibility = true;
        nextVisibility = true;
        //loads the function LoadQandA()
        //loadQandA();
    }
    /**
     * @description marks the question for review
     * @author Created By Noy De Goma
     * @date Created On July 31, 2013
     * @return N/A
     * @param N/A
    */ 
    public void onMark(){
        //marks the actual question for review
        QtoReview.put(ctr, true);
        //QandAMap.put(ctr, new Map <Question__c, List<choicesWrapper>>{Questions => QandAWrapperList} );
    }
    /**
     * @description marks all the questions for review
     * @author Created By Noy De Goma
     * @date Created On Aug 2, 2013
     * @return N/A
     * @param N/A
    */
    public void onMarkAll(){
        //marks all the question for review
        for(integer a=0;a<qLimit;a++){
            QtoReview.put(a, true);
        }
        marker = false;
    }
    /**
     * @description performs the action when the button submit is clicked
     * @author Created By Noy De Goma
     * @date Created On Aug 31, 2013
     * @return null
     * @param N/A
    */
    public pageReference onSubmit(){
        //hides and unhide some of the object when submit button is clicked
        finVisibility = true;
        submitVisibility = false;
        nextVisibility = false;
        visibility = false;
        rvisibility = true;
        marker = false;
        buttonsBlockVisibility = true;
        return null;       
    }
    /**
     * @description performs the action when the button next or submit is clicked
     * @author Created By Noy De Goma
     * @date Created On July 30, 2013
     * @return null/ ref - Exam result PageReference
     * @param N/A
    */
    public Pagereference onNext(){
        //populates the map QtoReview if the add to review list is checked
        if(markReview){
            QtoReview.put(ctr, true);
        }else{
            if (!QtoReview.containsKey(ctr)){
                QtoReview.put(ctr, false);
            }
        }
        if ((ctr + 1)==qlimit){
            submitVisibility = false;
            nextVisibility = false;
            finVisibility = true;
            nextVisibility = false;
            visibility = false;
            rvisibility = true;
            marker = false;
            review = true;
        }
        markReview = false;
        //checkIfCorrect();
        if (ctr<qlimit){
            ctr++;
        }
        //sets the label of the button to submit 
        /*if (!review){
            loadQandA();
        }*/
        //return null;
        //Calls the function LoadQandA()
        //loadQandA();
        return null;
    }
    /**
     * @description show the correct answers
     * @author Created By Noy De Goma
     * @date Created On Sept 1, 2013
     * @return null
     * @param N/A
    */
    public pageReference onShowCorrectAnswer(){
        correctAnswerVisibility = true;
        showResultVisibility = false;
        return null;
    }
    /**
     * @description redirects to the summary of Courses
     * @author Created By Noy De Goma
     * @date Created On Sept 1, 2013
     * @return ref - pageReference
     * @param N/A
    */
    public pageReference onReturn(){
        //Pagereference ref = new Pagereference('/Apex/Summary');
        Pagereference ref  = page.Summary;
        ref.setRedirect(true);
        System.debug('\n\n\n******************[Redirect]********************** ' + String.valueOf(ref) + '**************\n\n');
        return ref;
    }
     /**
     * @description notify the examinee that the time has run out
     * @author Created By Noy De Goma
     * @date Created On Sept 1, 2013
     * @return ref - pageReference
     * @param N/A
    */
    public void onTimeRunsOut(){
        visibility = false;
        rvisibility = false;
        buttonsBlockVisibility = false;
        showResultVisibility = true;
        marker  = false;
        Grade__c gr = new Grade__c(User__c = examinee, Exam__c = examType, Score__c = correctAnswer, 
                                    Total__c = qLimit, Passing_Percentage__c = passing, Final_Grade__c = 'Failed');
        insert gr;
        result = 'Opppps! you run out of time.';
    }
    /**
     * @description main Wrapper Class
     * @author Created By Noy De Goma
     * @date Created On July 30, 2013
     * @return N/A
     * @param N/A
    */
    public class choicesWrapper{
        public Question_Option__c questOp{get;private set;}
        public boolean selected{get;set;}
        
        public String color {get;private set;}
        /**
         * @description Wrapper Class
         * @author Created By Noy De Goma
         * @date Created On July 30, 2013
         * @return N/A
         * @param qo - option object         
        */
        public choicesWrapper(Question_Option__c qo){
        	this.questOp = qo;
            //set the value of the options
            this.questOp = qo;
            //sets the value of the checkbox;
			this.selected = false;
            if (qo.Correct_Value__c){
                this.color = '#F987F1';
            }
        	
        }
    }
    public class QandAWrapper{
    	public list <choicesWrapper> choiceWrapList {get;private set;}
    	public integer index {get;private set;}
    	public Question__c question {get; private set;}
    	public integer numberOfCorrect {get;private set;}
    	public boolean test{get;set;}
    	public QandAWrapper(Question__c q, integer index){
    		this.choiceWrapList = new list <choicesWrapper>();
    		this.index = index;
    		this.question = q;
    		this.numberOfCorrect = 0;
    		for(Question_Option__c qo : q.Question_Options__r){
    			if(qo.Correct_Value__c){
    				numberOfCorrect++;
    			}
    			choiceWrapList.add(new choicesWrapper(qo));
    		}
    	}
    }
    public void dummyAction(){
    	
    }
}