const fs = require('fs')
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
		const amount = parseInt(e.replace(/[^\d]*/, ''))
		const direction = e.replace(/\s\d+/, '')
		return {amount, direction}

def calcNewPosition instructions
	let h = 0
	let d = 0
	for ins in instructions
		h += ins.amount if ins.direction === 'forward'
		d -= ins.amount if ins.direction === 'up'
		d += ins.amount if ins.direction === 'down'
	return {h, d}


def getFileLines path\string
	const file = fs.readFileSync(__dirname + "/" + path, "utf8")
	return file.split("\n")



# calculate result
const fileInput = getFileLines('data.txt')
const parsed = parseInstructionArray(fileInput)
const position = calcNewPosition(parsed)
console.log position.h * position.d

