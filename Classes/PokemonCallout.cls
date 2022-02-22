  // Revature Primer Project= Team: Huge Turtle Author: Raymond Fajardo
public class PokemonCallout {
    public static void getPokemonCallout(String url){
        system.debug(url);
        Http http= new Http();
        
        HttpRequest request= new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response= http.send(request);
        system.debug(response.getBody());
        if (response.getBody() !='NOT FOUND') {
        JSONParser parser= JSON.createParser(response.getBody());
        system.debug(parser);
            String pkn='';
            String pkno='';
            String pkurl='';
            String pktype1='';
            String pktype2='';
           
        
        
        while(parser.nextToken()!=null){
            if(parser.getCurrentToken()==JSONToken.FIELD_NAME){
                Switch on parser.getText() {
                    WHEN 'species'{
                        parser.nextValue();
                        parser.nextValue();
                        pkn=parser.getText();
                        system.debug('name: ' + parser.getText());
                       }
                    WHEN 'sprites'{
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();                        
                        pkurl=parser.getText();
                    system.debug('sprites: ' + parser.getText());
                    }
                    
                    WHEN 'game_indices'{
                    parser.nextValue();
                    parser.nextValue();
                    parser.nextValue();
                    pkno=parser.getText();
                    system.debug(parser.getText());
                    }
                    WHEN 'types'{
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();
                        pktype1=parser.getText();
                      system.debug(parser.getText());
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue(); 
                        parser.nextValue();
                        parser.nextValue();
                        parser.nextValue();  
                        parser.nextValue();
                        pktype2=parser.getText();                        
                        system.debug(parser.getText()); 
                        //parser.nextValue();*/
                        //while (parser.nextToken()!= system.JSONToken.END_OBJECT){
                           
                           }
                                                        
                            
                                }
                        
                        
                    }
                    
                }
        
        
        Pokemon__c p= new Pokemon__c(Name=pkn, Pokemon_Number__c=Decimal.valueof(pkno), Pokemon_Image_URL__c=pkurl, Pokemon_Type1__c=pktype1, Pokemon_Type2__c=pktype2);
        insert p;
            
        } else{
            {ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Could not find Pokemon! Check spelling'));} 
        }
            }
 }