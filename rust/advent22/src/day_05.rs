use std::fs::File;
use std::io::{self, BufRead};

//                         [Z] [W] [Z]
//         [D] [M]         [L] [P] [G]
//     [S] [N] [R]         [S] [F] [N]
//     [N] [J] [W]     [J] [F] [D] [F]
// [N] [H] [G] [J]     [H] [Q] [H] [P]
// [V] [J] [T] [F] [H] [Z] [R] [L] [M]
// [C] [M] [C] [D] [F] [T] [P] [S] [S]
// [S] [Z] [M] [T] [P] [C] [D] [C] [D]
//  1   2   3   4   5   6   7   8   9 

pub fn move_crates_str(how_much: usize, from: String, to: String) -> (String, String) {
    let mut f = from;
    let mut t = to;
    for _ in 0..how_much {
        if let Some(moving_crate) = f.pop() {
            t.push(moving_crate);
        }
    }
    (f, t)
}

pub fn move_crates_9001(how_much: usize, from: String, to: String) -> (String, String) {
    let mut f = from.clone();
    let mut t = to;
    let new_len = f.len() - how_much;
    let the_move = from.get(new_len..).unwrap();
    f.truncate(new_len);
    t.push_str(the_move);
    (f, t)
}

pub fn rearrangement(datafile: &str) -> String {
    let s1: String = "SCVN".to_string();
    let s2: String = "ZMJHNS".to_string();
    let s3: String = "MCTGJND".to_string();
    let s4: String = "TDFJWRM".to_string();
    let s5: String = "PFH".to_string();
    let s6: String = "CTZHJ".to_string();
    let s7: String = "DPRQFSLZ".to_string();
    let s8: String = "CSLHDFPW".to_string();
    let s9: String = "DSMPFNGZ".to_string();
    let mut stack: Vec<String> = vec![s1,s2,s3,s4,s5,s6,s7,s8,s9];
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        if let Ok(linestr) = line {
            let move_it: Vec<usize> = linestr.split(' ').map(|s| s.parse::<usize>().unwrap()).collect();
            let from_index = move_it[1]-1;
            let to_index = move_it[2]-1;
            let from = &stack[from_index];
            let to = &stack[to_index];
            let (f,t) = move_crates_str(move_it[0], from.clone(), to.clone());
            stack[from_index] = f;
            stack[to_index] = t;
        }
    };
    let mut top_cargo = "".to_string();
    for i in 0..9 {
        let last = stack[i].chars().last().unwrap();
        top_cargo.push(last);
    }
    top_cargo
}

pub fn rearrangement_9001(datafile: &str) -> String {
    let s1: String = "SCVN".to_string();
    let s2: String = "ZMJHNS".to_string();
    let s3: String = "MCTGJND".to_string();
    let s4: String = "TDFJWRM".to_string();
    let s5: String = "PFH".to_string();
    let s6: String = "CTZHJ".to_string();
    let s7: String = "DPRQFSLZ".to_string();
    let s8: String = "CSLHDFPW".to_string();
    let s9: String = "DSMPFNGZ".to_string();
    let mut stack: Vec<String> = vec![s1,s2,s3,s4,s5,s6,s7,s8,s9];
    let file = File::open(datafile).unwrap();
    for line in io::BufReader::new(file).lines() {
        if let Ok(linestr) = line {
            let move_it: Vec<usize> = linestr.split(' ').map(|s| s.parse::<usize>().unwrap()).collect();
            let from_index = move_it[1]-1;
            let to_index = move_it[2]-1;
            let from = &stack[from_index];
            let to = &stack[to_index];
            let (f,t) = move_crates_9001(move_it[0], from.clone(), to.clone());
            stack[from_index] = f;
            stack[to_index] = t;
        }
    };
    let mut top_cargo = "".to_string();
    for i in 0..9 {
        let last = stack[i].chars().last().unwrap();
        top_cargo.push(last);
    }
    top_cargo
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_1() {
        // [A] [B]
        //  1   2 
        let from = "A".to_string();
        let to = "B".to_string();
        let (f,t) = move_crates_str(1, from, to);
        assert_eq!(f, "");
        assert_eq!(t, "BA");
    }

}