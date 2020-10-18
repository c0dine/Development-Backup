const Command = require('../base/Command.js');

class Server extends Command {
  constructor (client) {
    super(client, {
      name: "server",
      description: "Add or delete channels",
      category:"Mod",
      usage: "server <add/del> <channel> || <kick/ban> <userNickname>",
      aliases: ['serv'],
      permLevel: "Moderator"
    });
  }

  async run (message, [option, value, ...reasoning], level) {
    //check for a mention
    const userMention = message.mentions.members.first()

    //check for a nickname
    const userNickName = await message.guild.members.fetch().then(members => {
      members.filter(m => message.guild.members.nickname == value);
    });

    //find a user id
    const userID = message.guild.members.fetch().then(members => {
      members.filter(m => m.member.id == value);
    });

    //they need to specify an option
    if (!option) return message.channel.send(`You need to provide an option`);

    //they need to specify a value for that option!
    if (!value) return message.channel.send(`You need to specify a value`)


    //start our options
    if (option == "add"){
      return message.channel.send(`This option is under development`)
    } else if (option == "del" || option == "delete") {
      return message.channel.send(`This option is under development`)
    } else if (option == "ban") {
        //there has to be a user mentioned
        if (!reason) return message.channel.send(`please provide a reason!`);
        if (userMention) {const user = userMention}
        if (userNickname) {const user = userNickname}
        if (userID) {const user = userID}
        if (!user) return message.channel.send(`I could not find a user please specify one`)
        const reason = reasoning.join(' ')
        try {
          user.ban({reason: reason});
          return message.channel.send(`${user} Has been banned because of: "${reason}"`)
        } catch (e) {
          message.channel.send(`I do not have the permissions to ban this user`)
          this.client.logger.log(`Error banning user\n${e}`, "error")
        }
    } else if (option == "kick") {
      //there has to be a user mentioned
        if (!reason) return message.channel.send(`please provide a reason!`);
        if (userMention) {const user = userMention}
        if (userNickname) {const user = userNickname}
        if (userID) {const user = userID}
        if (!user) return message.channel.send(`I could not find a user please specify one`)
        const reason = reasoning.join(' ')
        try {
          user.kick({reason: reason});
          return message.channel.send(`${user} Has been kicked because of: "${reason}"`)
        } catch (e) {
          message.channel.send(`I do not have the permissions to kick this user`)
          this.client.logger.log(`Error banning user\n${e}`, "error")
        }
    } else {
      return message.channel.send(`That is not a valid option! run <prefix>help server for all the options`)
    }

  }
}
module.exports = Server;