const fs = require('fs')

console.clear()

# read file in
def getFile
	const file = fs.readFileSync(__dirname + '/data.txt', "utf8")
	return file

# convert file to array of numbers
def parseFileString str\string
	const numbers = str.split("\n").map(do(l) parseInt(l))
	return numbers

def getNumbers do parseFileString(getFile())

def countIncreases numbers\number[]
	let count = 0
	for num, i in numbers
		count++ if numbers[i - 1] != null and numbers[i - 1] < num
	return count

def getSlidingWindowSums numbers\number[]
	const sums = []

	for num, i in numbers
		const a = numbers[i]
		const b = numbers[i - 1]
		const c = numbers[i - 2]
		if a != null and b != null and c != null
			sums.push(a + b + c)

	return sums


# const sampleInput = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
# console.log getSlidingWindowSums(sampleInput)
const numbers = getNumbers()
const sums = getSlidingWindowSums(numbers)

console.log countIncreases(sums)

