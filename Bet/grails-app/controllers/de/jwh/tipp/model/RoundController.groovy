package de.jwh.tipp.model

import grails.plugin.springsecurity.annotation.Secured

import org.springframework.dao.DataIntegrityViolationException

class RoundController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [roundInstanceList: Round.list(params), roundInstanceTotal: Round.count()]
    }
	@Secured(['ROLE_ADMIN'])
    def create() {
        [roundInstance: new Round(params)]
    }
	@Secured(['ROLE_ADMIN'])
    def save() {
        def roundInstance = new Round(params)
        if (!roundInstance.save(flush: true)) {
            render(view: "create", model: [roundInstance: roundInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'round.label', default: 'round'), roundInstance.id])
        redirect(action: "show", id: roundInstance.id)
    }
	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def show(Long id) {
        def roundInstance = Round.get(id)
        if (!roundInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'round'), id])
            redirect(action: "list")
            return
        }

        [roundInstance: roundInstance]
    }
	@Secured(['ROLE_ADMIN'])
    def edit(Long id) {
        def roundInstance = Round.get(id)
        if (!roundInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'round'), id])
            redirect(action: "list")
            return
        }

        [roundInstance: roundInstance]
    }
	@Secured(['ROLE_ADMIN'])
    def update(Long id, Long version) {
        def roundInstance = Round.get(id)
        if (!roundInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'round'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (roundInstance.version > version) {
                roundInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'round.label', default: 'round')] as Object[],
                          "Another user has updated this round while you were editing")
                render(view: "edit", model: [roundInstance: roundInstance])
                return
            }
        }

        roundInstance.properties = params

        if (!roundInstance.save(flush: true)) {
            render(view: "edit", model: [roundInstance: roundInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'round.label', default: 'round'), roundInstance.id])
        redirect(action: "show", id: roundInstance.id)
    }
	@Secured(['ROLE_ADMIN'])
    def delete(Long id) {
        def roundInstance = Round.get(id)
        if (!roundInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'round.label', default: 'round'), id])
            redirect(action: "list")
            return
        }

        try {
            roundInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'round.label', default: 'round'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'round.label', default: 'round'), id])
            redirect(action: "show", id: id)
        }
    }
}
