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

// get 4 chars from pointer 
let pointer = 4;
"12345678".get(pointer..pointer+4).unwrap(); // 5678

// iterate over str
for (n,i) in s.chars().enumerate() {
    println!("{} {}", &n, &i);
}



// ============ sort me somewhere
// print type name 
#![feature(type_name_of_val)]
use std::any::type_name_of_val;

let x = 1;
println!("{}", type_name_of_val(&x));
let y = 1.0;
println!("{}", type_name_of_val(&y));

fn inter_uni(first: &Vec<Vec<i8>>, second: &Vec<Vec<i8>>) -> Vec<i8> {
    let mut res_union: Vec<i8> = Vec::new();
    for f in first.iter(){
        
    }
}