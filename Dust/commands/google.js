const Command = require('../base/Command.js');
const cheerio = require('cheerio')
const got = require('got')
class Google extends Command {
  constructor (client) {
    super(client, {
      name: "google",
      description: "Google an Image",
      category:"fun",
      usage: "google fun",
      aliases: [],
      permLevel: "User"
    });
  }

  async run (message, args, level) {

    //make the bot startTyping typing 
    message.channel.startTyping()
    async function image(message, parts) {
 
    /* extract search query from message */
 
    var search = parts.join(" "); // Slices of the command part of the array ["!image", "cute", "dog"] ---> ["cute", "dog"] ---> "cute dog"
 
;
    try {
      
      const response = await got(`http://results.dogpile.com/serp?qc=images&q=${search}`);
      /* Extract image URLs from responseBody using cheerio */
 
        const $ = cheerio.load(response.body); // load response.body into cheerio (jQuery)
 
        // In this search engine they use ".image a.link" as their css selector for image links
        var links = $(".image a.link");
 
        // We want to fetch the URLs not the DOM nodes, we do this with jQuery's .attr() function
        // this line might be hard to understand but it goes thru all the links (DOM) and stores each url in an array called urls
        var urls = new Array(links.length).fill(0).map((v, i) => links.eq(i).attr("href"));
        if (!urls.length) {
            // Handle no results
            return message.channel.send(`There were no results`)
        }
 
        // Send result
        const send = await message.channel.send(`Here is the result`, {files: [urls[0]]});
        //make the bot stop typing 
        message.channel.stopTyping()
    } catch {

    }
   }
   if (!args.length) {
     return message.channel.send('Please give me something to search!')
   }

   image(message, args)
  }
}
module.exports = Google;