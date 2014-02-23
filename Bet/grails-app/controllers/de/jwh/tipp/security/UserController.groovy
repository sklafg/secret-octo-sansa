package de.jwh.tipp.security

import grails.plugin.springsecurity.annotation.Secured

import org.springframework.dao.DataIntegrityViolationException

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def springSecurityService
    def index() {
        redirect(action: "list", params: params)
    }
	@Secured(['ROLE_ADMIN'])
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }
	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def show(Long id) {
		def userInstance
		if(id == null)
		{
			userInstance=springSecurityService.currentUser
		}else{
        userInstance= User.get(id)
		}
		
		if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }
	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def edit() {
        def userInstance = springSecurityService.currentUser
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }
	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def update(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }
	@Secured(['ROLE_ADMIN'])
    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def uploadPic = {
		def userInstance = User.get(params.id)
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
			redirect action: "show", id:userInstance.id
			return; }

		// Save the image and mime type
		userInstance.pic = f.getBytes()
		userInstance.picType = f.getContentType()
		log.info("File uploaded: " + userInstance.picType)

		// Validation works, will check if the image is too big
		if (!userInstance.save()) {
			redirect action: "show", id:userInstance.id
			return; }
		flash.message = "Avatar (${userInstance.picType}, ${userInstance.pic.size()} bytes) uploaded."
		redirect action: "show", id:userInstance.id
	}


	def userPic = {
		def user = User.get(params.id)
		if (!user || !user.pic || !user.picType) {
			response.sendError(404)
			return;
		}
		response.setContentType(user.picType)
		response.setContentLength(user.pic.size())
		OutputStream out = response.getOutputStream();
		out.write(user.pic);
		out.close();
	}
}
