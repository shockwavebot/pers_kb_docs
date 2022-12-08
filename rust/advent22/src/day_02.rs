use std::fs::File;
use std::io::{self, BufRead};

pub fn get_score(datafile: &str) -> (i32, i32) {
    let (mut score, mut score_ad) = (0, 0);
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        match line.unwrap().as_str() {
            "A X" => { score += 4; score_ad += 3},
            "A Y" => { score += 8; score_ad += 4},
            "A Z" => { score += 3; score_ad += 8},
            "B X" => { score += 1; score_ad += 1},
            "B Y" => { score += 5; score_ad += 5},
            "B Z" => { score += 9; score_ad += 9},
            "C X" => { score += 7; score_ad += 2},
            "C Y" => { score += 2; score_ad += 6},
            "C Z" => { score += 6; score_ad += 7},
            _ => (),
        }
    }
    (score, score_ad)
}
