#[allow(dead_code)]
mod day_01;
mod day_02;
mod day_03;
mod day_04;
mod day_05;
mod day_06;

fn main() {
    // day 01
    let mc = day_01::max_calories("src/data/in01");
    let top_3_sum = day_01::sum_of_top_three_calories("src/data/in01");
    println!("day 01 part 1: max calories by elfs: {}", &mc);
    println!("day 01 part 2: top 3 sum: {:#?}", &top_3_sum);
    // day 02
    let (score, score_adjusted) = day_02::get_score("src/data/in02");
    println!("day 02 part 1: RPS score: {:#?}", &score);
    println!("day 02 part 2: RPS adjusted score: {:#?}", &score_adjusted);
    // day 03
    let prio_sum = day_03::get_item_prio("src/data/in03");
    println!("day 03 part 1: prio sum: {:#?}", &prio_sum);
    let team_sum = day_03::get_group_badges_sum("src/data/in03");
    println!("day 03 part 2: team sum: {:#?}", &team_sum);
    // day 04
    let count = day_04::count_fully_contained("src/data/in04");
    println!("day 04 part 1: fully contained count: {:#?}", &count);
    let overlaps = day_04::count_overlaps("src/data/in04");
    println!("day 04 part 1: overlaps count: {:#?}", &overlaps);
    // day 05
    let top = day_05::rearrangement("src/data/in05");
    println!("day 04 part 1: top cargo after move: {:#?}", &top);
    let top9001 = day_05::rearrangement_9001("src/data/in05");
    println!("day 04 part 1: top cargo after move with 9001: {:#?}", &top9001);
    // day 06
    // let top = day_06::rearrangement("src/data/in06");
    // println!("day 04 part 1: top cargo after move: {:#?}", &top);
}
