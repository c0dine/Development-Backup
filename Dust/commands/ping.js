const Command = require("../base/Command.js");

class Ping extends Command {
  constructor (client) {
    super(client, {
      name: "ping",
      description: "Latency and API response times.",
      usage: "ping",
      aliases: ["pong"]
    });
  }

  async run (message, args, level) { // eslint-disable-line no-unused-vars
    try {
      const ping = Date.now() - message.createdTimestamp
      message.embed.setDescription(`Pong! \`${ping}\``).setTitle('Ping');
      message.channel.send(message.embed)
    } catch (e) {
      console.log(e);
    }
  }
}

module.exports = Ping;
