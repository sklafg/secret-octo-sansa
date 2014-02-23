package de.jwh.tipp.model
import grails.plugin.springsecurity.annotation.Secured;
import de.jwh.tipp.security.Role;
import de.jwh.tipp.security.User
import org.springframework.dao.DataIntegrityViolationException

class BetController {

	def springSecurityService

 @Secured(['IS_AUTHENTICATED_REMEMBERED'])
	def saveOrUpdate(Long id, int hostGoals, int visitorGoals ){
		def game = Game.get(id)
		def user = springSecurityService.currentUser
		def bet = Bet.findByUserAndGame(user, game)

		if(bet==null){
			bet = new Bet(user:user,game:game)
		}
		bet.visitorGoals = visitorGoals
		bet.hostGoals = hostGoals
		if(game.date > new Date()){
			bet.save();
		}

		redirect(action:"show", controller:"game", id:id)
	}

	def averageBet(Long id){
		def game = Game.get(id)
		def bets = Bet.findAllByGame(game)
		int visitorGoals = 0
		int hostGoals = 0
		if (!bets.isEmpty()){
			bets.each {bet ->
				visitorGoals += bet.visitorGoals
				hostGoals += bet.hostGoals
			}
			visitorGoals = visitorGoals/bets.size()
			hostGoals = hostGoals/bets.size()
		}
		
		[hostGoals: hostGoals, visitorGoals:visitorGoals]
	}
}