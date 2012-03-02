var util = require("util");
var importParser = require("./importParser.js").parser;
var _ = require("underscore");

var showErrors = true;

exports.start = function() {
	process.stdin.resume();
	process.stdin.setEncoding('utf8');

	var data = "";
	process.stdin.on('data', function(chunk) {
		data += chunk;
	});

	process.stdin.on('end', function() {
		try {
			importParser.parse(data);
		} catch (e) {
			if (showErrors)
				console.error(e);
		}
	});
}