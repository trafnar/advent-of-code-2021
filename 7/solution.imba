import { prepareWorksheet, fileToString,fileToLines} from "../helpers"
const log = prepareWorksheet()


def calculateAllFuelUsages positions\number[], destination\number
	let fuel = 0
	for pos in positions
		fuel += calculateFuelUsage(pos, destination)
	
	return fuel

def tryAllDestinations positions
	let min = null
	let pos = null
	for crabPos in [0...(Math.max(...positions))]
		const fuel = calculateAllFuelUsages(positions, crabPos)
		if min == null or fuel < min
			min = fuel
			pos = crabPos
	return {min, pos}

def calculateFuelUsage from, to
	const distance = Math.abs(from - to) + 1
	const sum = (distance * (distance - 1)) / 2
	return sum


# =============================================================================

import raw from './data.txt'
const positions = raw.split(",").map(do(n) parseInt(n))

log tryAllDestinations(positions)