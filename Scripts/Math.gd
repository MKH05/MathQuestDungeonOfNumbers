extends Node

var question_sets = {
	"easy": {
		"2 + 3": 5,
		"7 - 4": 3,
		"6 * 2": 12,
		"16 / 4": 4,
		"10 + 15": 25,
		"12 - 7": 5,
		"9 * 3": 27,
		"20 / 5": 4
	},
	"medium": {
		"12 / (4 + 2)": 2,
		"5 * (3 + 2)": 25,
		"(10 - 3) * 2": 14,
		"6^2": 36,
		"√49": 7,
		"25% of 80": 20,
		"15 + 3 * 2": 21,
		"(18 - 3) / 3": 5,
		"7 + (6 * 2)": 19
	},
	"hard": {
		"x in 2x + 3 = 11": 4,
		"Solve: 3^3": 27,
		"Simplify: (6 * 3) - (2^3)": 10,
		"Factorize: x^2 - 9": 3,
		"√(121)": 11,
		"Solve: 5x = 45": 9,
		"Solve: (3x + 6)/3 = 8": 6,
		"50% of 240": 120,
		"12 * (15 / 5)": 36,
		"(5^2) + (4^2)": 41
	}
}

var current_question = ""
var current_answer = 0

func _ready():
	var question = generate_question(str(G.Dif))
	print("Question: ", question)

func generate_question(difficulty: String) -> String:
	if difficulty in question_sets:
		var keys = question_sets[difficulty].keys()
		current_question = keys[randi() % keys.size()]
		current_answer = question_sets[difficulty][current_question]
		return current_question
	else:
		print("Invalid difficulty selected!")
		return ""

func check_answer(player_answer: String) -> bool:
	if str(player_answer) == str(current_answer):
		print("Correct!")
		return true
	else:
		print("Incorrect!")
		return false
