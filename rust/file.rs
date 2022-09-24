use std::{fs::OpenOptions, io::Write};

fn main() {
    let buf: String = "something".to_string();
    let mut f = OpenOptions::new()
                            .create(true)
                            .write(true)
                            .truncate(true)
                            .open(TapStorage::TAP_HISTORY_FILE_PATH).expect("err opening file");
    let _ = f.write(buf.as_bytes());
}
