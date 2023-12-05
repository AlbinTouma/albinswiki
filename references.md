---
title: references
layout: default
---

## Summary of rules of references

- At any given time, you can have **either** one mutable reference or any number
  of immutable references.
- References must always be valid. 


## References and Borrowing

A `reference` is like a pointer in that it's an address we can follow to access
the data stored at the address; that data is owned by some other variable. 

Unlike pointser, references point to a valid value of a particular type for the
life of that reference. 

``
fn main(){
    let s1 = String::from("Hello");
    let s2  = calculate_length(&s1);
}

fn calculate_lenghth(s: &String) -> usize{
    s.len()
}
``
The tuple code in the variable declaration and the function return value is
gone. Instead we pass s1 into calculate_lenght and in its definition we take a
refernce of the String. 

The `&` lets us represent references and refer to some value without taking
ownesrhip of it. 

The &s1 syntax lets us create a reference that refers to the value of s1 but
does not own it, meaning the value it points to will not be dropped when the
reference stops being used.

``
fn caluclate_length(s: &String) -> usize{// s is a reference to a String
    s.len()
} //Here so goes out of scope but becasue it does not have ownership of what it
//refers to, it is not dropped. 
``

As a reference doesn't own what it borrows, we cannot modify it. The code below
would fail: 

`` 
fn main(){
    let s = String::from("Hello")
    change(&s); 
}

fn change(some_string: &String ){
    some_string.push_str(",world");
}
``

> Just as variables are immutable by default, so are references. We can't modify
> something we have a reference to. 

## Mutable references

We can use `&mut` to make a reference mutable. 

``
fn main() {
    let mut s = String::from("hello");

    change(&mut s);
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}``

We change variable s to be mut. Then we create a mutable reference with &mut s
and update the function signature to accept a mutuable reference. 

! Mutable references have a big restriction; if you have a mutable reference to
a value, you can have no other references to that value. Ie you can't have let
r1 = &mut s; and r2 = &mut s; 

``
    let mut s = String::from("hello");

    let r1 = &mut s;
    let r2 = &mut s;

    println!("{}, {}", r1, r2);
``

The benefit of having this restriction is that Rust prevents data races which
are when 
 
- Two or more pointers access the same data at the same time
- At least one of the pointers is being used to write to the data
- There's no mechanism being used to synchronize access to the data

Data races cause undefined behaviour. As always, we can use curly brackets to
create a new scope, allowing for multiple mutuable references, just not
simultaneous ones.

``

    let mut s = String::from("hello");

    {
        let r1 = &mut s;
    } // r1 goes out of scope here, so we can make a new reference with no problems.

    let r2 = &mut s;

``
##Dangling references

Dangling pointesr are when references point to a location in memeory that has
been given to someone else - by freeing memeory while preserving the pointer to
that memory. Rust guarantees there will be no dangling references. 


