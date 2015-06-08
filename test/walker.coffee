chai = require "chai"
{expect} = chai
sinon = require "sinon"
chai.use require "sinon-chai"

walker = require "../src/walker"
htmlRenderer = require "../src/renderer/html"

describe "JSON ML walker", ->

  describe "when rendering a simple paragraph", ->
    beforeEach ->
      @renderer =
        para: -> 'my paragraph content'
        text: -> 'my text content'
        join: (items) -> items.join("")

      sinon.spy(@renderer, 'text')
      sinon.spy(@renderer, 'para')
      texasRanger = walker(@renderer)
      @result = texasRanger 'paragraph content'

    it "should hit the text renderer with the text content", ->
      expect(@renderer.text).to.have.been.calledWith 'paragraph content'

    it "should call the para renderer with the result of the
text content renderer", ->
      expect(@renderer.para).to.have.been.calledWith 'my text content'

  describe "using the HTML renderer", ->

    beforeEach ->
      renderer = htmlRenderer
      @texasRanger = walker(renderer)

    describe "rendering multiple paragraphs", ->
      it "should turn multiple paragraphs into multiple p tags", ->
        result = @texasRanger 'paragraph content\n\nsecond paragraph'

        expect(result)
          .to.equal "<p>paragraph content</p><p>second paragraph</p>"

    describe "rendering a nested paragraph", ->
      it "should render correctly", ->
        result = @texasRanger '[linky](http://www.google.com)'

        expect(result)
          .to.equal "<p><a href=\"http://www.google.com\">linky</a></p>"

    describe "rendering an item with no specified node renderer", ->

      beforeEach ->
        rendererMissingStuff =
          join: (children) -> children
          text: (text) -> text

        @texasRanger = walker(rendererMissingStuff)

      it "should throw explaining the missing renderer", ->
        expect(=> @texasRanger("paragraph")).to.throw "'para' function"
