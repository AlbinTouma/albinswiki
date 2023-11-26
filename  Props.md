---
title: Yew_notes_properties
layout: default
---

# Properties 

Properties are component arguments that Yew can keep watch on.  A type has to
implemnet the `Properties` trait before it can be used as the properties ofa
component. 

## Reactivity

Yew checks if props have changed when reconciling the virutal DOM during
re-rendering. This makes Yew a reactive framework as changes from parent will
always be propagated downward. 

## Derive Macro

Yew provides a `derive macro` to implement Properties trait on structs. Types
for which you derive Properties must also implement `PartialEq` so Yew can do
data comparison. 

```
#[derive(Properties, PartialEq)]
pub struct Props {
    pub is_loading: bool,
}
```

## Use Props in function components

The function component allows recieving props in the function argument. To
supply them, they are assigned via attributes in the html! macro.

```
#[derive(Properties, PartialEq)]
pub struct Props {
    pub is_loading: bool,
}

#[function_component]
fn HelloWorld(props: &Props) -> Html {
    html! { <>{"Am I loading? - "}{props.is_loading.clone()}</> }
}

// Then supply the prop
#[function_component]
fn App() -> Html {
    html! {<HelloWorld is_loading={true} />}
}
```

## Derive macro field attributes

When deriving properties all fields are required by default. Attributes allow
you to give your props default values which will be used when the parent has
not set them. 

`[prop_or_default]` initilaise the prop value with the default value of the
field's type using the `Default` trait. 
```
#[derive(Properties, PartialEq)]
pub struct Props {
    #[prop_or_default]
    pub is_loading: bool,
}
```

`#[prop_or(value]`, use value in True to initialise the prop value. Value can
be any expression. For example, to default a boolean prop to true use the
attribute #[prop_or(True)]. 

```
#[derive(Properties, PartialEq)]
pub struct Props {
    #[prop_or("Bob".to_string())]
    pub name: String,
}
```

`#[prop_or_else(function)]` should have the signature `FnMut() -> T` where T is
the field type. The function is called when no explicit value has been given
for the attribute. 

```
fn create_default_name() -> String {
    "Bob".to_string()
}

#[derive(Properties, PartialEq)]
pub struct Props {
    #[prop_or_else(create_default_name)]
    pub name: String,
}
```


## Memory/speed overhead of using properties

Internally, properties are reference counted. This means that only a shared
pointer is passed down the component tree for porps.

> Tip: make use of AttrValue which is a custom type for attribute values
> instead of defining them as String or another similar type.

## Props Macro

The macro uses the same syntax as a struct expression except that you can't use attributes or a base expression (Foo { ..base }). The type path can either point to the props directly (path::to::Props) or the associated properties of a component (MyComp::Properties).

The yew::props! macro allows you to build properties the same way the html! macro does it. 
use yew::{function_component, html, Html, Properties, props, virtual_dom::AttrValue};

#[derive(Properties, PartialEq)]
pub struct Props {
    #[prop_or(AttrValue::from("Bob"))]
    pub name: AttrValue,
}

#[function_component]
fn HelloWorld(props: &Props) -> Html {
    html! {<>{"Hello world"}{props.name.clone()}</>}
}

#[function_component]
fn App() -> Html {
    let pre_made_props = props! {
        Props {} // Notice we did not need to specify name prop
    };
    html! {<HelloWorld ..pre_made_props />}
}

Anti Patterns
While almost any Rust type can be passed as properties, there are some anti-patterns that should be avoided. These include, but are not limited to:

-Using String type instead of AttrValue. Why is this bad? String can be expensive to clone. Cloning is often needed when the prop value is used with hooks and callbacks. AttrValue is either a reference-counted string (Rc<str>) or a &'static str, thus very cheap to clone. Note: AttrValue internally is IString from implicit-clone See that crate to learn more. 
-Using interior mutability. Why is this bad? Interior mutability (such as with RefCell, Mutex, etc.) should generally be avoided. It can cause problems with re-renders (Yew doesn't know when the state has changed) so you may have to manually force a render. Like all things, it has its place. Use it with caution. You tell us. Did you run into an edge-case you wish you knew about earlier? Feel free to create an issue or PR a fix to this documentation.




