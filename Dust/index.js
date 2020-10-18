const config = require('./config.js')
const { ShardingManager } = require('discord.js');
const manager = new ShardingManager('./bot.js', { token: config.token });

manager.spawn();
manager.on('shardCreate', shard => console.log(`Launched shard [${shard.id}]`));
manager.on('message', (shard, message) => {
	console.log(`Shard[${shard.id}] : ${message._eval} : ${message._result}`);
});