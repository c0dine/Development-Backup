const Command = require('../base/Command.js');

class Emoji extends Command {
  constructor (client) {
    super(client, {
      name: "emoji",
      description: "Find an emoji",
      category:"Beta",
      usage: "emoji :emoji:",
      aliases: [],
      permLevel: "User"
    });
  }

  async run (message, args, level) {
    
    return this.client.findEmoji(args[0])
		.then(emojiArray => {
      
		// Locate a non falsy result, which will be the emoji in question
		const foundEmoji = emojiArray.find(emoji => emoji);
			if (!foundEmoji) return message.reply('I could not find such an emoji.');

		// Acquire a guild that can be reconstructed with discord.js
			return client.api.guilds(foundEmoji.guild).get()
					.then(raw => {
						// Reconstruct a guild
						const guild = new Discord.Guild(client, raw);
						// Reconstruct an emoji object as required by discord.js
						const emoji = new Discord.GuildEmoji(client, guild, foundEmoji);
						return message.reply(`I have found an emoji ${emoji.toString()}!`);
					});
		});
  }
}
module.exports = Emoji;