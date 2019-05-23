const pool = require('./../config/database');
const regex = require('./../middlewares/regex');
const dbInteract = require('./../middlewares/db-interact');

// Finish
async function addSample (req, res) {
	let muestra  = req.replace("MU","");
	let id_muestra = muestra.replace(/-/g,"")

	const nuevaMuestra = {
		id_muestra: id_muestra,
		nombre: req
	};
	console.log(nuevaMuestra)
	const exists = await dbInteract.isExists(`SELECT * FROM Muestras WHERE nombre='${req}'`);

	if(exists == false) {
		await pool.query('INSERT INTO Muestras SET ?', [nuevaMuestra]);
	} else {
		console.log(exists)
	}
	return({
		id_muestra: id_muestra
	})

};

// Finish
async function deleteSample (req, res) {
	let params = req.params;
	await pool.query('DELETE FROM Sample WHERE name= ?', [params.name]);
};

// Finis
async function getSamples (req, res) {
	const value = await pool.query('SELECT * FROM Sample ORDER BY name ASC');
	res.send({
		Samples : value
	});
};

// Finish
async function getSampleByName (req, res) {
	let params = req.params;
	
	const sample = await dbInteract.isExists(`SELECT id_muestra, nombre FROM Muestras WHERE nombre='${params.name}'`);

	if (sample.result != undefined){
		const states = await pool.query(`SELECT
				E.nombre AS 'estado'
			FROM Registros as R
			JOIN Estado as E ON R.id_estado = E.id_estado
			JOIN Pruebas as P ON R.id_prueba = P.id_prueba
			JOIN Operador as O ON R.id_operador = O.id_operador
			JOIN Muestras as M ON R.id_muestra = M.id_muestra
			WHERE R.id_muestra='${sample.result.id_muestra}' and E.nombre like 'Muestra%'`)

		res.send({
			estados: states
		});
	} else {
		res.send({
			estados: [{
				estado: 'Nueva muestra'
			}]
		});
	}

};

// Finish
async function updateSample (req, res) {
	let params = req.params;
	let body = req.body;
	if(!regex.validateSampleName(body.name.toUpperCase())) return;
	if(await getSampleByName(req, res)) {
		res.send({
			message: "The sample already exists"
		});
		return;
	}
	await pool.query(`UPDATE Sample SET name='${body.name.toUpperCase()}' WHERE name=${params.name}`);
}

module.exports = {
	addSample: addSample,
	deleteSample: deleteSample,
	getSampleByName: getSampleByName,
	getSamples: getSamples,
	updateSample: updateSample
};
