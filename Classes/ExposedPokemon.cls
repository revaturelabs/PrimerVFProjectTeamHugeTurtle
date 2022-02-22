@RestResource(urlMapping='/My_Pokemon_Army__c/*')
global class ExposedPokemon{
	@HttpGet
    global static My_Poke_Army__c getMy_Pokemon_Army() {
        RestRequest restReq = RestContext.request;
        
        String recordId = restReq.requestURI.substring(restReq.requestURI.lastIndexOf('/') + 1);
        My_Poke_Army__c a=[SELECT Name, AutoId__c, (SELECT Name,Pokemon__r.Name,Pokemon__r.Pokemon_Image_URL__c,Pokemon__r.Pokemon_Type1__c,Pokemon__r.Pokemon_Type2__c FROM My_Poke_Soldiers__r) FROM My_Poke_Army__c WHERE Name='Pre-BuiltArmy'];
        return a;
    }
}// Revature-Primer Team: Huge Turtle-VisualforceProject-Ashley Bee / Raymond Fajardo