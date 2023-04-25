mod custom_err_type;
use custom_err_type::{MyCustomError, NumberWithComment};

fn main() -> Result<(), MyCustomError> {
    println!("Hello, Mr. Dude!");
    let mut s: NumberWithComment = NumberWithComment {
        comment: "blah blah".to_string(),
        number: 2,
    };
    let res: Result<String, custom_err_type::MyCustomError> = s.add_to_me(1);
    println!("Now you have: {} for: {}", s.number, s.comment);
    res?;
    Ok(())
}
