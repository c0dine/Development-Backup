const Command = require('../base/Command.js');

class Say extends Command {
  constructor (client) {
    super(client, {
      name: "say",
      description: "echos stuff",
      category:"fun",
      usage: "say",
      permLevel: "Moderator"
    });
  }

  async run (message, [...args], level) {
    // allow there to be spaces 
    const joinedArgs = args.join(" ")
    if (!message.attachments){
      if (!joinedArgs.length){
        return message.reply("You did not provide any arguments!")
      }
      return message.channel.send(`${joinedArgs}`)
    } else {
      const attachment = message.attachments.url
      if (joinedArgs.length) {
        return message.channel.send(`${joinedArgs}`, attachment)
      }
    }
  }
}
module.exports = Say;