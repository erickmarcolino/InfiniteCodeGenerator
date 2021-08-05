async function incrementCode(NumCaracter, pos, lastCode){
	var availCharacters
	var currentChar
	var nextChar
	var posCurrentChar
	var newCode
	
	availCharacters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" // !@#$%&*
	
	if (pos < 0)
		return
	
	currentChar = lastCode.substring(pos, pos + 1)
	posCurrentChar = availCharacters.indexOf(currentChar)
	
	if (posCurrentChar < availCharacters.length - 1) {
		nextChar = availCharacters.substring(posCurrentChar + 1, posCurrentChar + 1 + 1)
		newCode = lastCode.substring(0, pos - 1 + 1) + '' + nextChar
		if (pos < lastCode.length - 1) {
			newCode = newCode + '' + lastCode.substring(pos + 1)
		}
	} else if (pos - 1 >= 0) {
		nextChar = availCharacters.substring(0, 1)
		newCode = lastCode.substring(0, pos - 1 + 1) + '' + nextChar
		if (pos < lastCode.length - 1) {
			newCode = newCode + '' + lastCode.substring(pos + 1)
		}
		newCode = await incrementCode(NumCaracter, pos - 1, newCode)
	} else {
		newCode = ""
		nextChar = availCharacters.substring(0, 1)
		for (i = 0; i < NumCaracter + 1; i++){
			newCode = newCode + '' + nextChar
		}
	}
	
	return newCode
}

async function nextCode(lastCode){
	var newCode
	
	newCode = await incrementCode(lastCode.length, lastCode.length - 1, lastCode)
	
	return newCode
}

nextCode('ABZ').then(result => console.log('ABZ >= ' + result))
nextCode('AAA').then(result => console.log('AAA >= ' + result))
nextCode('ZZZ').then(result => console.log('ZZZ >= ' + result))