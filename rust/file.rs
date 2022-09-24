use std::{fs::OpenOptions, io::Write};

fn main() {
    let buf: String = "something".to_string();
    let mut f = OpenOptions::new()
                            .create(true)
                            .write(true)
                            .truncate(true)
                            .open("/file/path").expect("err opening file");
    let _ = f.write(buf.as_bytes());
    // read from file 
    let read_from_storage: String = std::fs::read_to_string("/file/path").unwrap_or("{}".to_string());
}
