import { fileToString,fileToLines} from "../helpers"
const {createCanvas} = require('canvas')
const log = console.log
console.clear()
console.log()
console.log("===== " + (new Date()).toLocaleString().split(", ")[1] + " ======")
console.log()
console.log()


def day data
	let newFishes = []
	for fish, i in data
		if fish > 0
			data[i] = fish - 1
		else
			data[i] = 6
			newFishes.push(8)
	return [...data, ...newFishes]

def hashDay hasData
	const nextDay = {}

	for own strAge, count of hasData
		const age = parseInt(strAge, 10)
		if age > 0
			const key = "{age - 1}"
			nextDay[key] = 0 if nextDay[key] == null
			nextDay[key] += count
		else
			# if the age is 0, then we need to add one to 6 and one to 8
			# but don't just assign to six, another eight could have just
			# reached 6
			nextDay['8'] = 0 if nextDay['8'] == null
			nextDay['6'] = 0 if nextDay['6'] == null
			nextDay['8'] += count
			nextDay['6'] += count

	return nextDay


def dataToHash data
	const result = {}
	for n in data
		if result[n] == null
			result[n] = 1
		else
			result[n]++
	return result

def runIterations initial, n
	let d = initial
	log "Ini:", d.join(", ")
	for i in [0...n]
		d = day(d)
		const space = i < 9 ? " " : ""
		log "{i + 1}: {space}", d.join(", ")

def runHashIterations initial, n, callback = (do)
	let d = initial
	for i in [0...n]
		d = hashDay(d)
		callback(d, i)
	return d

def hashString hash
	const max = Math.max(...Object.keys(hash).map(do(n) parseInt(n)))
	let result = ''
	for i in [0...(max + 1)]
		if hash[i] == null
			result += ' · '
		else
			result += " {hash[i]} "
	return result

def visualizeHashIterations data, n
	log '    0  1  2  3  4  5  6  7  8 '
	log()
	log "i  " + hashString(dataToHash(data))
	const final = runHashIterations dataToHash(data), n, do(d, i)
			let space = i > 9 ? "" : " "
			log ( i+1 ) + " {space}" + hashString(d)
	return final

# =============================================================================

import raw from "./data.txt"
const data = raw.split(",").map(do(n) parseInt(n))
def print v do log JSON.stringify(v)

const final = visualizeHashIterations(data, 256)
log Object.values(final).reduce(do(p,c) p + c)



# print d.length