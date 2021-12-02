import {fileToLines} from '../helpers'
console.clear()

const sampleInput = [
	"forward 5"
	"down 5"
	"forward 8"
	"up 3"
	"down 8"
	"forward 2"
]

def parseInstructionArray raw\string[]
	raw.map do(e)
		const direction = e.replace(/\s\d+/, '')
		const amount = parseInt(e.replace(/[^\d]*/, ''))
		return {amount, direction}

def calcNewPosition instructions
	let h = 0
	let d = 0
	let aim = 0

	for ins,i in instructions
		if ins.direction === 'forward'
			h += ins.amount 
			d += aim * ins.amount
		elif ins.direction === 'up'
			aim -= ins.amount 
		elif ins.direction === 'down'
			aim += ins.amount 
	
	return {h, d}


# calculate result
const input = fileToLines(__dirname + '/data.txt')
const parsed = parseInstructionArray(input)
const position = calcNewPosition(parsed)

console.log position.h * position.d

