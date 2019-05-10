const dbInteract = require('./../middlewares/db-interact');
const miscs = require('./../middlewares/miscs');
const pool = require('./../config/database');

// Testing
async function insertData(req, res) {
	let body = req.body;
	// console.log(req.body)
	const operador = await dbInteract.isExists(`SELECT * FROM Operador WHERE id_operador=${body.operator}`);

	if(operador == false) {
		res.send({
			message: 'The operator doesn\'t exists'
		});
		return;
	}

	const test = await dbInteract.isExists(`SELECT * FROM Pruebas WHERE nombre='${body.test}'`);
	console.log(test.result)
	if (test == false) {
		res.send({
			message: 'The test doesn\'t exists'
		});
		return;
	}
	
	// if(test.result.id_prueba > 0) {
	// 	let reqCopy = req;
	// 	for await (const sample of  body.samples) {
	// 		reqCopy.body = {
	// 			name: sample
	// 		};
	// 		if (await dbInteract.isExists(`SELECT * FROM Muestras WHERE nombre='${sample}'`) == true){
	// 			sampleErrorList.Exists.push(sample.toUpperCase());
	// 			continue;
	// 		} else await require('./SampleController').addSample(reqCopy, res);
	// 	}
	// }

	// for await (const element of body.samples) {
	// 	console.log(element)
	// 	let sample = await dbInteract.isExists(`SELECT * FROM Sample WHERE name='${element.toUpperCase()}'`);
	// 	if (sample == false) { 
	// 		sampleError = true;
	// 		sampleErrorList.NotExists.push(element.toUpperCase());
	// 		continue;
	// 	} 
	
	// let attributeError = false;
	// if (body.attributes) {
	// 	for await (const element of body.attributes) {
	// 		let attribute = await dbInteract.isExists(`SELECT * FROM Atributos WHERE nombre='${element.name}'`);
	// 		if (attribute == false) { 
	// 			attributeError = true;
	// 			break;
	// 		}
	// 	}
	// } 

	// for await (const reqSample of body.samples) {
	// 	let sample = await pool.query(`SELECT * FROM Muestras WHERE nombre='${reqSample}'`);
	// 	if (body.attributes) {
	// 		for await (const reqAttribute of body.attributes) {
	// 			let attribute = await pool.query(`SELECT * FROM Attribute WHERE name='${reqAttribute.name.toUpperCase()}'`);
	// 			// console.log({
	// 			// 	sample: sample[0].id,
	// 			// 	test: test.result.id,
	// 			// 	attribute: attribute[0].id,
	// 			// 	value: reqAttribute.value
	// 			// })
	// 			await pool.query(`INSERT INTO SampleValue SET sample_Id=${sample[0].id}, test_Id=${test.result.id}, attribute_Id=${attribute[0].id}, value='${reqAttribute.value}'`);
	// 		}
	// 	}
	// 	else break;
	// }

	// for await (const reqSample of body.samples) {
	// 	for await (const reqPost of postStatus) {
	// 		for await  (const reqPrev of prevStatus) {
	// 			let status = await dbInteract.isExists(`SELECT * FROM Status WHERE id=${reqPrev.prev_State}`);
	// 			req.body = {
	// 				operator: body.operator,
	// 				sample: reqSample,
	// 				test: body.test,
	// 				status: status.result.name
	// 			}
	// 			await require('./LogController').addLog(req, res);
	// 			status = await dbInteract.isExists(`SELECT * FROM Status WHERE id=${reqPost.post_State}`);
	// 			req.body = {
	// 				operator: body.operator,
	// 				sample: reqSample,
	// 				test: body.test,
	// 				status: status.result.name
	// 			}
	// 			await require('./LogController').addLog(req, res);
	// 		}
	// 	}
	// }
	res.send({
		message: body
	})
}

module.exports = {
	insertData: insertData
};
