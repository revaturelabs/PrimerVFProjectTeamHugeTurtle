                
				/*Main Custom Controller for Primer Project1 by Team: Huge Turtle   Author: Ashley Sarah Bee*/
public with sharing class PokemonGameController {
    //bound variables
    public string random {get; set;} 
    public String selected {get; set;}
    public String selectedA {get; set;}
    public String selectedB {get; set;}
    public String picNew {get; set;}
    public String[] selectedArmy {get; set;}
    public List<SelectOption>selectAnSList;
    public List<Battle_Round__c> battleRound;
    public List<Battle__c> battle;
    public List<My_Poke_Soldier__c> Soldier;
    public List<My_Poke_Soldier__c> MySoldier;
    public List<SelectOption> selectArmyList;
    public Boolean displayStats {get; set;}{displayStats=false;}
    public Boolean displayBattle {get; set;}{displayBattle=false;}
    public Boolean displayStatsB {get; set;}{displayStatsB=false;}
    public List<SelectOption>selectAnsListExternal;
    public Pokemon__c[] pokePics;
    
	//No Argument Class constructor
    public PokemonGameController(){}
    
    //getter for Battle__c Object List battle to display Battle details
	Public List<Battle__c> getbattle(){
        List<Battle__c> btl=[SELECT Id, Name, Battle_Name__c, Victorious_Army_Name__c, My_Survivor_Count__c, Opponent_Survivor_Count__c FROM Battle__c WHERE Opponent_Army_Name__c=:random ];
        return btl;
    }
    
	//getter for Battle_Round__c Object List battleRound to display statistics
	Public List<Battle_Round__c> getbattleRound(){
        List<Battle_Round__c> brr= [SELECT Id, 
                                    Battle__r.Name,Battle__r.Victorious_Army_Name__c,
                                    Battle__r.My_Survivor_Count__c, 
                                    Battle__r.Opponent_Survivor_Count__c,
                                         My_Team_Name__c,
                                         Battle_Round_No__c,
                                         My_Pokemon_Name__c,
                                         My_Soldier_No__c,
                                         My_Pokemon_Type1__c,
                                         My_Pokemon_Type2__c,
                                         Opponent_Team_Name__c,
                                         Opponent_Pokemon_Name__c,
                                         Opponent_Soldier_No__c,
                                         Opponent_Pokemon_Type1__c,
                                         Opponent_Pokemon_Type2__c,
                                         Round_Score__c,
                                         Won_Lost__c
                                         FROM Battle_Round__c WHERE Opponent_Team_Name__c = :random ORDER BY Battle_Round_No__c];
     return brr;   
    }
	
	//getter for pokePics Pokemon__c Object list for Pokedex	
    public List<Pokemon__c> getpokePics(){
        
        List<Pokemon__c> pokemondex = [SELECT Name,Pokemon_Image_URL__c FROM Pokemon__c];
        return pokemondex;
    }
    
	//getter for External Army Dropdown that stays hidden
    public List<SelectOption> getselectAnsListExternal(){
       List<Ene_my_Poke_Army__c> mpk = [SELECT Id, Name FROM Ene_my_Poke_Army__c];
        List<Ene_MyPokeSoldier__c> pokemon = [SELECT External_Poke_Army__c, Pokemon_Name__c FROM Ene_MyPokeSoldier__c];
        List<SelectOption> AnS= new List<SelectOption>();
        String concat='Pick the External Pokemon Army ';
        AnS.add(new SelectOption(concat,concat));
        for(Ene_my_Poke_Army__c k:mpk ){
            concat=k.Name + ':';
            for (Ene_MyPokeSoldier__c p:pokemon){
                if(p.External_Poke_Army__c==k.id){ (concat +=p.Pokemon_Name__c +' ');} 
            } AnS.add(new SelectOption(concat,concat));
            } return AnS; 
    }
	
	//getter for selecting options for Pick an Army dropdown
    public List<SelectOption> getselectAnSList(){
        List<My_Poke_Army__c> mpk = [SELECT Id, Name FROM My_Poke_Army__c];
        List<My_Poke_Soldier__c> pokemon = [SELECT My_Poke_Army__c, Pokemon__r.Name FROM My_Poke_Soldier__c];
        List<SelectOption> AnS= new List<SelectOption>();
        String concat='Pick an Army ';
        AnS.add(new SelectOption(concat,concat));
        for(My_Poke_Army__c k:mpk ){
            concat=k.Name + ':';
            for (My_Poke_Soldier__c p:pokemon){
                if(p.My_Poke_Army__c==k.id){ (concat +=p.Pokemon__r.Name +' ');} 
            } AnS.add(new SelectOption(concat,concat));
            } return AnS;
        }
      
        
    
    //getter for multi-select dropdown
	public List<SelectOption> getselectArmyList(){
        List<Pokemon__c> plist = [SELECT Name, Pokemon_Type1__c, Pokemon_Type2__c FROM Pokemon__c];
        List<SelectOption> so = new List<SelectOption>();
        for(Pokemon__c pkmn:plist){
           
            so.add( new SelectOption(pkmn.Name, pkmn.Name));
           
        } return so;
        
    }
    
	//getter for MySoldier
    public My_Poke_Soldier__c[] getMySoldier(){
        List<My_Poke_Soldier__c> r=[SELECT My_Poke_Soldier_No__c, Pokemon__c, Pokemon__r.Pokemon_Type1__c,Pokemon__r.Pokemon_Type2__c, Pokemon__r.Name,Pokemon__r.Pokemon_Image__c, Pokemon__r.Pokemon_Number__c, My_Poke_Army__r.Name FROM My_Poke_Soldier__c ORDER BY My_Poke_Soldier_No__c];
        List<My_Poke_Soldier__c> returnMySoldier= new List<My_Poke_Soldier__c>();
        
        for (My_Poke_Soldier__c a:r){            
            if(a.My_Poke_Army__r.Name==selected){
               returnMySoldier.add(a);
            }else if((selected=='')&&(a.My_Poke_Army__r.Name==selectedA)){
                returnMySoldier.add(a);
                }
        }return returnMySoldier;
    }
    
    //getter for Soldier
    public My_Poke_Soldier__c[] getSoldier(){
        List<My_Poke_Soldier__c> r=[SELECT My_Poke_Soldier_No__c, Pokemon__c, Pokemon__r.Name,Pokemon__r.Pokemon_Image__c, Pokemon__r.Pokemon_Number__c,Pokemon__r.Pokemon_Type1__c,Pokemon__r.Pokemon_Type2__c, My_Poke_Army__r.Name FROM My_Poke_Soldier__c];
        List<My_Poke_Soldier__c> returnSoldier= new List<My_Poke_Soldier__c>();
        for (My_Poke_Soldier__c a:r){            
            if(a.My_Poke_Army__r.Name==random){
               returnSoldier.add(a);
            }
        }return returnSoldier;
    }
    
    //creates displayToggle
	public void showStats(){
        displayStats=true;
        displayBattle=true;
    }
	
	
	//creates Opponent record
    public void randomOpponent(){
        
        
        My_Poke_Army__c pa= new My_Poke_Army__c(Name=random,Army_Type__c='Randomly Generated');
                                   insert pa;
        List<Pokemon__c> p =[SELECT Id FROM Pokemon__c];
        Set<My_Poke_Soldier__c> s= new Set<My_Poke_Soldier__c>();
        My_Poke_Army__c pb=[SELECT Id FROM My_Poke_Army__c WHERE Name=:random];
           
       
        while (s.size()<6){
            Integer n= Integer.valueof(Math.Random()*p.size());
            My_Poke_Soldier__c ps= new My_Poke_Soldier__c();
            ps.Pokemon__c=p[n].Id;
            ps.Active__c=true;
            ps.My_Poke_Army__c= pb.Id;
            s.add(ps);
            system.debug(ps);
        }
        system.debug(s);
        List <My_Poke_Soldier__c> mps= new List<My_Poke_Soldier__c>();
        Integer i=1;
        for (My_Poke_Soldier__c pks:s){
            pks.My_Poke_Soldier_No__c=String.valueof(i);
            i++;
            mps.add(pks);
        }insert mps;      
       
 }
    //creates records for My_PokE_Army__c and 6 soldiers in My_Poke_Soldier__c
	
	public void createMyArmy(){
        
        system.debug(selectedArmy);
        if((selectedArmy.size())==6 && selected =='' && selectedA!=null && selectedA !='Pick an Army'){ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please pick exactly 6 Pokemon!Or Pick a Pre-Built Army. Cannot do Both'));}
        else if(selectedArmy.size()==0 && selectedA!=null && selectedA!='Pick an Army '){
            selectedA= selectedA.substringBefore(':');
        } else if(selectedArmy.size()!=6|| selected==''){ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please pick exactly 6 Pokemon!And make sure you have picked a name for your selection'));} 
          else if(selectedArmy.size()==6 && selected!=''){ 
        
        List<Pokemon__c> pokmn=[SELECT Id,Name FROM Pokemon__c WHERE Name IN:selectedArmy];
        system.debug(pokmn[0]);
        system.debug(pokmn[1]);
        system.debug(pokmn.size());
               
        My_Poke_Army__c pa= new My_Poke_Army__c(Name=selected,Army_Type__c='Hand Picked');
                  insert pa;
              
        My_Poke_Army__c pb=[SELECT Id FROM My_Poke_Army__c WHERE Name=:selected];
        List<My_Poke_Soldier__c> mps= new List<My_Poke_Soldier__c>();
        Integer i=1;
        for(Pokemon__c n:pokmn){
            My_Poke_Soldier__c ps= new My_Poke_Soldier__c();
            ps.Pokemon__c=n.Id;
            ps.Active__c=true;
            ps.My_Poke_Army__c= pb.Id;
            ps.My_Poke_Soldier_No__c=String.valueof(i);
                i++;
            mps.add(ps);
            system.debug(ps);
        }insert mps; 
        }  
    }
	
	
	//clears for my selection Start Over Button
    public void clearInputs(){
        if (selected != null){
            List<My_Poke_Army__c> clearArmy=[SELECT Id FROM My_Poke_Army__c WHERE Name=:selected];
            //List<My_Poke_Soldier__c> clearSoldier=[ SELECT Id FROM My_Poke_Soldier__c WHERE My_Poke_Army__r.Name=:selected];
            if (clearArmy != null){delete clearArmy;}
            //if (clearSoldier != null){delete clearSoldier;}
            selected=null;selectedArmy=null;
            }
        if (selectedA != null){selectedA=null;}
        if (selectedB != null){selectedB=null;}
        if (selectedArmy !=null){ 
            if (selected!= null){
                List<My_Poke_Soldier__c> psol=[SELECT Id FROM My_Poke_Soldier__c WHERE My_Poke_Army__r.Name=:selected];
                if(psol != null){delete psol;}            
            selectedArmy=null; selected=null;selectedA=null; selectedB=null;}
    }
    }
	
	//clears for Opponent Start Over Button
    public void clearChoices(){
        if (random != null){
            List<My_Poke_Army__c> clearArmy=[SELECT Id FROM My_Poke_Army__c WHERE Name=:random];
            if (clearArmy != null){delete clearArmy;}
            random=null;
            }
        if (selectedB != null){selectedB=null;}
        if(selectedA !=null){selectedA=null;}
        
    }
    
    //assigning team name to selectedB
	public void showMyArmy(){
        if(selectedB != null && selectedB != 'Pick the External Pokemon Army'){
            selectedB= selectedB.substringBefore(':');
        }
    }
	
	//trying to add clicked to selection = NOT happening
    public void addSelection(){
        
        system.debug(picNew);
        selectedArmy.add(picNew);
        system.debug(selectedArmy);
    }
    
	 //adds vf page on button click
     public PageReference goAddPokemon() {
       PageReference p = new PageReference('/apex/AddPokemon');
       p.setRedirect(true);
       return p;
       
    }
    
    //game Logic
    public void gameon(){
        displayStatsB=true;
       
        List<Battle_Round__c> brc= new List <Battle_Round__c>();
        
        //Set<My_Poke_Soldier__c> pp=new Set<My_Poke_Soldier__c>();
        //Set<My_Poke_Soldier__c> qq=new Set<My_Poke_Soldier__c>();
        
        List<My_Poke_Soldier__c> setActive =[SELECT Active__c FROM My_Poke_Soldier__c];
            for(My_Poke_Soldier__c s:setActive){
               s.Active__c=true;
            }        
        String myTeam='';
        String eneMyTeam='';
        Boolean onlineOpponent=false;
        system.debug(selectedA);
        String myselected=selectedA.substringBefore(':');
        If (selected!=null){myTeam=selected;}
        if (selectedArmy.size()==0 && selectedA!=null && selectedA!='Pick an Army') {system.debug(selectedA); myTeam=myselected;}
        system.debug(myTeam);
        If (random!=null){eneMyTeam=random;} else if (selectedB !=null && selectedB!='Pick the External Pokemon Army') {eneMyTeam=selectedB;onlineOpponent=true;}
        system.debug(eneMyTeam);
        If (onlineOpponent==false){
            Id MyTeamId;
            Id OTeamId;
        List<My_Poke_Soldier__c> myteamP=[SELECT Id,My_Poke_Army__c,My_Poke_Army__r.Name,Pokemon__r.Name, Pokemon__r.Pokemon_Type1__c, Pokemon__r.Pokemon_Type2__c, My_Poke_Soldier_No__c, My_Battle_Score__c, Active__c FROM My_Poke_Soldier__c WHERE My_Poke_Army__r.Name=:myTeam ORDER BY My_Poke_Soldier_No__c asc ];
        system.debug(myteamP);
            for(My_Poke_Soldier__c x:myteamP){
                MyTeamId=x.My_Poke_Army__c;
            }
        List<My_Poke_Soldier__c> oteamP=[SELECT Id,My_Poke_Army__c,My_Poke_Army__r.Name,Pokemon__r.Name, Pokemon__r.Pokemon_Type1__c, Pokemon__r.Pokemon_Type2__c,My_Poke_Soldier_No__c,My_Battle_Score__c, Active__c FROM My_Poke_Soldier__c  WHERE My_Poke_Army__r.Name=:enemyTeam ORDER BY My_Poke_Soldier_No__c asc];
        system.debug(oteamP);
            for(My_Poke_Soldier__c y:oteamP){
                OTeamId=y.My_Poke_Army__c;
            }
        Integer j=1;
        List<PokemonTypeChart__c> typeChart=[SELECT Attacking__c,Normal__c,Fire__c,Water__c,Electric__c,Grass__c,Ice__c,Fighting__c,Poison__c,Ground__c,Flying__c,Psychic__c,Bug__c,Rock__c,Ghost__c,Dragon__c,Dark__c,Steel__c,Fairy__c FROM PokemonTypeChart__c ];
        system.debug(typeChart[0]);
            for(My_Poke_Soldier__c m:myteamP){
                
              for(My_Poke_Soldier__c o:oTeamP){
                  
                String myType1=m.Pokemon__r.Pokemon_Type1__c;
                String myType2=m.Pokemon__r.Pokemon_Type2__c;
                String oType1=o.Pokemon__r.Pokemon_Type1__c;
                String oType2=o.Pokemon__r.Pokemon_Type2__c;
                Decimal myScore=m.My_Battle_Score__c;
                  if (myType1==null){myType1='None';}
                  if (myType2==null){myType2='None';}
                  if (oType1==null){oType1='None';}
                  if (oType2==null){oType2='None';}
                  if(myScore==null){myScore=0;}
                  if(m.Active__c==true && o.Active__c==true){ myScore=0;
                for (PokemonTypeChart__c tc:typechart){    
                    
                    if (myType1==tc.Attacking__c){
                        
                        Switch on (oType1){
                            When 'Normal'{ myScore+= tc.Normal__c;}
                            When 'Fire'{ myScore+= tc.Fire__c;}
                            When 'Water'{ myScore+= tc.Water__c;}
                            When 'Electric'{ myScore+= tc.Electric__c;}
                            When 'Grass'{ myScore+= tc.Grass__c;}
                            When 'Ice'{ myScore+= tc.Ice__c;}
                            When 'Fighting'{ myScore+= tc.Fighting__c;}
                            When 'Poison'{ myScore+= tc.Poison__c;}
                            When 'Ground'{ myScore+= tc.Ground__c;}
                            When 'Flying'{ myScore+= tc.Flying__c;}
                            When 'Psychic'{ myScore+= tc.Psychic__c;}
                            When 'Bug'{ myScore+= tc.Bug__c;}
                            When 'Rock'{ myScore+= tc.Rock__c;}
                            When 'Ghost'{ myScore+= tc.Ghost__c;}
                            When 'Dragon'{ myScore+= tc.Dragon__c;}
                            When 'Dark'{ myScore+= tc.Dark__c;}
                            When 'Steel'{ myScore+= tc.Steel__c;}
                            When 'Fairy'{ myScore+= tc.Fairy__c;}
                            When 'None'{myScore+=1;}
                            
                            
                        }
                        system.debug(m.My_Poke_Army__c);
                        system.debug(m.Pokemon__r.Name);
                        system.debug(String.valueof(m.My_Poke_Soldier_No__c));
                        system.debug(myType1);
                        system.debug(o.My_Poke_Army__c);
                        system.debug(o.Pokemon__r.Name); 
                        system.debug(o.My_Poke_Soldier_No__c);
                        system.debug(oType1);
                        system.debug(myScore);
                        }
                        
                    else
                    
                       if (myType2==tc.Attacking__c){
                        
                        Switch on (oType2){
                            When 'Normal'{ myScore+= tc.Normal__c;}
                            When 'Fire'{ myScore+= tc.Fire__c;}
                            When 'Water'{ myScore+= tc.Water__c;}
                            When 'Electric'{ myScore+= tc.Electric__c;}
                            When 'Grass'{ myScore+= tc.Grass__c;}
                            When 'Ice'{ myScore+= tc.Ice__c;}
                            When 'Fighting'{ myScore+= tc.Fighting__c;}
                            When 'Poison'{ myScore+= tc.Poison__c;}
                            When 'Ground'{ myScore+= tc.Ground__c;}
                            When 'Flying'{ myScore+= tc.Flying__c;}
                            When 'Psychic'{ myScore+= tc.Psychic__c;}
                            When 'Bug'{ myScore+= tc.Bug__c;}
                            When 'Rock'{ myScore+= tc.Rock__c;}
                            When 'Ghost'{ myScore+= tc.Ghost__c;}
                            When 'Dragon'{ myScore+= tc.Dragon__c;}
                            When 'Dark'{ myScore+= tc.Dark__c;}
                            When 'Steel'{ myScore+= tc.Steel__c;}
                            When 'Fairy'{ myScore+= tc.Fairy__c;}
                            When 'None'{myScore+=1;}
                            
                            
                        }
                        system.debug(m.My_Poke_Army__c);
                        system.debug(m.Pokemon__r.Name);
                        system.debug(String.valueof(m.My_Poke_Soldier_No__c));
                        system.debug(myType2);
                        system.debug(o.My_Poke_Army__c);
                        system.debug(o.Pokemon__r.Name); 
                        system.debug(o.My_Poke_Soldier_No__c);
                        system.debug(oType2); 
                        system.debug(myScore);
                        }
                    else
                        if(myType1=='None' || myType2=='None'){
                            myScore+=0;
                        }
                       }
               
               Battle_Round__c z = new Battle_Round__c(                                         
                                         My_Team_Name__c=m.My_Poke_Army__r.Name,
                                         My_Pokemon_Name__c=m.Pokemon__r.Name,
                                         My_Soldier_No__c=m.My_Poke_Soldier_No__c,
                                         My_Pokemon_Type1__c=m.Pokemon__r.Pokemon_Type1__c,
                                         My_Pokemon_Type2__c=m.Pokemon__r.Pokemon_Type2__c,
                                         Opponent_Team_Name__c=o.My_Poke_Army__r.Name,
                                         Opponent_Pokemon_Name__c=o.Pokemon__r.Name,
                                         Opponent_Soldier_No__c=o.My_Poke_Soldier_No__c,
                                         Opponent_Pokemon_Type1__c=o.Pokemon__r.Pokemon_Type1__c,
                                         Opponent_Pokemon_Type2__c=o.Pokemon__r.Pokemon_Type2__c,
                                         Round_Score__c= myScore,
                                         Battle_Round_No__c=j
                                         );j++;brc.add(z); z=null;
                system.debug(myScore);m.My_Battle_Score__c=myScore;
                If(myScore<1){m.Active__c=false;}else
                    If(myScore>=1){o.Active__c=false;}
                   update m; update o;
                }
              }
            }
            
            Integer MyCount=[SELECT Count() FROM My_Poke_Soldier__c WHERE My_Poke_Army__r.Name=:myTeam AND Active__c=true];
            Integer OCount=[SELECT Count() FROM My_Poke_Soldier__c WHERE My_Poke_Army__r.Name=:eneMyTeam AND Active__c=true];
            System.debug('---------------');
            system.debug(MyCount);
            system.debug(OCount);
            system.debug(myTeamId);
            system.debug(OTeamId);
            If(MyCount > OCount){Battle__c b= new Battle__c (Battle_Name__c= myTeam + ' Vs ' + eneMyTeam, Battling_Army_1_MyArmy__c= myTeamId,Battling_Army_2_Opponent__c=OTeamId,My_Battling_Army_Name__c=myTeam, Opponent_Army_Name__c=eneMyTeam,Victorious_Army_Name__c=myTeam, My_Survivor_Count__c=MyCount, Opponent_Survivor_Count__c=OCount);system.debug('b');insert b;
                                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'YOU LUCKY DEVIL. YOU WON!'));
                                 for(Battle_Round__c x:brc){x.Battle__c=b.id;}insert brc;
                               } 
            If(MyCount == OCount){Battle__c b= new Battle__c (Battle_Name__c= myTeam + ' Vs ' + eneMyTeam, Battling_Army_1_MyArmy__c= myTeamId,Battling_Army_2_Opponent__c=OTeamId,My_Battling_Army_Name__c=myTeam, Opponent_Army_Name__c=eneMyTeam,Victorious_Army_Name__c=myTeam, My_Survivor_Count__c=MyCount, Opponent_Survivor_Count__c=OCount);system.debug('b');insert b;
                                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'KEEP CALM. YOU DID NOT LOSE. ITs A TIE!'));
                                 for(Battle_Round__c x:brc){x.Battle__c=b.id;}insert brc;                                
                               } 
            If(MyCount < OCount){Battle__c b= new Battle__c (Battle_Name__c= myTeam + ' Vs ' + eneMyTeam, Battling_Army_1_MyArmy__c= myTeamId,Battling_Army_2_Opponent__c=OTeamId,My_Battling_Army_Name__c=myTeam, Opponent_Army_Name__c=eneMyTeam,Victorious_Army_Name__c=enemyTeam,My_Survivor_Count__c=MyCount, Opponent_Survivor_Count__c=OCount);system.debug('b');insert b;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'YOU POOR DEVIL. YOU LOST THIS TIME!'));
                            for(Battle_Round__c x:brc){x.Battle__c=b.id;}insert brc;
                               }

           
                                          
        }        
    }
}				