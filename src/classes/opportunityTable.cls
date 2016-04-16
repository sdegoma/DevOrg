public class opportunityTable {

    public opportunityTable(ApexPages.StandardController controller) {

    }


   List<opportunity> opportunities;



    public List<opportunity> getopportunities() {

        if(opportunities == null) opportunities = [select name, stagename  from opportunity where accountid = :Apexpages.currentpage().getparameters().get('id')];

        return opportunities;

    }

}