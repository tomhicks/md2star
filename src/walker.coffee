toTree = require("markdown").markdown.parse

parseNode = require "./parse-node"

renderNode = (renderer, node, index) ->
  nodeRenderer = renderer[node.type]

  if not nodeRenderer?
    throw new Error("No renderer is defined for the '#{node.type}' node type.
You need to implement a '#{node.type}' function in the supplied renderer.")

  if node.type is "text"
    nodeRenderer(node.attributes.content, index)
  else
    childValues = node.children.map (child, mapIndex) ->
      parsedChild = parseNode(child)
      renderNode(renderer, parsedChild, mapIndex)

    children = renderer.join(childValues)
    if node.attributes
      nodeRenderer(node.attributes, children, index)
    else
      nodeRenderer(children, index)

module.exports = (renderer) ->
  renderer.markdown = (children) -> children

  (rootNode) ->
    if typeof rootNode is "string"
      rootNode = toTree(rootNode)

    node = parseNode(rootNode)
    result = renderNode(renderer, node)
