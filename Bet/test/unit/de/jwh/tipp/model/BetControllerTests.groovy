package de.jwh.tipp.model



import org.junit.*
import grails.test.mixin.*

@TestFor(BetController)
@Mock(Bet)
class BetControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/bet/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.betInstanceList.size() == 0
        assert model.betInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.betInstance != null
    }

    void testSave() {
        controller.save()

        assert model.betInstance != null
        assert view == '/bet/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/bet/show/1'
        assert controller.flash.message != null
        assert Bet.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/bet/list'

        populateValidParams(params)
        def bet = new Bet(params)

        assert bet.save() != null

        params.id = bet.id

        def model = controller.show()

        assert model.betInstance == bet
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/bet/list'

        populateValidParams(params)
        def bet = new Bet(params)

        assert bet.save() != null

        params.id = bet.id

        def model = controller.edit()

        assert model.betInstance == bet
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/bet/list'

        response.reset()

        populateValidParams(params)
        def bet = new Bet(params)

        assert bet.save() != null

        // test invalid parameters in update
        params.id = bet.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/bet/edit"
        assert model.betInstance != null

        bet.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/bet/show/$bet.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        bet.clearErrors()

        populateValidParams(params)
        params.id = bet.id
        params.version = -1
        controller.update()

        assert view == "/bet/edit"
        assert model.betInstance != null
        assert model.betInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/bet/list'

        response.reset()

        populateValidParams(params)
        def bet = new Bet(params)

        assert bet.save() != null
        assert Bet.count() == 1

        params.id = bet.id

        controller.delete()

        assert Bet.count() == 0
        assert Bet.get(bet.id) == null
        assert response.redirectedUrl == '/bet/list'
    }
}
