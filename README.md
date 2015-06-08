# murray

Convert JSON ML tree into whatever format.

A JSON ML tree is created by the markdown-js project as an intermediate format.
This project provides a walker to walk that tree format, calling into a set of
passed rendering functions to allow you to write out your own resulting format.

A sample (and unfinished) HTML renderer exists that implements rendering for
headings, paragraphs, links, lists and emphasis items.

The original motivation for this project was to allow rendering of markdown
into React components. By supplying our own renderer to this walker, we are
able to render components from our React component library, instead of plain
HTML.

## Installation

```npm install --save murray```

## Usage

```javascript
var toTree = require('markdown').markdown.parse;
var walker = require('murray');

var markdownString = fs.readFileSync(pathToMarkdownFile).toString();
var markdownTree = toTree(markdownString);

var htmlString = walker(walker.htmlRenderer)(markdownTree);

var myReactComponentRenderer = {
  join: function (items) { return items; }
  para: function (children) { <p>{children}</p> }
  header: function (options, children) {
    <MyHeadingComponent level = {options.level}>
      {children}
    </MyHeadingComponent>
  }
  ...
};

var reactElement = walker(myReactComponentRenderer)(markdownTree);
```

## Name

Why is it called Murray? Well, it's a (tree) walker, and texas-ranger was already taken, and [Murray Walker](http://en.wikipedia.org/wiki/Murray_Walker) is awesome:

![Murray Walker being awesome](./murray.png?raw=true "Murray Walker being awesome")
