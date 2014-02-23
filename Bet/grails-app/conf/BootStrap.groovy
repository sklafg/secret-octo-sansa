import de.jwh.tipp.model.Game;
import de.jwh.tipp.model.Round;
import de.jwh.tipp.model.Team;
import de.jwh.tipp.security.Role
import de.jwh.tipp.security.User
import de.jwh.tipp.security.UserRole;

class BootStrap {
	def openSportsApiService
	def init = { servletContext ->
		
		if(Round.all.isEmpty()){
			new Round(title:"Gruppe A", category:1).save();
			new Round(title:"Gruppe B", category:1).save();
			new Round(title:"Gruppe C", category:1).save();
			new Round(title:"Gruppe D", category:0).save();
			new Round(title:"Gruppe E", category:0).save();
			new Round(title:"Gruppe F", category:0).save();
			new Round(title:"Gruppe G", category:0).save();
		}

		if(Team.all.isEmpty()){
			new Team(name:"Deutschland", code:"GER").save();
			new Team(name:"Italien",code:"ITL").save();
			new Team(name:"England", code:"ENG").save();
			new Team(name:"United States" , code: "USA").save();
			new Team(name:"Frankreich", code:"FRA").save();
			new Team(name:"Spanien", code:"ESP").save();
			new Team(name:"Griechenland", code:"GRE").save();
			new Team(name:"Russland", code:"RUS").save();
			new Team(name:"Niederlande", code:"NED").save();
			new Team(name:"Portugal", code:"POR").save();
			new Team(name:"Kroatien", code:"CRO").save();
			new Team(name:"Schweiz", code:"SUI").save();
			new Team(name:"Belgien", code:"BEL").save();
			new Team(name:"Bosnien und Herzegowina", code:"BIH").save();
			new Team(name:"Algerien", code:"ALG").save();
			new Team(name:"Elfenbeinküste", code:"CIV").save();
			new Team(name:"Ghana", code:"GHA").save();
			new Team(name:"Kamerun", code:"CMR").save();
			new Team(name:"Nigeria", code:"NGA").save();
			new Team(name:"Mexiko", code:"MEX").save();
			new Team(name:"Honduras", code:"HON").save();
			new Team(name:"Costa Rica", code:"CRC").save();
			new Team(name:"Argentinien", code:"ARG").save();
			new Team(name:"Brasilien", code:"BRA").save();
			new Team(name:"Chile", code:"CHI").save();
			new Team(name:"Uruguay", code:"URU").save();
			new Team(name:"Kolumbien", code:"COL").save();
			new Team(name:"Ecuador", code:"ECU").save();
			new Team(name:"Australien", code:"AUS").save();
			new Team(name:"Japan", code:"JPN").save();
			new Team(name:"Südkorea", code:"KOR").save();
			new Team(name:"Iran", code:"IRN").save();
						
		}

		

		if(User.all.isEmpty()){
			User adminUser= new User(username:"jwhoeche", password:'admin', firstname:"John-Wieland",lastname:"Höche",mail:"jw.hoeche@gmail.com", enabled: true).save()
			Role adminRole =new Role(authority: "ROLE_ADMIN", ).save()
			Role userRole =new Role(authority: "ROLE_USER", ).save()
			UserRole.create(adminUser, adminRole);
			UserRole.create(adminUser, userRole);
		}
	}
	def destroy = {
	}
}
