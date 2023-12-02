---
title: Rust Data Types
layout: default
---

# Data Types in Rust

We'll look at two data type subsets: **scalar** and **compound**.

Rust is **statically typed**, meaning it must know the types of all variables at
compile time. Usually, the compiler can infer the type based on the value and
how we use it, but there are cases when many types are possible, such as when we
convert a String to numeric type using parse. In this case, we must adda  type
annotation: 

``let guess: u32 = "42".parse().expect("Not a Number");``

## Scalar Types

A scalar type represents a single value. Rust has 4 scalar types:
1. Integers
2. Floating points
3. Numbers
4. Booleans
5. Characters

### Integer Types

An integer is a number without a fraction. 


| Length  | Signed | Unsigned |
|---------|--------|----------|
| 8-bit   | i8     | u8       |
| 16-bit  | i16    | u16      |
| 32-bit  | i32    | u32      |
| 64-bit  | i64    | u64      |
| 128-bit | i128   | u128     |
| arch    | isize  | usize    |


Each variant can be signed or unsigned and has an explicit size.

> Signed or unsigned refer to whether it's possible for the numbers to be
> negative, in other words, whether it needs a sign or whether it will only be
> positive. 

Each signed variant stores numbers from `(-2 power of n-1) to (2 power of n-1) -1` whereas unsigned numbers store `0 to (2 to the power of n) - 1`. So i8 stores -128 to 128 while U8 stores 0 - 255

`isize` and `usize` depend on computer architecture your program is running on,
if it's 32 or 64 bit architecture.

If a value exceeds its storage we get `integer overflow`.

#### How do you know which type of integer to use? 

If unsure, use default i32. The primary situation for isize or usize is when
indexing a collection. 

## Floats

There are 2 primitive types for floats; `f32` and `f64`. The default is `f64`
because of modern CPUs; roughly the same speed as f32 but more precise. All
floating point numbers are signed. 

## Numeric Operations

You can use numeric functions in a let statement. 

``
fn manin(){
    let sum = 5 +10; 
    let difference = 95.5 - 4.3; 
    let product  = 4 * 40 ;
    let quotient = 5/2;
    let truncated = -5/3; //Results in -1
  
    //Remainder
    let remainder = 43 % 5;
} 
``

## Boolean Type

As in most programming languages, a Boolean is `true` or `false`. Booleans are
`one byte in size`. 

``
fn main(){
    let t = true;
    let f = false;
``

The main way to use booleans is through conditionals, `if expressions`. 


## The Character Type

The `char` type is the most primitive alphabetic type. Note that char literals
have `single quotes` as opposed to string literals that use double quotes. This
is becasue Rust `char` type is 4 bytes and represents Unicode Scalar Value,
meaning it can represent more than ASCII. 

Chinese, Japanese, Korean; emoji zero width spaces are all valid with char. 

Here are a few examples: 

``
fn main() {
    let c = 'z';
    let z: char = 'ℤ'; // with explicit type annotation
    let heart_eyed_cat = '😻';
}

``
## Compound Types: tuples and arrays

Compound types can group multiple values into one type. These are `tuples` and
`arrays`. 

### Tuple

A tuple, `tup`, is a general way of grouping together a number of values with a variety
of types. Tuples have a fixed lenght  - they cannot grow or shrink.

Here's an example with optional type annotations:
``
fn main(){
    let tup: (i32, f64, u8) = (500, 6.4, 1);
};
``

There are different way to access elements in a tuple. We can `destructure` the
tuple by assigning x, y,z to the elements. 

``fn main() {
    let tup = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("The value of y is: {y}");
}``

Alternatively, we can access a  tuple element by using period (`.`) followed by
the index of the value. 


``
fn main() {
    let x: (i32, f64, u8) = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one = x.2;
}``


### The Array Type

Unlike a tuple, every element of an array must `be the same type` and unlike
arrays in some languages, in Rust,  an array has a `fixed length`. When you want
a flexible type similar to arrays, use vectors. 

We write arrays as comma separated lists. 

``
fn main(){
    let a  = [1,2,3,4,5]
}``

Arrays are useeful when you want to allocate your data on the stack rather than
the heap or when you want to ensure you have a fixed number of elements. This is
useful when you know the number of items and that they won't change. 

``
let months = ["January", "February", "March", "April", "May", "June", "July",
              "August", "September", "October", "November", "December"];
``

You specify type of an array by using brackets with the type of each element
followed by number of elements:
``
let a: [i32, 5] = [1,2,3,4,5]; 
``

You can also initaite an array that will have the same value.

`` let a = [3, 5]; Is the same as let a = [3,3,3,3,3];
``

You can access the array items by its elements ie `example_array[0]`.






























