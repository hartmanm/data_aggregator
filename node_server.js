
// start server
// node node_server.js

// install node.js
// install npm dependencies
//npm install express
//npm install body-parser

// what can be executed
const known_commands=[
"ls -pla",
"ls",
"cat package.json",


"bash amazon_item_query_wrapper amazon_items",
"bash newegg_item_query_wrapper newegg_items",
"bash coinmarketcap_crypto_price_parser",
"bash images_query https://www.bitcoinblockhalf.com",




"bash images_query https://www.amazon.com/XFX-Speedster-SWFT210-Graphics-RX-66XT8DFDQ/dp/B09B17SQBS",


"bash images_query \"https://news.google.com/topstories?hl=en-US&gl=US&ceid=US:en\"",




"bash images_query https://www.coursera.org",

"lastr"
];

var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(express.json());
app.post('/', function(request, response){
//console.log(`request.body.command: ${request.body.command}`);
const { spawn } = require("child_process");
if(known_commands.includes(request.body.command)==false){response.send(request.body);}




if(request.body.command=="ls -pla"){
const ls = spawn("ls", ["-plah"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};

if(request.body.command=="ls"){
const ls = spawn("ls");
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};


if(request.body.command=="cat package.json"){
const ls = spawn("cat", ["package.json"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};


if(request.body.command=="bash amazon_item_query_wrapper amazon_items"){
const ls = spawn("bash", ["amazon_item_query_wrapper","amazon_items"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};
if(request.body.command=="bash newegg_item_query_wrapper newegg_items"){
const ls = spawn("bash", ["newegg_item_query_wrapper","newegg_items"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};
if(request.body.command=="bash coinmarketcap_crypto_price_parser"){
const ls = spawn("bash", ["coinmarketcap_crypto_price_parser"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};
if(request.body.command=="bash images_query https://www.bitcoinblockhalf.com"){
const ls = spawn("bash", ["images_query","https://www.bitcoinblockhalf.com"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};











// too big??

if(request.body.command=="bash images_query https://www.coursera.org"){
const ls = spawn("bash", ["images_query","https://www.coursera.org"]);
ls.stdout.on("data", data => {
console.log(`stdout: ${data}`);
response.send(`${data}`);
});
};




});
app.listen(8080);


// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"ls -pla"}'


// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"bash amazon_item_query_wrapper amazon_items"}'

// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"bash newegg_item_query_wrapper newegg_items"}'

// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"bash coinmarketcap_crypto_price_parser"}'

// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"bash images_query https://www.coursera.org"}'

// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"bash images_query https://www.bitcoinblockhalf.com"}'



