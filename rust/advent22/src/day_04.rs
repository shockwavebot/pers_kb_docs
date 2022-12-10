use std::fs::File;
use std::io::{self, BufRead};

pub fn fully_contained(line: &str) -> bool {
    let split: Vec<i32> = line
                    .split(['-', ',', '-'])
                    .map(|s| s.parse::<i32>().unwrap())
                    .collect();
    let (rs1, re1, rs2, re2) = (split[0], split[1], split[2], split[3]);
    ( rs1 <= rs2 && re1 >= re2 ) || ( rs1 >= rs2 && re1 <= re2 )
}

pub fn no_overlap(line: &str) -> bool {
    let split: Vec<i32> = line
                    .split(['-', ',', '-'])
                    .map(|s| s.parse::<i32>().unwrap())
                    .collect();
    let (rs1, re1, rs2, re2) = (split[0], split[1], split[2], split[3]);
    ( rs1 < rs2 && re1 < rs2 ) || ( rs1 > re2 && re1 > re2 )
}

pub fn count_fully_contained(datafile: &str) -> i32 {
    let mut count: i32 = 0;
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        if let Ok(linestr) = line {
            if fully_contained(linestr.as_str()) {
                count += 1;
            }
        }
    }
    count
}

pub fn count_overlaps(datafile: &str) -> i32 {
    let mut count: i32 = 0;
    let mut total: i32 = 0;
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        if let Ok(linestr) = line {
            if no_overlap(linestr.as_str()) {
                count += 1;
            }
            total += 1;
        }
    }
    total - count
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_1() {
        assert!(fully_contained("1-2,1-5"));
        assert!(fully_contained("1-1,1-2"));
        assert!(fully_contained("2-2,1-2"));
    }
}