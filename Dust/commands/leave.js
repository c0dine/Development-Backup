const Command = require('../base/Command.js');

class Leave extends Command {
  constructor (client) {
    super(client, {
      name: "leave",
      description: "Makes bot leave a given server",
      category:"Backend",
      usage: "<prefix>leave",
      aliases: ["L"],
      permLevel: "Bot Owner"
    });
  }

  async run (message, args, level) {
    if (!args.length) {
      const response = await this.client.awaitReply(message, `Are you sure you want to leave \`${message.guild.name}\`?`);
      if (["y", "yes"].includes(response)) {
        const goodbyeMessage = await message.channel.send(`Ok Goodbye Fam! :v:`)
        return message.guild.leave()
      } else
      if (["n","no","cancel"].includes(response)) {
        response.delete()
        this.logger.log(`${message.author.name} attempted to leave the ${message.guild.name} server`)
      }
    } else {
      return 
    }
  }
}
module.exports = Leave;