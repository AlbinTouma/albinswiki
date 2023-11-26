---
layout: default
title: Yew_notes_html!
---
### HTML with html! 

- You write html with `html!` and embed values from surrounding context with
  curly brackets
- html! only allows 1 wrapping node to be returned. Similar to React, to render a list of
  elements, you use `fragments` ie `<> </>` tags without a name that do not produce html
  by themselves. 

You can write expressions resembling HML with `html!`. Behind the scenes, Yew
turns it into rust code representing the DOM to generate. 

Similar to format expressions, you can embed values from surrounding context
into HTML with curly brackets. The major rule with html! is that you can only
return 1 wrapping node. To render a list of elements, html! allows `fragments` or `<> </>`  ie
tags without a name that produce no html by themselves. 

```
use yew::prelude::*;

let header_text = "Hello world".to_string();
let header_html: Html = html! {
    <h1>{header_text}</h1>
};

let count: usize = 5;
let counter_html: Html = html! {
    <p>{"My age is: "}{count}</p>
};

let combined_html: Html = html! {
    <div>{header_html}{counter_html}</div>
};

```


