const whiteList = ['http://localhost:3000', 'http://10.2.1.70:3000/'];

const myIp = require('./ip');

module.exports = {
	database: {
		connectionLimit: 5,
		host: 'localhost',
		user: 'root',
		password: 'M3t@gr0ss',
		database: 'lims',
		timezone: 'utc'
	},
	Ip: myIp
};
