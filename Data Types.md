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



