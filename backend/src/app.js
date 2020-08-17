const http = require("http");
const express = require("express");

const app = express();
const server = http.createServer(app);

app.get("/", function(req, res) {
  res.send("Response from Katia backend");
});

const port = process.env.port || 3000;
server.listen(3000);
console.log(`Server started at port ${port}`);
