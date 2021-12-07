import { prepareWorksheet, fileToString,fileToLines} from "../helpers"
const log = prepareWorksheet()


def calculateFuelUsage positions\number[], destination\number
	let fuel = 0
	for pos in positions
		fuel += Math.abs(pos - destination)
	return fuel

def tryAllDestinations positions
	let min = null
	for crabPos in positions
		const fuel = calculateFuelUsage(positions, crabPos)
		if min == null or fuel < min
			min = fuel
	return min


# =============================================================================

import raw from './data.txt'
const positions = raw.split(",").map(do(n) parseInt(n))

log tryAllDestinations(positions)