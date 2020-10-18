const Command = require('../base/Command.js');

class Send extends Command {
  constructor (client) {
    super(client, {
      name: "send",
      description: "Sends a message from server to server",
      category:"Backend",
      usage: "<guildID> <channel-name> <message>",
      aliases: [],
      permLevel: "Bot Owner"
    });
  }

  async run (message, [guildID, channelName, ...messages], level) {
    //First try to get a guild from guildID since it is priority
    const resolvedGuild = await this.client.guilds.cache.get(guildID);
    const poop = messages.join(" ")
    if (resolvedGuild) {//if it was able to get a guild from the id
    const resolvedChannel = await resolvedGuild.channels.cache.find(channels => channels.name === channelName);
      try {//try to complete the request
      message.channel.send(`message has been sent!`)
      resolvedChannel.send(`${poop}`)
      } catch (e) {//catch an error
        console.log(`internal error\n${e}`, "error")
      }
    } else { //if it couldn't then try dms
      const resolvedMember = this.client.users.cache.get(guildID);
      if (resolvedMember) {//if it was able to find a member
        const send = channelName + " " + poop
          try {//try to complete the request
            message.channel.send(`Message has been sent!`)
          return resolvedMember.send(send)
          } catch (e) {//catch an error
            console.log(`internal error\n${e}`, "error")
          }
        }
      return message.channel.send(`The coordinates do not exist (or I am not in the server)`)
      }
    } 
  }
module.exports = Send;