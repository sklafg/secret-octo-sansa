package de.jwh.tipp.model


class Game {

	Team host
	Team visitor
	Date date
	int hostGoals
	int visitorGoals
	Round round
	static belongsTo = Round
	static hasMany = [bets:Bet]
	static constraints = {
		host nullable:false, blank:false
		visitor nullable:false,blank:false
		hostGoals min: 0, nullable:false
		visitorGoals min: 0 , nullable:false
	}

	@Override
	public String toString() {
		return host.toString()+" "+hostGoals+":"+visitorGoals+" "+visitor.toString();
	}
}