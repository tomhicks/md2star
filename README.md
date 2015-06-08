# md2star

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
