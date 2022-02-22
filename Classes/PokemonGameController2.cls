   //Revature Primer Project Team:Huge Turtle Author/s: Ashley Sarah Bee paired with Raymond Fajardo
public with sharing class PokemonGameController2 {
    public PokemonGameController2(ApexPages.StandardSetController controller){controller.setPageSize(1);}
    public String pokemonName {get; set;}
    public Boolean displayModal {get; set;}{displayModal=true;}
    public void addPokemon2(){
        system.debug(pokemonName);  
        if(pokemonName=='' || pokemonName==' '){ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'The Pokemon Name was empty. Try again'));}
        else{
        String urlString='https://pokeapi.co/api/v2/pokemon/' + pokemonName +'/';
        PokemonCallout.getPokemonCallout(urlString);
        }
        pokemonName ='';    
  }
    
    public PageReference closePokemonWindow(){
        
        
        return new ApexPages.Action('{!List}').invoke();
    }
    public PageReference closePokemonWindow2() {
       PageReference p = new PageReference('/apex/PokemonGame');
       p.setRedirect(true);
       return p;
       
    }
}