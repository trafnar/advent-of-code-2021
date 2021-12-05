import { fileToString,fileToLines} from "../helpers"
const log = console.log
console.clear()

# helper functions

def iterateRows board, callback
	for row in board
		callback(row)

def iterateCols board, callback
	for i in [0...(board[0].length)]
		let arr = []
		for row in board
			arr.push(row[i])
		callback(arr)

def lineHasWinner? line, draws
	const result = line.filter do(n)
		!draws.includes(n)
	return result.length === 0

def boardHasWinner? board, draws
	let result = false
	iterateRows(board) do(line) result = true if lineHasWinner? line, draws
	iterateCols(board) do(line) result = true if lineHasWinner? line, draws
	return result

def getUnmarkedNumbers board, draws
	let result = []
	let final = getWinningNumberIndex(board, draws)
	let winner = getWinningNumber(board, draws)
	let necessaryDraws = draws.slice(0,final + 1)
	for row, i in board
		for n in row
			if !necessaryDraws.includes(n)
				result.push(n) 
	return result

def getSumOfUnmarkedNumbers board, draws
	const unmarked = getUnmarkedNumbers(board, draws)
	if unmarked.length == 0
		return 0
	else
		unmarked.reduce(do(p,c) p + c)

def getWinningNumberIndex board, draws
	for draw, i in draws
		if boardHasWinner? board, draws.slice(0,i + 1)
			return i
	return null

def getWinningNumber board, draws
	for draw, i in draws
		if boardHasWinner? board, draws.slice(0,i + 1)
			return draw
	return null

def getFirstWinner boards, draws
	let min = null
	let firstBoard = null
	for board in boards
		const index = getWinningNumberIndex(board, draws)
		if min == null or index < min
			min = index
			firstBoard = board
	return firstBoard

def getLastWinner boards, draws
	let max = null
	let lastBoard = null
	for board in boards
		const index = getWinningNumberIndex(board, draws)
		if max == null or index > max
			max = index
			lastBoard = board
	return lastBoard

def parseInput filename
	const input = fileToLines(__dirname + "/{filename}.txt")
	const draws = input[0].split(",").map(do(e) parseInt(e))
	const boards = input.slice(2).join("\n").split("\n\n").map do(board)
		board.split("\n").map do(row)
			row.trim().split(/\s+/).map(do(d) parseInt(d))
	return {draws, boards}

def getScore board, draws
	const sum = getSumOfUnmarkedNumbers(board, draws)
	const winningNumber = getWinningNumber(board, draws)
	return sum * winningNumber

# calculate the answers
const {draws, boards} = parseInput("data")
const firstWinner = getFirstWinner(boards, draws)
const lastWinner = getLastWinner(boards, draws)
log "First winner score: " + getScore(firstWinner, draws)
log "Last winner score: " + getScore(lastWinner, draws)

