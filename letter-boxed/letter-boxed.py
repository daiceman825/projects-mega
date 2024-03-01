with open("./words_easy.txt") as f:
    words = f.read().splitlines()

# ==============================================================================================
def find_best(search_area, myDict, letters):
    search_area = search_area
    best_words = {}
    for wordlist in search_area :
        for word in myDict[wordlist] :
            score = sum(1 for criteria in letters if criteria in set(word))
            best_words[word] = score
    # return top 5 words
    return list(reversed(list({k: v for k, v in sorted(best_words.items(), key=lambda item: item[1])})))[0:5]


# ==============================================================================================
def word_list_gen(possible_letters, words):
    possible_words_list = []
    for word in words:
        for letter in word:
            if letter not in possible_letters:
                break
        else:
            possible_words_list.append(word)
    return possible_words_list

# ==============================================================================================
def matchup(letters, words):
    output = []
    for word in words:
        last = word[len(word)-1]
        matches = [w for w in words if w[0] == last and w!= word]
        for m in matches:
            pair = word + m
            if sorted(set(pair)) == sorted(letters):
                output.append([word,m])
    return output


# ==============================================================================================
def triage(words, puzzle_sides):
    box_top = list(puzzle_sides[0])
    box_bottom = list(puzzle_sides[1])
    box_left = list(puzzle_sides[2])
    box_right = list(puzzle_sides[3])
    ret_list = []
    for word in words:
        for i in range(0, len(word)-1):
            if(word[i] in  box_bottom and word[i + 1] in box_bottom):
                break
            elif(word[i] in  box_top and word[i + 1] in box_top):
                break
            elif(word[i] in  box_left and word[i + 1] in box_left):
                break
            elif(word[i] in  box_right and word[i + 1] in box_right):
                break
        else:
            ret_list.append(word)
    return ret_list

# ==============================================================================================
def menu(best_words):
    print("These are the best words to play. \n"\
        "Please choose one to continue... \n\n"\
        "1. " + best_words[0] +"\n"\
        "2. " + best_words[1] +"\n"\
        "3. " + best_words[2] +"\n"\
        "4. " + best_words[3] +"\n"\
        "5. " + best_words[4] +"\n"\
        "\n\n")
    choice = "not int"
    while not type(choice)==int:
        choice = input("Input a number, 1-5 : ")
        try: choice = int(choice)
        except:
            print("\nPlease enter a NUMBER.\n")
    return choice

# ==============================================================================================
def solve(puzzle_sides):
    solutions = []

    all_letters = list(puzzle_sides[0]) + list(puzzle_sides[1]) + list(puzzle_sides[2]) + list(puzzle_sides[3])
    remaining_letters = all_letters
    
    clean_words = triage(word_list_gen(all_letters, words), puzzle_sides)

    matches = matchup(all_letters,clean_words)

    final = []
    thresh = 13
    while thresh < 21:
        for pair in matches:
            fit = sum(map(len, pair))
            if fit == thresh : 
                final.append(pair)
        thresh += 1	 	


    return final[0:3]


# ==============================================================================================
def main():
    puzzle_sides = [input(f"Enter side {i+1}: ").strip().upper() for i in range(4)]
    #puzzle_sides = ['PWA','BUI','MER','VTO']
    
    solutions = solve(puzzle_sides)
    print(solutions)
   
'''   

find all words that match together based on the shared letter.

find a "perfect" two word solution that is exactly 13 letters (12 letters, plus 1 shared)
and contains all the letters from the puzzle. 

this will give a perfect pair that uses all letters without reusing any letters.

if this does not work, 
then go 13, 14, 15, etc. to find the best matches of words with the lowest amount of 
reused letters

'''

if __name__ == "__main__":
    main()

