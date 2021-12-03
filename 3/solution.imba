import {fileToLines} from "../helpers"
console.clear()

# get file as array with real numbers
const data = fileToLines(__dirname + '/data.txt').map do(row)
	row.split("").map(do(ch) parseInt(ch))

def getCounts data, which
	const initialCounts = Array(data[0].length).fill(0)
	data.reduce(&, initialCounts) do(counts\number[], row\number[])
		counts.map do(count, i)
			count += (row[i] === which ? 1 : 0)

def moreLess data
	const zeros = getCounts(data, 0)
	const ones = getCounts(data, 1)
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

let d = [...data]

def oxygenCriteria numOnes, numZeros, d, bitIndex
	# are there more ones?
	if numOnes >= numZeros
		# yes? keep only numbers starting with 1
		d = d.filter do(row)
			row[bitIndex] === 1
	else
		# no? keep only numbers starting with 0
		d = d.filter do(row)
			row[bitIndex] === 0
	return d

def co2Criteria numOnes, numZeros, d, bitIndex
	# are there less zeros?
	if numZeros <= numOnes
		# yes? keep only numbers starting with 0
		d = d.filter do(row)
			row[bitIndex] === 0
	else
		# no? keep only numbers starting with 1
		d = d.filter do(row)
			row[bitIndex] === 1
	return d
	
def applyCriteria d, criteria
	let data = [...d]
	for bi in [0...data[0].length]
		const zeros = getCounts(d, 0)[bi]
		const ones = getCounts(d, 1)[bi]
		if d.length > 1
			d = criteria(ones, zeros, d, bi)

	if d.length > 1
		console.log "ended up with too many results in apply criteria!!" 

	return d[0]

const ox = applyCriteria(data, oxygenCriteria)
const co = applyCriteria(data, co2Criteria)

console.log "part two answer: " + binArrToNum(ox) * binArrToNum(co)

	


# consider nth bit
# keep only numbers satisfying bit criteria
# if only one number left, that is the result

# oxygen generator rating:
# find most common bit in column (1 if equal)
# keep numbers starting with that bit

# co2 scrubber rating
# find least common bit (0 if equal)
# keep numbers starting with that bit