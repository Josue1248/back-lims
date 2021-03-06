const pool = require('./../config/database');
const miscs = require('./../middlewares/miscs');
const dbInteract = require('./../middlewares/db-interact');
const moment = require('moment-timezone');

// Finish
async function addLog (req, res) {
	let body  = req.body;
	console.log(body)
	const operator = await dbInteract.isExists(`SELECT * FROM Operator WHERE id='${body.operator}'`);
	if(operator == false) {
		res.send({
			message: 'The operator doesn\'t exist'
		});
		return;
	}

	const sample = await dbInteract.isExists(`SELECT * FROM Sample WHERE name='${body.sample.toUpperCase()}'`);
	if (sample == false) {
		res.send({
			message: 'The sample doesn\'t exist'
		});
		return;
	}

	const test = await dbInteract.isExists(`SELECT * FROM Test WHERE name='${body.test.toUpperCase()}'`);
	if (test == false) {
		res.send({
			message: 'The test doesn\'t exists'
		});
		return;
	}
	
	const status = await dbInteract.isExists(`SELECT * FROM Status WHERE name='${body.status.toUpperCase()}'`);
	if (status == false) {
		res.send({
			message: 'The status doesn\'t exists'
		});
		return;
	}
	await pool.query(`INSERT INTO Log SET 
		operator_Id = ${operator.result.id}, sample_Id = ${sample.result.id},
		test_Id = ${test.result.id}, status_Id = ${status.result.id}, onCreated="${moment().tz("America/Los_Angeles").format().slice(0,19).replace('T', ' ')}"
	`);
	
};

// Unnecessary
async function deleteLog (req, res) {
	let params = req.params;
	await pool.query(`DELETE FROM Log WHERE id= ?`, [params.id]);
};

// Finish
async function getLogs (req, res) {
	res.send({
		Response: 'Hello'
	})
	// const value = await pool.query(`
	// 	SELECT Operator.id AS 'UserID', Sample.name AS 'Sample', Status.name AS 'State', Test.name AS 'Test', Log.onCreated AS 'On Created' FROM Log
	// 	JOIN Status ON Status.id = Log.status_Id 
	// 	JOIN Test ON Test.id = Log.test_Id
	// 	JOIN Operator ON Operator.id = Log.operator_Id
	// 	JOIN Sample ON Sample.id = Log.sample_Id
	// `);
	// if (value == undefined) {
	// 	res.send({
	// 		message: "No logs founds"
	// 	});
	// 	return;
	// }

	// for await (const result of value) {
	// 	result["On Created"] = result['On Created'].toISOString().slice(0, 19).replace('T', ' ');
	// }
	// res.send({
	// 	Logs : value
	// });
};

// Finish
async function getLogBySample (req, res) {
	let params = req.params;
	
	const sample = await dbInteract.isExists(`SELECT * FROM Muestras WHERE nombre='${params.name}'`);

	if (sample == false) {
		res.send({
			message: 'La muestra no existe'
		});
		return;
	}

	const value = await pool.query(`
		SELECT R.id_operador AS 'Operador', 
			M.nombre AS 'Muestra',
			E.nombre AS 'Estado',
			P.nombre AS 'Prueba',
			R.fecha AS 'Fecha'
		FROM Registros as R
		JOIN Estado as E ON E.id_estado = R.id_estado
		JOIN Pruebas as P ON P.id_prueba = R.id_prueba
		JOIN Operador as O ON O.id_operador = R.id_operador
		JOIN Muestras as M ON M.id_muestra = R.id_muestra
		WHERE R.id_muestra=${sample.result.id_muestra}
	`);

	const attributes = await pool.query(`
		SELECT M.nombre AS 'Muestra',
			A.nombre as'Atributo',
			VM.valor as 'Valor'
		FROM ValoresMuestras as VM
		JOIN Atributos as A ON VM.id_atributo = A.id_atributo
		JOIN Muestras as M ON VM.id_muestra = M.id_muestra
		WHERE VM.id_muestra=${sample.result.id_muestra}
	`);

	for await (const result of value) {
		result['Fecha'] = result['Fecha'].toString().slice(0,25);
	}
	
	if (value[0] == undefined) {
		res.send({
			message : "This sample doesn\'t have any log registry"
		});
		return;
	}

	res.send({
		Logs : value,
		Attributes: attributes
	});
};

// Unnecessary
async function updateLog (req, res) {
	let params = req.params;
	let body = req.body;
	const select = await pool.query('SELECT * FROM Log WHERE id = ?', [params.id]);
	const update = await pool.query(`UPDATE Log SET name='${body.name}' WHERE name='${select[0].name}'`);
}

module.exports = {
	addLog: addLog,
	deleteLog: deleteLog,
	getLogBySample: getLogBySample,
	getLogs: getLogs,
	updateLog: updateLog
};

