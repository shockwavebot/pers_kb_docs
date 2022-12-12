// get last char from string 
"mystring".chars().last().unwrap();

// get last n chars from string 
let s: String = "rema".chars().rev().take(3).collect();
let l: String = s.chars().rev().collect();
// or 
let s = "most";
let sl = s.get(s.len()-2..).unwrap();

// reverse a string
"mystring".chars().rev().collect();





// ============ sort me somewhere
// print type name 
#![feature(type_name_of_val)]
use std::any::type_name_of_val;

let x = 1;
println!("{}", type_name_of_val(&x));
let y = 1.0;
println!("{}", type_name_of_val(&y));