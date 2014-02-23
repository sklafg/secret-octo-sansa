package de.jwh.tipp.model

class StatisticTeam {
	Team team
	int games
	int points
	int goals
	int goalsAgainst
	public StatisticTeam(Team team) {
		this.team = team;
		this.games =0
		this.points =0
		this.goals =0
		this.goalsAgainst = 0
	}
}
