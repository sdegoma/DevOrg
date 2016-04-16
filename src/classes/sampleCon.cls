public class sampleCon {
    public Boolean yesNo9{get;set;}
    public sampleCon() {
        
    }

    /*Boolean country = null;

         
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('True','True')); 
        options.add(new SelectOption(False,'False')); 
        //options.add(new SelectOption('MEXICO','Mexico')); 
        return options; 
    }
                   
    public Boolean getCountry() {
        return country;
    }
                    
    public void setCountry(Boolean country) { 
        this.country = country; 
    }*/
    public List<SelectOption> getYesNo(){
        List<SelectOption> opt = new List<SelectOption>(); 
        opt.add(new SelectOption('false','No')); 
        opt.add(new SelectOption('true','Yes'));
        return opt;
    }
    public Boolean getYesNo9(){
        return yesNo9;
    }
    public void setYesNo9(Boolean YesNo9){
        this.yesNo9 = YesNo9;
    }
     
}