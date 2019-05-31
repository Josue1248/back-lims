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
		await require('./OperatorController').addOperator(body.operator, res);
	}

	const prueba = await dbInteract.isExists(`SELECT * FROM Pruebas WHERE nombre='${body.test}'`);
	// console.log(prueba.result)
	if (prueba == false) {
		res.send({
			success: false,
			message: 'El test no existe'
		});
		return;
	}

	for await (const sample of body.samples){
		const muestra = await dbInteract.isExists(`SELECT * FROM Muestras WHERE nombre='${sample}'`);

		// console.log(muestra.result)
		if (muestra == false && prueba.result.id_prueba > 1) {
			res.send({
				success: false,
				message: 'La muestra' + sample + ' no existe'
			})
			return
		} else {
			if (prueba.result.id_prueba > 1) {
				if(body.attributes != undefined) {
					for await (const attribute of body.attributes){
						const atributo = await dbInteract.isExists(`SELECT * FROM Atributos WHERE nombre='${attribute.name}'`);
						
						if (atributo == false) {
							res.send({
								success: false,
								message: 'El atributo ' + attribute.name + ' no existe'
							});
							return;
						} else {
							const valorMuestra = {
								id_muestra: muestra.result.id_muestra,
								id_atributo: atributo.result.id_atributo,
								valor: attribute.value
							}

							await require('./SampleValueController').addSampleValue(valorMuestra, res);
						}
					}
				}

				for await (const state of body.states){
					const estado = await dbInteract.isExists(`SELECT * FROM Estado WHERE nombre='${state}'`);
					const newSample = (muestra == false) ? await require('./SampleController').addSample(sample, res) : muestra.result

					if (estado == false) {
						res.send({
							success: false,
							message: 'El estado ' + state.name + ' no existe'
						});
						return;
					} else {
						const log = {
							id_operador: parseInt(body.operator, 10),
							id_prueba: prueba.result.id_prueba,
							id_muestra: parseInt(newSample.id_muestra, 10),
							id_estado: estado.result.id_estado
						}
	
						await require('./LogController').addLog(log, res);
					}

				}
			} else {
				for await (const state of body.states){
					const estado = await dbInteract.isExists(`SELECT * FROM Estado WHERE nombre='${state}'`);
					const newSample = (muestra == false) ? await require('./SampleController').addSample(sample, res) : muestra.result

					if (estado == false) {
						res.send({
							success: false,
							message: 'El estado ' + state.name + ' no existe'
						});
						return;
					} else {
						const log = {
							id_operador: parseInt(body.operator, 10),
							id_prueba: prueba.result.id_prueba,
							id_muestra: parseInt(newSample.id_muestra, 10),
							id_estado: estado.result.id_estado
						}
	
						await require('./LogController').addLog(log, res);
					}
				}
			}
		}
	}
	
	res.send({
		success: true,
		message: (body.samples.length > 1) ? 'Las muestras han sido guardadas con exito' : 'La muestra ha sido guardada con exito'
	})
}

module.exports = {
	insertData: insertData
};
