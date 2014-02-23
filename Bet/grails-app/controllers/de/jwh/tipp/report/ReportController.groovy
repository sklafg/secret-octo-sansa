package de.jwh.tipp.report

import de.jwh.tipp.model.Bet;
import de.jwh.tipp.model.Game
import de.jwh.tipp.model.Round;
import de.jwh.tipp.model.ResultType;
import de.jwh.tipp.model.StatisticTeam
import de.jwh.tipp.model.StatisticUser
import de.jwh.tipp.model.Team;
import de.jwh.tipp.security.User;

class ReportController {

	def index() {
		redirect(action:"user")
	}

	def user(){
		def userList = [] as List
		User.list().each{ user ->
			def statUser = new StatisticUser(user:user, rightBets: 0,tendencyBets: 0, wrongBets: 0,   )

			Bet.findAllByUser(user).each{ bet ->
				def result = bet.getResult()
				switch (result){
					case ResultType.RIGHT_TIPP :
						statUser.rightBets++
						break
					case ResultType.TENDENCY_TIPP:
						statUser.tendencyBets++
						break
					case ResultType.WRONG_TIPP:
						statUser.wrongBets++
						break
				}
			}

			userList.add(statUser)
		}
		userList.sort{a , b -> a.getPoints() == b.getPoints() ? 0: a.getPoints() > b.getPoints()? -1:1 }
		[users:userList]
	}

	def tableOfRound(Long id){
		def gameGroup = Round.get(id)
		def teamsInGroup = [] as Set
		def teams = [] as List
		gameGroup.games.each{ game ->
			teamsInGroup.add(game.host)
			teamsInGroup.add(game.visitor)
		}
		teamsInGroup.each { team ->
			def statTeam = new StatisticTeam( team)
			gameGroup.games.each { game ->
				statTeam = getDataOfTeam(statTeam, game)
			}
			teams.add(statTeam)
		}
		teams.sort{ a,b ->
			a.points == b.points ? a.games ==b.games? a.goals== b.goals ? a.goalsAgainst == b.goalsAgainst ? 0:a.goalsAgainst < b.goalsAgainst ?1:-1 : a.goals>b.goals? -1 : 1 : a.games< b.games? -1 : 1 : a.points>b.points? -1 : 1
		}
		[teams : teams]
	}

	private StatisticTeam getDataOfTeam(StatisticTeam statTeam, Game game) {
		if(new Date()> game.date){
			if(statTeam.team == game.host){
				statTeam.games ++
				statTeam.goals += game.hostGoals
				statTeam.goalsAgainst += game.visitorGoals

				if(game.hostGoals -game.visitorGoals > 0){
					statTeam.points += 3
				}else if(game.hostGoals - game.visitorGoals == 0){
					statTeam.points++
				}
			}else if(statTeam.team == game.visitor){
				statTeam.games++
				statTeam.goals += game.visitorGoals
				statTeam.goalsAgainst += game.hostGoals
				if(game.hostGoals -game.visitorGoals < 0){
					statTeam.points +=3
				}else if(game.hostGoals - game.visitorGoals == 0){
					statTeam.points++
				}
			}
		}
		return statTeam
	}



	def teams(){
		def teams = Team.all as Set
		def statTeams = [] as List

		teams.each { team ->
			def statTeam  = new StatisticTeam( team)
			Game.all.each{ game ->
				statTeam = getDataOfTeam(statTeam, game)
			}
			statTeams.add(statTeam);
		}
		[teams : statTeams]
	}
}
