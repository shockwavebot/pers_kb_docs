mod day_01;

const INPUT_FILE: &str = "src/data/input";

fn main() {
    // day 01
    let mc = day_01::max_calories(INPUT_FILE);
    let top_3_sum = day_01::sum_of_top_three_calories(INPUT_FILE);
    println!("day 01: max calories by elfs: {}", &mc);
    println!("day 01: top 3 sum: {:#?}", &top_3_sum);
    // day 02
}
