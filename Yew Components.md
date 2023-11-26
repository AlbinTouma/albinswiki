---
layout: default
title: Yew_notes_components
---


## Function Components

> Yew centrally operates on the idea of keeping everything that a reusable
> piece of UI may need in one place - rust files. 

So what are components? 


## What are components? 

Components are the building blocks of Yew. There are `Functional Components`,
the recommened way to write components when starting with Yew, and more
advanced but less accessible components, `Struct Components`, that allow for
detialed control. 

- Components take arguments in the form of Props
- Components can have their own state
- Compute pieces of HTML visible to user (DOM)

## Functional Components

To create a function component add the `#[function_component]` attribute to a
function. By convention, the function is named in PascalCase, like all
components, to contrast its use to normal html elements inside the html macro. 

```
use yew::{function_component, html, Html};

#[function_component]
fn HelloWorld() -> Html {
    html! { "Hello world" }
}

// Then somewhere else you can use the component inside `html!`
#[function_component]
fn App() -> Html {
    html! { <HelloWorld /> }
}```




