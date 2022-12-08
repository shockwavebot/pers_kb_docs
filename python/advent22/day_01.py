def read_input(file_path):
    last = 0
    array = []
    with open(file_path) as f:
        for line in f:
            if line == "\n":
                array.append(last)
                last = 0
            else:
                last += int(line)
    return array

def get_max_calories(file_path):
    return max(read_input(file_path))

def get_top_three(file_path):
    a = read_input(file_path)
    a.sort()
    return sum(a[-3:])

if __name__ == "__main__":
    input_file_path = "input.data"
    maxc = get_max_calories(input_file_path)
    print(f"day1: max calories: {maxc}")
    top3 = get_top_three(input_file_path)
    print(f"day1: top 3: {top3}")