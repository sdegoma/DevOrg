public  with sharing class quotesController {
   
 
    //String quoteID = ApexPages.currentPage().getparameters().get('id');
    String quoteNum;
    Decimal sTotal = 0;
    integer genQuote;
    public Quote quote;
    //public Blob b {get; set;}  
    //public String cType {get; set;}  
    //public String fName {get; set;}
 
  
    public quotesController(ApexPages.StandardController controller) {
    
        this.quote=(Quote)controller.getRecord();
 
     
    } 
    
    
    
    
    
    public PageReference attachPDF(){
        
        
        set <Attachment> attList = new Set<Attachment>();
        
        for (Attachment attachedFile: [Select Name from Attachment where parentID = :quote.id]){
            attList.add(attachedFile);
        }
            
            
        
            if (attList.size() < 3){
                 Quote quote = [SELECT Name FROM Quote WHERE Id = :quote.id];
            
                 PageReference ref = Page.GeneratedQuotes;
                 ref.getParameters().put('Id', quote.Id);
               
                 blob pdf = ref.getContentAsPdf();
                 Attachment attach = new Attachment();  
                 attach.Body=pdf;  
                 attach.Name=quote.Name;  
                 attach.contentType = 'application/pdf';
                 attach.ParentID=quote.id; 
                 insert(attach);
                 return new PageReference('/apex/GeneratedQuotes?id=' + quote.id); 
            } 
            else{ 
                 
                 PageReference ref = Page.GeneratedQuotes;
                 ref.getParameters().put('Id', quote.Id);
                 return new PageReference('/apex/generation_limit');
                 //quote.addError('Boom'); 
                 //return null;
            }
        
        
           
    }  
    
    
    public integer getSize(){
        return 1; 
    }
    public integer getQuoteGenQ() {
    
        for (Quote genQ : [Select Generated_quotes__c from Quote where id = :ApexPages.currentpage().getParameters().get('id')]){
            genquote = Integer.valueOf(genQ.generated_quotes__c);
        }
        
       return genquote;


    }
    
      
    public List<Quote> getQuotes() {
    
        for (Quote qNum : [Select QuoteNumber from Quote where id = :ApexPages.currentpage().getParameters().get('id')]){
           quoteNum = qNum.QuoteNumber;
        }
        
        return [select ID, QuoteNumber, Bill_To__r.Name,Bill_To__r.BillingStreet, Bill_To__r.BillingCity, Bill_To__r.BillingState, Bill_To__r.BillingPostalCode, Bill_To__r.BillingCountry from Quote where quotenumber = :quoteNum];


    }
    
    public List<quotelineitem> getQuotelineitems() {
    
       
        return [Select  product__r.name, product__r.description__c, product__r.unit_price__c, quantity, total_price__c from  quotelineitem where quote.quotenumber = :quoteNum];


    }
    
    public decimal getSubtotal(){
       for (QuoteLineItem  qLine : [Select Total_Price__c from QuoteLineItem where quote.quotenumber = :quoteNum]){
           sTotal += qLine.Total_Price__c;
       }
       
       return sTotal;
    }  
    List <Integer> newQty;
    public List<Integer> getQuantities(){
       
        for (QuoteLineItem  qty : [Select quantity from QuoteLineItem where quote.quotenumber = :quoteNum]){
            integer quan = integer.valueOf(qty.Quantity);
            newQty.add(quan);  
        }
        
        return newQty ;
    }
    public String getUsers(){
        return UserInfo.getName();
    }
    decimal tax; 
    public decimal getTax(){
        tax = sTotal * .12;
        tax = tax.setScale(2);
        return tax;
       
    } 
    public String getDates(){
        dateTime d = System.Today();
        String fd = d.format('MM/dd/yyyy');
        return fd;
    } 
    
    public decimal getGrandTotal(){
       decimal grand = sTotal + Tax ;
       grand = grand.setScale(2);
       return grand;
    }
 
     
}