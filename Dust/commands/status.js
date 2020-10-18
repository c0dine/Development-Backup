const Command = require('../base/Command.js');

class Status extends Command {
	  constructor (client) {
		      super(client, {
			            name: "status",
			            description: "sets bot status",
			            category:"Backend",
			            usage: "status <status/default> <custom message>",
			            aliases: [],
			            permLevel: "Bot Owner"
			          });
		    }

	  async run (message, [status, ...messages], level) {
      if (!messages.length) { // if there is no custom message
		    if (status == "idle") {//set status to idle
			    this.client.user.setPresence({ activity: { name: `${this.client.settings.get("default").prefix}help | ${this.client.guilds.cache.size} Servers` }, status: 'idle' })
		    } else if (status == "online") { //set status to online
			    this.client.user.setPresence({ activity: { name: `${this.client.settings.get("default").prefix}help | ${this.client.guilds.cache.size} Servers` }, status: 'active' })
		    } else if (status == "dnd") { //set status to dnd
          this.client.user.setPresence({ activity: { name: `${this.client.settings.get("default").prefix}help | ${this.client.guilds.cache.size} Servers` }, status: 'dnd' })  
		    } else if (status == "offline" || status == "invisible") { // set status to invisible
			    this.client.user.setPresence({ activity: { name: `${this.client.settings.get("default").prefix}help | ${this.client.guilds.cache.size} Servers` }, status: 'invisible' })
		    }
      return message.channel.send(`Status successfully changed to ${status}`)
    } else {
      const statusMessage = messages.join(' ')
      if (status == "idle") {// set status to idle
			    this.client.user.setPresence({ activity: { name: statusMessage}, status: 'idle' })
		    } else if (status == "online") { // set status to online
			    this.client.user.setPresence({ activity: { name: statusMessage }, status: 'active' })
		    } else if (status == "dnd") { // set status to dnd
          this.client.user.setPresence({ activity: { name: statusMessage }, status: 'dnd' })  
		    } else if (status == "offline" || status == "invisible") {// set status to invisible
			    this.client.user.setPresence({ activity: { name: statusMessage }, status: 'invisible' })
		    }
      return message.channel.send(`Status successfully changed to ${status}\nCustom status set to "${statusMessage}"`)
    }
  }
}
module.exports = Status;
