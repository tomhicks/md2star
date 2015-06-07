{expect} = require "chai"

parseNode = require "../src/parse-node"

describe "parsing node values", ->
  it "should extract type and children from a child-only node", ->
    expect(parseNode([
      'markdown',
      'child 1',
      'child 2'
    ])).to.eql
      type: 'markdown'
      attributes: undefined
      children: ['child 1', 'child 2']

  it "should extract attributes, type and children from a node with attributes", ->
    expect(parseNode([
      'link',
      {href: 'some url'},
      'child 1',
      ['type', 'child 2']
    ])).to.eql
      type: 'link'
      attributes: {href: 'some url'},
      children: ['child 1', ['type', 'child 2']]

  it "should turn a string into a text node", ->
    expect(parseNode "Hello")
      .to.eql
        type: 'text'
        attributes: {content: "Hello"}
        children: []
