package de.jwh.tipp.model

class Round {
String title
int category
static hasMany = [games: Game]
    static constraints = {
		title blank:false; 
		category min:0 ,nullable:false
		games nullable:true
    }
	@Override
		public String toString() {
			return title;
		}
}
