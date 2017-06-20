//: Playground - noun: a place where people can play

import Foundation

// Some definition to start: What is subtyping?

// Subtyping is a form of type polymorphism in which a subtype is a
// datatype that is related to another datatype (the supertype) 
// by some notion of substitutability.

// Let's start by defining some types

class A { }

class B: A { }

// Inheritance is a way to implement subtyping (be careful, it's not the only one!)

let b = B()
let a: A = b

// As expected, an instance of type B can be substituted 
// where an instance of type A is expected

// What happens when the type is parameterized (i.e. when using generics)

let arrayB = Array<B>()
let arrayA: Array<A> = arrayB

// Array<B> is a subtype of Array<A>
// Be careful, subtyping != inheritance => remember that arrays are structs, and structs don't do inheritance
// We say that Array<T> is covariant with T

// Let's look at custom generic types

class Wrapper<T> { }

let wrapperB = Wrapper<B>()
//let wrapperA: Wrapper<A> = wrapperB

// We get a compile error, because Wrapper<B> is not a subtype of Wrapper<A>
// We say that Wrapper<T> is invariant with T

// Now let's look at function types

let returnsB: () -> B = { return B() }
let returnsA: () -> A = returnsB

// A swift function is covariant with its return type

var parameterB: (B) -> Void = { _ in }
//let parameterA: (A) -> Void = parameterB

// We get a compile error, becase swift functions are not covariant with the type of their arguments

let parameterA: (A) -> Void = { _ in }
parameterB = parameterA

// The other way arround it works, because swift function are contravariant with the type of their arguments

let parameterAreturnsB: (A) -> B = { _ in return B() }
let parameterBreturnsA: (B) -> A = parameterAreturnsB

// Of course, contravariant on the argument and covariance on the return type can be used together
