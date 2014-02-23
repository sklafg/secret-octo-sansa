package de.jwh.tipp.model



import org.junit.*
import grails.test.mixin.*

@TestFor(RoundController)
@Mock(Round)
class RoundControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/gameGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.gameGroupInstanceList.size() == 0
        assert model.gameGroupInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.gameGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.gameGroupInstance != null
        assert view == '/gameGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/gameGroup/show/1'
        assert controller.flash.message != null
        assert Round.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/gameGroup/list'

        populateValidParams(params)
        def gameGroup = new Round(params)

        assert gameGroup.save() != null

        params.id = gameGroup.id

        def model = controller.show()

        assert model.gameGroupInstance == gameGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/gameGroup/list'

        populateValidParams(params)
        def gameGroup = new Round(params)

        assert gameGroup.save() != null

        params.id = gameGroup.id

        def model = controller.edit()

        assert model.gameGroupInstance == gameGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/gameGroup/list'

        response.reset()

        populateValidParams(params)
        def gameGroup = new Round(params)

        assert gameGroup.save() != null

        // test invalid parameters in update
        params.id = gameGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/gameGroup/edit"
        assert model.gameGroupInstance != null

        gameGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/gameGroup/show/$gameGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        gameGroup.clearErrors()

        populateValidParams(params)
        params.id = gameGroup.id
        params.version = -1
        controller.update()

        assert view == "/gameGroup/edit"
        assert model.gameGroupInstance != null
        assert model.gameGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/gameGroup/list'

        response.reset()

        populateValidParams(params)
        def gameGroup = new Round(params)

        assert gameGroup.save() != null
        assert Round.count() == 1

        params.id = gameGroup.id

        controller.delete()

        assert Round.count() == 0
        assert Round.get(gameGroup.id) == null
        assert response.redirectedUrl == '/gameGroup/list'
    }
}
