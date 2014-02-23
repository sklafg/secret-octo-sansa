package de.jwh.tipp.model

import grails.plugin.springsecurity.annotation.Secured

import org.codehaus.groovy.grails.core.io.ResourceLocator
import org.springframework.core.io.Resource
import org.springframework.dao.DataIntegrityViolationException

class TeamController  {
	ResourceLocator grailsResourceLocator
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(['ROLE_ADMIN'])
	def index() {
		redirect(action: "list", params: params)
	}
	@Secured(['ROLE_ADMIN'])
	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[teamInstanceList: Team.list(params), teamInstanceTotal: Team.count()]
	}
	@Secured(['ROLE_ADMIN'])
	def create() {
		[teamInstance: new Team(params)]
	}
	@Secured(['ROLE_ADMIN'])
	def save() {
		def teamInstance = new Team(params)
		if (!teamInstance.save(flush: true)) {
			render(view: "create", model: [teamInstance: teamInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'team.label', default: 'Team'),
			teamInstance.id
		])
		redirect(action: "show", id: teamInstance.id)
	}
	@Secured(['ROLE_ADMIN'])
	def show(Long id) {
		def teamInstance = Team.get(id)
		if (!teamInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'team.label', default: 'Team'),
				id
			])
			redirect(action: "list")
			return
		}

		[teamInstance: teamInstance]
	}
	@Secured(['ROLE_ADMIN'])
	def edit(Long id) {
		def teamInstance = Team.get(id)
		if (!teamInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'team.label', default: 'Team'),
				id
			])
			redirect(action: "list")
			return
		}

		[teamInstance: teamInstance]
	}
	@Secured(['ROLE_ADMIN'])
	def update(Long id, Long version) {
		def teamInstance = Team.get(id)
		if (!teamInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'team.label', default: 'Team'),
				id
			])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (teamInstance.version > version) {
				teamInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'team.label', default: 'Team')] as Object[],
						"Another user has updated this Team while you were editing")
				render(view: "edit", model: [teamInstance: teamInstance])
				return
			}
		}

		teamInstance.properties = params

		if (!teamInstance.save(flush: true)) {
			render(view: "edit", model: [teamInstance: teamInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'team.label', default: 'Team'),
			teamInstance.id
		])
		redirect(action: "show", id: teamInstance.id)
	}
	@Secured(['ROLE_ADMIN'])
	def delete(Long id) {
		def teamInstance = Team.get(id)
		if (!teamInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'team.label', default: 'Team'),
				id
			])
			redirect(action: "list")
			return
		}

		try {
			teamInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'team.label', default: 'Team'),
				id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'team.label', default: 'Team'),
				id
			])
			redirect(action: "show", id: id)
		}
	}
	@Secured(['ROLE_ADMIN'])
	def uploadPic () {
		def teamInstance = Team.get(params.id)
		// Get the avatar file from the multi-part request
		def f = request.getFile('pic')

		// List of OK mime-types
		def okcontents = [
			'image/png',
			'image/jpeg',
			'image/gif'
		]
		if (! okcontents.contains(f.getContentType()))
		{ flash.message = "Avatar must be one of: ${okcontents}"
			redirect action: "show", id:teamInstance.id
			return; }

		// Save the image and mime type
		teamInstance.pic = f.getBytes()
		teamInstance.picType = f.getContentType()
		log.info("File uploaded: " + teamInstance.picType)

		// Validation works, will check if the image is too big
		if (!teamInstance.save()) {
			redirect action: "show", id:teamInstance.id
			return; }
		flash.message = "Avatar (${teamInstance.picType}, ${teamInstance.pic.size()} bytes) uploaded."
		redirect action: "show", id:teamInstance.id
	}


	def teamPic () {
		def team = Team.get(params.id)
		if (!team || !team.pic || !team.picType) {
			final Resource image = grailsResourceLocator.findResourceForURI('images/world_ph.jpg')
			
			def file = image.file
			response.setContentType("application/octet-stream")
			response.setHeader("Content-disposition", "filename=${file.name}")
			response.outputStream << file.bytes
			return
		}else{
			response.setContentType(team.picType)
			response.setContentLength(team.pic.size())}
		OutputStream out = response.getOutputStream();
		out.write(team.pic);
		out.close();
	}


}
