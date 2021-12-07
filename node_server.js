
// start server
// node node_server.js

// install node.js
// install npm dependencies
//npm install express
//npm install body-parser

// what can be executed
const known_commands=["ls -pla","ls","cat package.json"];

var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(express.json());
app.post('/', function(request, response){
console.log(`request.body.command: ${request.body.command}`);
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


});
app.listen(8080);


// curl -X POST http://localhost:8080  -H 'Content-Type: application/json'  -d '{"command":"ls -pla"}'