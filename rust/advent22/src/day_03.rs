use std::fs::File;
use std::io::{self, BufRead};

pub fn find_common_item(line: &str) -> Option<char> {
    let first_half = &line[..line.len()/2];
    let second_half = &line[line.len()/2..];
    for character in first_half.chars() {
        if second_half.contains(character) {
            return Some(character)
        }
    }
    None
}

pub fn calculate_prio(character: char) -> i32 {
    if character.is_lowercase() {
        character as i32 - 96
    } else if character.is_uppercase() {
        character as i32 - 38
    } else {
        0
    }
}

pub fn get_item_prio(datafile: &str) -> i32 {
    let mut prio_sum: i32 = 0;
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        if let Some(character) = find_common_item(line.unwrap().as_str()) {
            prio_sum += calculate_prio(character);
        }
    }
    prio_sum
}

pub fn get_group_badges_sum(datafile: &str) -> i32 {
    let mut badge_sum: i32 = 0;
    let mut first_rucksack: String = "".to_string();
    let mut common_chars: Vec<char> = Vec::new();
    let mut new_group = true;
    let mut second_gr = false;
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        let line_str = line.unwrap();
        // println!(">>>> line: {:#?}", &line_str);
        if new_group {
            first_rucksack = line_str;
            new_group = false;
            second_gr = true;
            // println!("first: {:#?}", &first_rucksack);
        } else if second_gr {
            for c in first_rucksack.as_str().chars() {
                if line_str.contains(c) && !common_chars.contains(&c) {
                    common_chars.push(c);
                }
            }
            // println!("common: {:#?}", &common_chars);
            second_gr = false;
        } else {
            for common_char in common_chars.iter() {
                if line_str.contains(common_char.to_owned()) {
                    badge_sum += calculate_prio(common_char.clone());
                }
            }
            // println!("third: {:#?}", &badge_sum);
            new_group = true;
            common_chars.clear();
        }
    }
    badge_sum
}


#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;

    fn write_test_file(path: &str, lines: &str) {
        fs::write(path, lines).expect("Unable to write file");
    }

    #[test]
    fn test_1() {
        let fpath = "/tmp/test1";
        write_test_file(fpath, "ab\nac\nda");
        let res = get_group_badges_sum(fpath);
        assert_eq!(res, 1);
    }
    
    #[test]
    fn test_2() {
        let fpath = "/tmp/test2";
        write_test_file(fpath, "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw");
        let res = get_group_badges_sum(fpath);
        assert_eq!(res, 52);
    }

    #[test]
    fn test_3() {
        let fpath = "/tmp/test3";
        write_test_file(fpath, "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg");
        let res = get_group_badges_sum(fpath);
        assert_eq!(res, 18);
    }
}