import { fileToString } from '../helpers'
const log = console.log

console.clear()


def parseDataString string
	string.split("\n").map do(l)
		l.split(" -> ").map do(p)
			p.split(",").map do(n)
				parseInt(n)

def discardDiagonal lines
	lines.filter do(line)
		const [[x1, y1], [x2, y2]] = line
		return x1 === x2 or y1 === y2

def fillLine line
	const result = []
	const [[x1, y1], [x2, y2]] = line
	let start
	let end
	if y1 === y2
		[start, end] = [x1, x2]
		[end, start] = [start, end] if start > end
		result.push [i, y1]	for i in [start...( end + 1 )]
	elif x1 === x2
		[start, end] = [y1, y2]
		[end, start] = [start, end] if start > end
		result.push [x1, i]	for i in [start...( end + 1 )]
	else
		if x1 > x2
			let xsign = x2 < x1 ? 1 : -1
			let ysign = y2 < y1 ? 1 : -1
			for n, i in [x2...(x1 + 1)]
				result.push [ x2 + (i * xsign), y2 + ( i * ysign)]
		else
			let xsign = x1 < x2 ? 1 : -1
			let ysign = y1 < y2 ? 1 : -1
			for n, i in [x1...(x2 + 1)]
				result.push [ x1 + (i * xsign), y1 + ( i * ysign)]
	return result

log fillLine [[0,0], [3,3]]
log fillLine [[3,3], [0,0]]
log fillLine [[0,3], [3,0]]
log fillLine [[3,0], [0,3]]
log fillLine [[1,2], [3,4]]
log fillLine [[3,3], [0,0]]
log fillLine [[3,4], [1,2]]


def fillLines lines
	lines.map do(line) fillLine(line)

def linesToPoints lines
	const result = []
	for line in lines
		for point in line
			result.push(point)
	return result

def countOverlaps points
	const result = {}
	for point in points
		const key = point.join(",")
		if result[key] == null
			result[key] = 1
		else
			result[key] += 1
	return result

def getOverlapStats counts
	const result = {}
	for count in Object.values(counts)
		if result[count] == null
			result[count] = 1
		else
			result[count] += 1
	return result

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

export def printMap extremes, board
	const width = extremes.xmax
	const height = extremes.ymax
	log()
	for row in board
		log row.map(do(n) n === 0 ? '·' : n).join("")
	log()

import dataString from './data.txt'

# const lines = fillLines(discardDiagonal(parseDataString(dataString)))

# 0,9 -> 5,9
# 8,0 -> 0,8
# 9,4 -> 3,4
# 2,2 -> 2,1
# 7,0 -> 7,4
# 6,4 -> 2,0
# 0,9 -> 2,9
# 3,4 -> 1,4
# 0,0 -> 8,8
# 5,5 -> 8,2
# const lines = fillLines([
# 	[[0,9], [5,9]]
# 	[[8,0], [0,8]]
# 	[[9,4], [3,4]]
# 	[[2,2], [2,1]]
# 	[[7,0], [7,4]]
# 	[[6,4], [2,0]]
# ])


const lines = fillLines(parseDataString(dataString))
const points = linesToPoints(lines)
const counts = countOverlaps(points)
const stats = getOverlapStats(counts)
const numWithTwoOrMore = Object.values(stats).slice(1).reduce(do(p,c) p+c)
# log counts
log numWithTwoOrMore
log stats


# const x = extremeValues(lines)
# const x = {xmin:0, ymin:0, xmax:9, ymax:9}
# log x
# const map = getMap(x, lines)
# printMap(x, map)
