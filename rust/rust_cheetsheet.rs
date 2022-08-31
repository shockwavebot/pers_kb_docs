// cheats.rs 

dbg!(some_var);                 // showing in stderr
println!("{:?}", some_var);     // showing debug in stdout 

// Casting - explicit type conversion with 'as'
let my_integer = 1.12_f32 as u8;

// byte size of variable 
std::mem::size_of_val(&x);

// ## Vectors = growable array
let mut vec: Vec<T> = Vec::new();   # vector of type T, you can't mix different types, and has to be defined, only sometimes infered 
vec.push(elem);     # to add element to the vector 
