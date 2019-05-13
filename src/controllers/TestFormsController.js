const dbInteract = require('./../middlewares/db-interact');
const miscs = require('./../middlewares/miscs');
const pool = require('./../config/database');

// Testing
async function insertData(req, res) {
	let body = req.body;
	// console.log(req.body)
	const operador = await dbInteract.isExists(`SELECT * FROM Operador WHERE id_operador=${body.operator}`);
	// console.log(operador.result)
	if(operador == false) {
		res.send({
			message: 'The operator doesn\'t exists'
		});
		return;
	}

	const prueba = await dbInteract.isExists(`SELECT * FROM Pruebas WHERE nombre='${body.test}'`);
	// console.log(prueba.result)
	if (prueba == false) {
		res.send({
			message: 'The test doesn\'t exists'
		});
		return;
	}
	
	if(body.attributes != undefined){
		for await (const atribute of body.attributes){
			const atributo = await dbInteract.isExists(`SELECT * FROM Atributos WHERE nombre='${atribute.name}'`);

			// console.log(atributo.result)
		}
	}

	for await (const sample of body.samples){
		const muestra = await dbInteract.isExists(`SELECT * FROM Muestras WHERE nombre='${sample}'`);
		// console.log(muestra.result)
		if (muestra == false && prueba.result.id_prueba > 1) {
			res.send({
				message: 'La muestra ' + sample + ' no existe'
			});
			return;
		} else {
			if (prueba.result.id_prueba > 1){
				// console.log('insert log')
				await require('./LogController').addLog(muestra.result.id_muestra, res);
			} else {
				console.log('insert sample')
				// await require('./SampleController').addSample(sample, res);
			}
		}
	}


	res.send({
		message: body
	})
}

module.exports = {
	insertData: insertData
};
