const fs = require('fs')

export def fileToLines path\string
	const file = fs.readFileSync(path, "utf8")
	return file.split("\n")
