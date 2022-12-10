#[allow(dead_code)]
mod day_01;
mod day_02;
mod day_03;
mod day_04;

fn main() {
    // day 01
    let mc = day_01::max_calories("src/data/input");
    let top_3_sum = day_01::sum_of_top_three_calories("src/data/input");
    println!("day 01 part 1: max calories by elfs: {}", &mc);
    println!("day 01 part 2: top 3 sum: {:#?}", &top_3_sum);
    // day 02
    let (score, score_adjusted) = day_02::get_score("src/data/input_02_rps");
    println!("day 02 part 1: RPS score: {:#?}", &score);
    println!("day 02 part 2: RPS adjusted score: {:#?}", &score_adjusted);
    // day 03
    let prio_sum = day_03::get_item_prio("src/data/input_03_rucksacs");
    println!("day 03 part 1: prio sum: {:#?}", &prio_sum);
    let team_sum = day_03::get_group_badges_sum("src/data/input_03_rucksacs");
    println!("day 03 part 2: team sum: {:#?}", &team_sum);
    // day 04
    let count = day_04::count_fully_contained("src/data/input_04");
    println!("day 04 part 1: fully contained count: {:#?}", &count);
    let overlaps = day_04::count_overlaps("src/data/input_04");
    println!("day 04 part 1: overlaps count: {:#?}", &overlaps);
}
