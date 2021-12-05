const fs = require('fs')

export def fileToString path\string
	return fs.readFileSync(path, "utf8")

export def fileToLines path\string
	const file = fs.readFileSync(path, "utf8")
	return file.split("\n")
