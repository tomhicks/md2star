htmlAttrsToString = (attributes) ->
  Object.keys(attributes).map((currentKey) ->
    "#{currentKey}=\"#{attributes[currentKey]}\""
  ).join(" ")

plainTag = (el) ->
  (content) -> "<#{el}>#{content}</#{el}>"

module.exports =
  para: plainTag("p")

  link: (attributes, children) ->
    "<a #{htmlAttrsToString(attributes)}>#{children}</a>"

  header: ({level}, children) ->
    "<h#{level}>#{children}</h#{level}>"

  listitem: plainTag("li")

  bulletlist: plainTag("ul")

  numberlist: plainTag("ol")

  text: (content) -> content

  em: plainTag("em")

  join: (items) -> items.join("")
