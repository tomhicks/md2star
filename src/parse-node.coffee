module.exports = (node) ->
  if typeof node is "string"
    type: "text"
    attributes: content: node
    children: []
  else

    [type, rest...] = node
    if Array.isArray(rest[0]) or typeof rest[0] is "string"
      children = rest
    else
      [attributes, children...] = rest

    {type, children, attributes}
