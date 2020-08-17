import http from "http";
import express from "express";
import socketIO from "socket.io";

const app = express();
const server = http.createServer(app);
var io = socketIO(server);

app.get("/", function(req, res) {
  res.send("Response from Katia backend");
});

const port = process.env.port || 3000;
server.listen(port);
console.log(`Server started at port ${port}`);

io.on("connection", socket => {
  console.log("new client", socket.id);
});
