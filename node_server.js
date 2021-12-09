/*
for the University of Illinois
2021
Michael Neill Hartman
*/

// install node.js
// install npm dependencies
// npm install express
// npm install body-parser

// what can be executed
const known_commands=["lastr"];
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(      
function (req, res, next){
res.setHeader('Access-Control-Allow-Origin', '*');
res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
res.setHeader('Access-Control-Allow-Credentials', true);
next();
},
express.json()
);
app.post('/', function(request, response){
const { spawn } = require("child_process");
// inits all processes when request is recv
// and not a known_command, triggers generate all
if(known_commands.includes(request.body.command)==false){
console.log("commands");
const bbh = spawn("bash", ["images_query","https://www.bitcoinblockhalf.com"]);
console.log("2");
const aq = spawn("bash", ["amazon_item_query_wrapper","amazon_items"]);
console.log("3");
const nq = spawn("bash", ["newegg_item_query_wrapper","newegg_items"]);
console.log("4");
const cmc = spawn("bash", ["coinmarketcap_crypto_price_parser"]);
console.log("5");
const ig = spawn("bash", ["images_query","https://news.google.com/topstories?hl=en-US&gl=US&ceid=US:en"]);
console.log("6");
const gnh = spawn("bash", ["google_news_headlines"]);
console.log("7");
const jr = spawn("bash", ["join_results"]);
response.send(request.body);
console.log("all init");
}
});
app.listen(9000);

// how to start server:
// node node_server.js