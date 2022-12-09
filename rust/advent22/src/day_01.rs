use std::fs::File;
use std::io::{self, BufRead};

pub fn read_input(datafile: &str) -> Vec<i32> {
    let mut last = 0i32;
    let mut array: Vec<i32> = Vec::new();
    let file = File::open(datafile).unwrap();
    let reader = io::BufReader::new(file);
    for line in reader.lines() {
        let str_line = line.unwrap();
        if str_line.is_empty() {
            array.push(last);
            last = 0;
        } else {
            let value: i32 = str_line.parse::<i32>().unwrap();
            last += value;
        }
    }
    array
}

pub fn max_calories(input_data_file: &str) -> i32 {
    let input_array = read_input(input_data_file);
    *input_array.iter().max().unwrap()
}

pub fn sum_of_top_three_calories(datafile: &str) -> i32 {
    let mut input_array = read_input(datafile);
    let _ = input_array.sort();
    let _ = input_array.reverse();
    let mut sum = 0;
    for i in [0,1,2] {
        sum += input_array[i];
    };
    sum
}
 

#[cfg(test)]
mod tests {
    use super::*;
    const TEST_INPUT: &str = "src/data/unit_test_01";

    #[test]
    fn test_read_input() {
        let r: Vec<i32> = read_input(TEST_INPUT);
        // println!("{:#?}", &r);
        assert_eq!(r.len(), 7);
    }

    #[test]
    fn test_my_input() {
        let max = max_calories(TEST_INPUT);
        assert_eq!(max, 18);
    }

    #[test]
    fn test_get_sum_top_three() {
        let sum = sum_of_top_three_calories(TEST_INPUT);
        assert_eq!(sum, 37);
    }
}
