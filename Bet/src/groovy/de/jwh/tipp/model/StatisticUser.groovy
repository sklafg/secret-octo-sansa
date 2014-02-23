package de.jwh.tipp.model

import de.jwh.tipp.security.User

class StatisticUser {
	
	private final static int RIGHT_POINTS = 3
	private final static int TENDENCY_POINTS = 1
	 User user;
	int rightBets;
	int tendencyBets;
	int wrongBets;
	
	def getPoints(){
		return ((rightBets * RIGHT_POINTS) + (tendencyBets*TENDENCY_POINTS))
	}

}
