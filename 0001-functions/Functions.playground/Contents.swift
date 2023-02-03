
import Foundation

// Notes: The purpose of the lecture is to understand how you are removing the Point ($0) object and you are composing code without it.

func incr(_ x: Int) -> Int {
  return x + 1
}

incr(2)

func square(_ x: Int) -> Int {
  return x * x
}

square(incr(2))

// writing an extension on the INT type allows you to create methods.  This is more swifty.  2.incr().Square().
// But you really want to take away the parenthesis
extension Int {
  func incr() -> Int {
    return self + 1
  }

  func square() -> Int {
    return self * self
  }
}

2.incr()
2.incr().square()

// this is where adding a "Pipe Forward" Operatior that allows this to basically act as an operator you can use . 2|> incr , etc etc.

// AFTER you make the infix Operator, assign the precedence
precedencegroup ForwardApplication {
  associativity: left
}

infix operator |>: ForwardApplication

func |> <A, B>(x: A, f: (A) -> B) -> B {
  return f(x)
}

2 |> incr |> square

// This once again is more Swifty again

extension Int {
  func incrAndSquare() -> Int {
    return self.incr().square()
  }
}

// looks like they make another operator ( >>> ) and then they added even more precedence to it.


precedencegroup ForwardComposition {
  higherThan: ForwardApplication
  associativity: left
}
infix operator >>>: ForwardComposition

func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> ((A) -> C) {
  return { a in g(f(a)) }
}

2 |> incr >>> square

// How we would write in is Swift Vanilla
[1, 2, 3]
  .map(square)
  .map(incr)

// How we would write in Composable Arch
[1, 2, 3]
  .map(square >>> incr)
