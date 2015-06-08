toTree = require("markdown").markdown.parse

parseNode = require "./parse-node"

renderNode = (renderer, node) ->
  nodeRenderer = renderer[node.type]

  if not nodeRenderer?
    throw new Error("No renderer is defined for the '#{node.type}' node type.
You need to implement a '#{node.type}' function in the supplied renderer.")

  if node.type is "text"
    nodeRenderer node.attributes.content
  else
    childValues = node.children.map (child) ->
      parsedChild = parseNode(child)
      renderNode(renderer, parsedChild)

    children = renderer.join(childValues)
    if node.attributes
      nodeRenderer(node.attributes, children)
    else
      nodeRenderer(children)

module.exports = (renderer) ->
  renderer.markdown = (children) -> children

  (rootNode) ->
    if typeof rootNode is "string"
      rootNode = toTree(rootNode)

    node = parseNode(rootNode)
    result = renderNode(renderer, node)
