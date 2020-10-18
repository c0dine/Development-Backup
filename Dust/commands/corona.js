const Command = require('../base/Command.js');
const fetch = require('node-fetch');
const Discord = require('discord.js');
const embed = new Discord.MessageEmbed()
class Corona extends Command {
  constructor (client) {
    super(client, {
      name: "corona",
      description: "Gives a health counter per city",
      category:"Beta",
      usage: "<prefix>corona <city>",
      aliases: ['c', 'cowona'],
      permLevel: "User"
    });
  }

  async run (message, args, level) {
    const ddate = new Date();
    let month = await ddate.getMonth() + 1;
    let day = await ddate.getDate();
    let year = await ddate.getFullYear();
    let timestamp = (year + "-" + month + "-" + day);
    if (!args.length) {
      fetch("https://pomber.github.io/covid19/timeseries.json")
      .then(response => response.json())
      .then(ddata => {
        const data = ddata["Canada"];
        for(var i = 0; i < data.length ; i++) {
        if (data.date == timestamp) {
          embed.setTitle(`Canada's cases today`)
          embed.addFields(
		        { name: 'Deaths Today', value: data.deaths, inline: true },
		        { name: 'Confirmed Cases (not active cases!)', value: data.confirmed, inline: true },
		        { name: 'Recoverys', value: data.recovered},
            { name: 'Active cases', value: data.confirmed - data.recovered - data.deaths}
        );
        embed.setColor('#48f7e6')
        return message.channel.send(embed)
        }
      }
      });
    } else if (args[0] == "timestamp") {
      console.log(timestamp)
      message.reply(timestamp)
    }
  }
}
module.exports = Corona;