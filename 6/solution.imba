import { fileToString,fileToLines} from "../helpers"
const {createCanvas} = require('canvas')
const log = console.log
console.clear()


def day data
	let newFishes = []
	for fish, i in data
		if fish > 0
			data[i] = fish - 1
		else
			data[i] = 6
			newFishes.push(8)
	return [...data, ...newFishes]



# =============================================================================

import raw from "./sample.txt"
const data = raw.split(",").map(do(n) parseInt(n))
def print v do log JSON.stringify(v)

let d = data

log "Initial:       ", d.join(", ")
for i in [0...256]
	d = day(d)
	# const space = i < 9 ? " " : ""
	# log "After {i + 1} days: {space}", d.join(", ")

log d.length