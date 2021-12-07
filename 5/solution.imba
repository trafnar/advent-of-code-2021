import { fileToString,fileToLines} from "../helpers"
const {createCanvas} = require('canvas')
const log = console.log
console.clear()

export def parseString string
	const result = {}
	const arr = string.split("\n").map do(line)
		line.split(" -> ").map do(point, i)
			point.split(",").map do(n, j)
				parseInt(n)

export def parseInput filename
	const raw = fileToString(__dirname + "/{filename}")
	return parseString(raw)

export def lineToObj line
	{
		x1: line[0][0]
		y1: line[0][1]
		x2: line[1][0]
		y2: line[1][1]
	}

export def discardDiagonal lines
	lines.filter do(line)
		return isHorizontal(line) or isVertical(line)

export def isHorizontal line
	const {y1, y2} = lineToObj(line)
	y1 === y2

export def isVertical line
	const {x1, x2} = lineToObj(line)
	x1 === x2

export def fillLine line
	const {x1, y1, x2, y2} = lineToObj(line)

	# loop through the direction
	let start
	let end
	const result = []
	if isHorizontal(line)
		[start, end] = isHorizontal(line) ? [x1, x2] : [y1, y2]
		[end, start] = [start, end] if start > end
		result.push [i, y1]	for i in [start...( end + 1 )]
	elif isVertical(line)
		[start, end] = [y1, y2]
		[end, start] = [start, end] if start > end
		result.push [x1, i]	for i in [start...( end + 1 )]
	return result	

log fillLine [[0,0], [0,5]]
log fillLine [[0,5], [0,0]]
log fillLine [[0,0], [5,0]]
log fillLine [[5,0], [0,0]]

export def fillLines straightLines
	return straightLines.map do(line) fillLine(line)

export def extremeValues lines
	let xmin = null
	let ymin = null
	let xmax = null
	let ymax = null
	for line in lines
		for point in line
			const [x, y] = point
			xmin = x if xmin == null or x < xmin
			xmax = x if xmax == null or x > xmax
			ymin = y if ymin == null or y < ymin
			ymax = y if ymax == null or y > ymax
	const result = {xmin, ymin, xmax, ymax}
	return result

export def getMap extremes, lines
	const {xmin, ymin, xmax, ymax} = extremes

	const xDist = xmax + 1
	const yDist = ymax + 1

	const board = Array(yDist).fill(null).map do(r)
		Array(xDist).fill(0)

	for line in lines
		for point in line
			let [x,y] = point
			board[y][x] += 1
	return board

def getNumEach board
	const numEach = {}
	for row in board
		for n in row
			const thisValue = numEach["{n}"]
			if thisValue == null
				numEach["{n}"] = 1
			else
				numEach["{n}"] = thisValue + 1

			numEach["{n}"] = numEach["{n}"] == null ? 0 : numEach["{n}"]++
	return numEach

export def printMap extremes, board
	const width = extremes.xmax
	const height = extremes.ymax
	const canvas = createCanvas(width, height)
	const context = canvas.getContext("2d")
	context.fillStyle = "#fff"
	context.fillRect(0,0,width,height)

	log()
	for row in board
		log row.map(do(n) n === 0 ? '·' : n).join("")
	log()

export def calculateResult lines
	const straightLines = discardDiagonal(lines)
	const filled = fillLines(straightLines)
	const extremes = extremeValues(straightLines)
	const map = getMap(extremes, filled)
	return getNumEach(map)

const testBoard = parseInput("data.txt").slice(0,1)
# log testBoard
const straightLines = discardDiagonal(testBoard)
const filled = fillLines(straightLines)
const extremes = extremeValues(straightLines)
const map = getMap(extremes, filled)

# printMap(extremes, map)

# log getNumEach(map)


# log hlines