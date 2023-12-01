---
title: Variables and Mutabiltiy
layout: default
---

# 3.1 Variables and Mutability

## Variables

By default variables are immutable. This gives Rust the advatange of safety and
easy concurenccy. You can make variables mutable with `mut`. 

The code below throws the error, "cannot assign twice to immutable variable". 
``
fn main(){
    let x = 5;
    println!("The value of x is: {x}")
    
    x = 6
    println!("The value of x is: {x})

``

The compile error might be frustrating, but immutability of variables is good
because if one part of our code operates on the assumption that a value will
never change and another part of our code changes that value, it's possible that
the first part of the code won't do what it was designed to do. 

Mutability can be useful. Adding `mut` conveys intent to future readers of the
code by indicating that other parts of the code will be changing this variables
value. 

``
fn main(){
    let x = 5;
    println!("The value of x is {x})
    x = 6;
    println!("The value of x is {x})
}
``
## Contants and immutabiltiy

Like immutable variables, **constants** are values that are bound to a name and
no allowed to change. However, constants are different from immutable variables.

Constants cannot use `mut`. They aren't just immutable by default - they're
always immutable. 

Declare a constant using `const`. Constants need their type of value to be
annoted. They can be declared in any scoe, including global scope, which makes
them useful for values that many parts of the code need to know about.

Finally, constants may only be set as a constant expression, not the result of a
value that could only be computed at runtime. 

`` const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3; ``

Rust compiler is able to evaluate a limited set of operations at compile time,
which lets us write 3 seconds in an hour in a way that is easy to understand and
verify rathern than 10,800. 

Naming hardcoded values used throughout your program as constants is useful in
conveying the meaning of that value to future maintainers of the coe. 



## Shadowing

- Shadowing is when you reuse the same variable again by using `let` to avoid
  having to change the name.
- Shadowing is different from using `mut` on a variable. It essentially creates a new variable, so types don't have to match. For example, if we set `mut gender`, and it's a string, and transformation would be a string too. However, if we reassign gender using shadowing, ie `let gender`, we can transform it to an integer. 
  
  
When you declare a new variable with the same name as a previous variable, it's
said that the first variable is `shadowed` by the second. It means that the
second variable is waht the compiler will see when you use the name of that
variable, effectively, the second variable overshadows the first.

`We can shadow a variable by using the same variable's name an drepeating the use
of let keyworkd.`

Shaodowing is idfferent from making a variable mut because we get a compile-time
error if we try to reassign to this variable without using let. By using let, we
can perform a few transofrmations on a value but have the value be immutable
after those transformations. 

Another difference between shadowing and mut is that, because we're creating a
new variable when we use let, we can change the type of the value but reuse the
same name. Ie, lets ask a user how many spaces they want between some text by
inputting space characters, and then store that input as a number:

``
let spaces = "  "
let spaces =  spaces.len()
``

The first spaces is a string type and the second is a number type. Shadowing
spares us from having to come up with different names. This wouldn't work if we
set spaces to mut, as the type changes from string to integer. 











