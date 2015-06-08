parseNode = require "./parse-node"

renderNode = (renderer, node) ->
  if node.type is "text"
    renderer.text node.attributes.content
  else
    childValues = node.children.map (child) ->
      parsedChild = parseNode(child)
      renderNode(renderer, parsedChild)

    children = renderer.join(childValues)
    if node.attributes
      renderer[node.type](node.attributes, children)
    else
      renderer[node.type](children)

module.exports = (renderer) ->
  renderer.markdown = (children) -> children

  (rootNode) ->
    node = parseNode(rootNode)
    result = renderNode(renderer, node)
