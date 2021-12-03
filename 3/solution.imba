import {fileToLines} from "../helpers"
console.clear()

# get file as array with real numbers
const data = fileToLines(__dirname + '/data.txt').map do(row)
	row.split("").map(do(ch) parseInt(ch))

def counts data, which
	const initialCounts = Array(data[0].length).fill(0)
	data.reduce(&, initialCounts) do(counts\number[], row\number[])
		counts.map do(count, i)
			count += (row[i] === which ? 1 : 0)

def moreLess data
	const zeros = counts(data, 0)
	const ones = counts(data, 1)
	return zeros.map do(e,i)
		zeros[i] > ones[i] ? 0 : 1

def binArrToNum arr
	parseInt(arr.join(""),2)

def flip arr
	arr.map do(e) e === 0 ? 1 : 0

# calculate part one
const z = moreLess(data)
const o = flip(z)
console.log "part one answer: " + binArrToNum(z) * binArrToNum(o)


