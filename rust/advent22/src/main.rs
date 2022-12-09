#[allow(dead_code)]
mod day_01;
mod day_02;
mod day_03;

const INPUT_FILE: &str = "src/data/input";
const INPUT_FILE_D2: &str = "src/data/input_02_rps";
const INPUT_FILE_D3: &str = "src/data/input_03_rucksacs";

fn main() {
    // day 01
    let mc = day_01::max_calories(INPUT_FILE);
    let top_3_sum = day_01::sum_of_top_three_calories(INPUT_FILE);
    println!("day 01: max calories by elfs: {}", &mc);
    println!("day 01: top 3 sum: {:#?}", &top_3_sum);
    // day 02
    let (score, score_adjusted) = day_02::get_score(INPUT_FILE_D2);
    println!("day 02: RPS score: {:#?}", &score);
    println!("day 02: RPS adjusted score: {:#?}", &score_adjusted);
    // day 03
    let prio_sum = day_03::get_item_prio(INPUT_FILE_D3);
    println!("day 03: prio sum: {:#?}", &prio_sum);
    let team_sum = day_03::get_group_badges_sum(INPUT_FILE_D3);
    println!("day 03: team sum: {:#?}", &team_sum);
}
