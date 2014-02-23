package de.jwh.tipp.model

import de.jwh.tipp.security.User;

class Bet {

	User user
	Game game
	int visitorGoals
	int hostGoals

	static constraints = {
		user nullable:false;
		game nullable:false;
		visitorGoals min:0, nullable:false;
		hostGoals min:0, nullable:false;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return user.toString()+": "+ game.host+" "+hostGoals+" : " +visitorGoals+" "+ game.visitor;
	}

	public ResultType getResult(){
		if(this.game.date < new Date()){
			def tendency = (this.hostGoals-this.visitorGoals)==(this.game.hostGoals- this.game.visitorGoals)
			if(tendency){
				if(this.hostGoals == this.game.hostGoals){
					return ResultType.RIGHT_TIPP
				}else{
					return ResultType.TENDENCY_TIPP
				}
			}else{
				return ResultType.WRONG_TIPP
			}
		}else{
			return ResultType.TIPP_NOT_OVER
		}
	}
}
