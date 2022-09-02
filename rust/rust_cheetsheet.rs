// cheats.rs 

// ### Formating/Printing ###
// macros defined in std::fmt
dbg!(some_var);                 // showing in stderr
println!("{:?}", some_var);     // showing debug in stdout 
format!(""); // write formatted text to String type 
// {:#?} pretty printing 
// {:b} binary 
// {:o} octal 
// {:x} hexadecimal 
// {:0>5} pad number with extra zeros (5 zeros in this example)

// Any Struct can derive Debug, but Display must be explicitly implemented 
#[derive(Debug)]

use std::fmt;
struct Structure(i32);
impl fmt::Display for Structure {
  fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
  write!(f, "{}", self.0)
  }
}


// ### End of Formating/Printing ###

// Casting - explicit type conversion with 'as'
let my_integer = 1.12_f32 as u8;

// byte size of variable 
std::mem::size_of_val(&x);

// ## Vectors = growable array ##
let mut vec: Vec<T> = Vec::new();   // vector of type T, you can't mix different types, and has to be defined, only sometimes infered 


// ### Converting between types ####
// std::convert 
// Traits: From/Into TryFrom/TryInto - when conversion can fail 

// ### End of Converting between types ####

vec.push(elem);     // to add element to the vector 

// ### Matching ###
// Matching on int range 
match some_u16_var {
  0..=21 => Some(1),
  22..=24 => Some(2),
  _ => None
}
// ### End Matching ###
