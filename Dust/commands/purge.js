const Command = require('../base/Command.js');

class Purge extends Command {
  constructor (client) {
    super(client, {
      name: "purge",
      description: "Bulk deletes messages",
      category:"Mod",
      usage: "<prefix>purge <amount>",
      aliases: ['p', 'prune'],
      permLevel: "Moderator"
    });
  }

  async run (message, args, level) {
  if (!args.length) {// if there was no nickname tagged
  //fetch all messages 
   const messages = await message.channel.messages.fetch()
   // filter it based on wether the bot is the author
   const filtered = messages.filter(m => m.author.id === '694974674395988030');
   try {//try to delete the filtered messages
      message.channel.bulkDelete(filtered)
   } catch (e) {//catch an error
     this.logger.log(`Error deleting messages\n${e}`, "error")
   }
    
      } else {//if there was a nickname named in args
      // fetch all messages
        const messages = await message.channel.messages.fetch()
        // Filter the messages based on the authors nickname
        const filtered = messages.filter(m => m.member.nickname == args.join(" "));
          try {// delete the filtered messages
          message.channel.bulkDelete(filtered);
          } catch (e) {//catch an error
            this.logger.log(`Error deleting messages\n${e}`, "error")
          }
      } 
  }
}
module.exports = Purge;