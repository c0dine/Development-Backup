const Command = require("../base/Command.js");
const { version } = require("discord.js");
const moment = require("moment");
const info = require('../package.json')
require("moment-duration-format");

class Stats extends Command {
  constructor (client) {
    super(client, {
      name: "stats",
      description: "Gives some useful bot statistics.",
      usage: "stats <option>",
    });
  }

  async run (message, args, level) { // eslint-disable-line no-unused-vars
if (args.length) {
    if (args[0].toLowercase === "guilds" || args[0].toLowercase === "servers") {
      
      const guildName = await this.client.shard.broadcastEval('this.guilds.cache.map(g => g.name)')
      const guildNames = guildName[0].join("\n• ")
       console.log(guildNames)
        return message.channel.send(`= GUILDS =\n• ${guildNames}`, {code: "asciidoc"});
    }
   } else {
     const promises = [
			this.client.shard.fetchClientValues('guilds.cache.size'),
			this.client.shard.broadcastEval('this.guilds.cache.reduce((prev, guild) => prev + guild.memberCount, 0)'),
      this.client.shard.broadcastEval('this.channels.cache.size.toLocaleString()')
		];
  return Promise.all(promises)
			.then(results => {
				const totalGuilds = results[0].reduce((prev, guildCount) => prev + guildCount, 0);
				const totalMembers = results[1].reduce((prev, memberCount) => prev + memberCount, 0);
        const totalChannels = results[2].reduce((prev, channelCount) => prev + channelCount, 0);
        const duration = moment.duration(this.client.uptime).format(" D [days], H [hrs], m [mins], s [secs]");
        message.channel.send(`= STATISTICS =
        • Mem Usage  :: ${(process.memoryUsage().heapUsed / 1024 / 1024).toFixed(2)} MB
        • Uptime     :: ${duration}
        • Users      :: ${totalMembers}
        • Servers    :: ${totalGuilds}
        • Channels   :: ${totalChannels}
        • Discord.js :: v${version}
        • Node       :: ${process.version}
        • BotVersion :: ${info.version}`
        ,{code: "asciidoc"});
			}).catch(err => {
        this.client.logger.log(`error while resolving Promise in stats`, "error");
    });
   }
  }
}

module.exports = Stats;
