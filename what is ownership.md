---
title: What is ownership?
layout: default
---

'Ownership' is a set of rules that govern how Rust manages memory. 

## The Stack and the Heap

Both stack and heap are parts of memory available on runtime. 

- The `stack` stores values in th eorder it gets them and removes the values in
  the opposite order (`last in, first out`. Think of a stack of plates; when you
  add more plates you pile them, and when you remove a plate, you take it off
  the top. Adding data is called `pushing onto the stack` and removing data is
  called `popping off the stack`. All the data on the stack must have a known
  fixed size. Data with unknown size at compile time or a size that might change
  must be stored on the heap. 

- The heap is less organised. When you put data on heap, you request a certain
  amount of space. Memory allocator finds an empty spot in the heap that is big
  enough, marks it as in use and returns a pointer (an address of that
  location). This is called `allocating on the heap`. Think of being seated at a
  restaurant. When you enter, you state the number of people in your group. The
  host finds you a table. If someone is late, they can ask where you've been
  seated to find you. 
  
Pushing to the stack is fater than allocating on the heap because the allocator
never has to search for a place to store new data. Accessing data is also slower
on the heap because you have to follow a pointer. Processors are faster if they
jump around less in memory; ie taking an order from table A, then B, then A, and
then B again is slower than getting all the orders at one table. 

Ownership addreses which parts of the code uses what data on the heap or stack
by minimising duplicate data on the heap and cleaning up unused data. 

## Ownership Rules

- Each value in Rust has an owners
- There can only be one owner at a time
- When the owner goes out of scope the value is dropped

## Variable Scope

A scope is the range within a program for which an item is valid. 

`` let s = "Hello";`` The variable s is hardcoded and valid from point it's
declared until the end of current scope. 

``
// s is not valid here, not declared
{ let s = "Hello"  // s is valid from this point forward
//do stuff with s 
//scope is now over and s i no longer valid
}
``
When S comes into scope it's valid and it remains valid until it goes out of
scope. 

## The String Type

The Data Types covered earlier are of a known size and can be stored on the
stack and popped off when their scope is over. Let's look at data stored
on the heap, ie the `String type`. 

String literals are convenient but not always suitable since they're immutable.
Another reason is that not every string value can be known when we write our
code; ie if user gives input and we need to store it. 

For these reasons, Rust has a second string type, `String`. String manages data
allocated on the heap and lets us store an unknown amount of text at compile
time. 

You can create a String from a string literal using `from` function

`` let s = String::from("Hello")`` 


This kind of string can be mutated. 
``
let mut s = String::from("Hello")
s.push_str(", world"); //push str appends a literal to a string
println!("{}", s); this will prin hello world
``
So why can String be mutated but literals cannot. 

In the case of string literal, we know the contents at compile time so the text
is hardcoded into the final executable; this is why string literals are fast.
But this is only due to its immutability. 

With the String type, in order to support mutable growable piece of text, we
allocate some memory on the heap, unknown at compile time. This means the memory
must be requested at runtime and there needs to be a way of returning this
memory to the allocator when we're done with our string. 


In langauges with a `garbage collector` the GC tracks and cleans up memory
that's not being used. In languages without a GC, you have to keep track of
memory and what needs to be freed. Rust takes a different path; memory is
automatically returned once the variable goes out of scope. Rust calls `drop`
function at the closing of the curly bracket to drop the variable (see let S =
String code block above). 


## Variables and Data Interacting with Move

Multiple variables can interact with the same data. 

``
let x = 5;
let y = x;
``
Y is bound to x and both are equal to 5. This works becaue integers are known
simple values with fized sized so these two 5 values are pushed onto the stack.

Let's look at string

``
let s1 = String::from("hello");
let s2 = s1; 
``

The figure below shows what is happeninng to String under the covers. A string
is made up of 3parts; a pointer, a lenght, and capacity. This group of data is
stored on the stack and on the right is the memory on the heap that holds the
content. 

![Memory of S1](./assets/heap_memory.svg "Memory allocation")


The length is how much memory the contents of the String are using. Capacity is
the total amount of memory that String has recieved from the allocator. 

When assigning S1 o S2 the String data is copied, meaning we've copied the
pointer, the lenght, and capacity on the stack. However, we do not copy the heap
that the pointer refers to. So the data representation looks like this: 

[Copy pointer for S2](./assets/copy_pointer.svg)


We might assume the second line would make a copy of s1 and bind it to s2, but
this isn't what happens. Remember, what's stored on the stack is information about the data ie the pointer, not the actual data itself. So, <mark> what happens is we copy the pointer, the lenght, and the capacity that are on the stack. We do not copy the data on the heap that the pointer refers to.  </mark> 


If we copied both the pointer and the heap the representation would look like
this: 

[Copy both heap and stack]('./assets/copy_heap.svg)


f Rust copied the heap and stack of S2 = S1 it could get really expensive in
terms of runtime performance if the data on the heap were really large. That's
why we only copy the pointer on the scope. 

When a variable goes out of scope, Rust drops and cleans up the heam memory for
that variable. The figure shows both data pointers pointing to the same
location. 

This is a problem because when S2 and S1 go out of scope, they will
both try to free the same memory; this is known as a `double free error`.


Freeing memory twice can lead to corruption and security vulnerabilities. To
make sure memory is safe, after let s2 = s1, Rust considers s1 as no longer
valid, meaning we don't need to free anything when s1 goes out of scope. 

In other languages, we use `shallow copy` and `deep copy` to describe copying the
pointer, length, and capacity without copying the data. But as Rust also
invalidates the first variable, instead of being called a shallow copy, it's
known as a `move.` 

So what happens when s2 = s1 is that s1 was moved into s2. This is what actually
happens:

[Rust move, what actually happens](./assets/rust_move.svg "How move works")



This implies that Rust will never automatically create a deep copy of your data.
Thus, automatic copying can be a assumed to be inexpensive in terms of runtime
performance. 
























