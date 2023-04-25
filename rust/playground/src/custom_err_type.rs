// You could use derive attribute on custom error struct
// or you could use Debug trait to implement custom error message

// #[derive(Debug)]
pub enum MyCustomError {
    FirstCustomError(String),
}

impl std::fmt::Debug for MyCustomError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            MyCustomError::FirstCustomError(e) => {
                write!(f, "What's up is: MyCustomError::FirstCustomError({})", e)
            }
        }
    }
}

pub struct NumberWithComment {
    pub comment: String,
    pub number: i8,
}

impl NumberWithComment {
    pub fn add_to_me(&mut self, other: i8) -> Result<String, MyCustomError> {
        if other <= 0 {
            return Err(MyCustomError::FirstCustomError(format!(
                "Dude, you should only add numbers greather than 0, not: {}",
                other
            )));
        }
        self.number += other;
        Ok("All went well.".to_string())
    }
}
