{expect} = require "chai"

renderer = require "../../src/renderer/html"

describe "HTML renderer", ->
  it "should render a paragraph node as a p tag", ->
    expect(renderer.para("Inner content"))
      .to.equal "<p>Inner content</p>"

  it "should render a link as an anhcor tag", ->
    expect(renderer.link({href: "http://www.google.com"}, "inner content"))
      .to.equal '<a href="http://www.google.com">inner content</a>'

  it "should render headings as hX tags", ->
    expect(renderer.header({level: 1} , "inner content"))
      .to.equal '<h1>inner content</h1>'

    expect(renderer.header({level: 2} , "inner content"))
      .to.equal '<h2>inner content</h2>'

  it "should render a bullet list as a ul tag", ->
    expect(renderer.bulletlist("content"))
      .to.equal "<ul>content</ul>"

  it "should render a number list as an ol tag", ->
    expect(renderer.numberlist("content"))
      .to.equal "<ol>content</ol>"

  it "should render a list item as an li tag", ->
    expect(renderer.listitem("content"))
      .to.equal "<li>content</li>"

  it "should render an em node as an em tag", ->
    expect(renderer.em("content"))
      .to.equal "<em>content</em>"

  it "should render a text node as is", ->
    expect(renderer.text("content"))
      .to.equal "content"


  it "should concatenate child elements", ->
    expect(renderer.join(["<p>First child</p>", "<p>Second child</p>"]))
      .to.equal "<p>First child</p><p>Second child</p>"
