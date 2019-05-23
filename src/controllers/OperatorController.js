const miscs = require('./../middlewares/miscs');
const pool = require('./../config/database');
const regex = require('./../middlewares/regex');

// Finish
async function addOperator (req, res) {
	let operator  = {id_operador: req};

	if (operator > 99999) {
		console.log('The operator exeeds the limit')
		return;
	} else {
		console.log(operator)
		await pool.query('INSERT INTO Operador SET ?', [operator]);
		return;
	}
};

// Finish
async function deleteOperator (req, res) {
	let params = req.params;
	await pool.query('DELETE FROM Operator WHERE id= ?', [params.id]);
	res.send({
		message: 'Delete successful'
	});
};

// Finish
async function getOperators (req, res) {
	const value = await pool.query('SELECT * FROM Operator ORDER BY id_operador ASC');
	for await (const element of value) { 
		element.name = miscs.capitalizeWord(element.name);
	}
	res.send({
		Operators : value
	});
};

// Finish
async function getOperatorById (req, res) {
	let params = req.params;
	const value = await pool.query(`SELECT * FROM Operador WHERE id_operador = ${params.id}`);
	if (value.length == 0) { 
		res.send({ message: "The operator doesn't exist" }); 
		return;
	}

	res.send({
		Operator : value
	});
};

// Finish
async function updateOperator (req, res) {
	let params = req.params;
	let body = req.body;
	if (body.id > 99999) {
		res.send({
			message: 'The operator id exceeds the limit'
		})
		return;
	}
	const validateOperator = await pool.query(`SELECT * FROM Operator WHERE id='${body.id}'`);
	if (validateOperator.length == 1) {
		res.send({
			message: 'This operator already exists!'
		});
		return;
	}
	if (!regex.notNumber(body.name.toUpperCase())) {
		res.send({
			message: 'Cannot add operator with numbers'
		})
		return;
	}
	await pool.query(`UPDATE Operator SET id=${body.id}, name='${body.name.toUpperCase()}' WHERE id=${params.id}`);
	res.send({
		message: 'Update successful'
	})
}

module.exports = {
	addOperator: addOperator,
	deleteOperator: deleteOperator,
	getOperatorById: getOperatorById,
	getOperators: getOperators,
	updateOperator: updateOperator
};

