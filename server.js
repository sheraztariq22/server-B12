const fs = require("fs");
const crypto = require("crypto");
const net = require("net");

function createRandomFile(filePath, sizeKB) {
  const data = crypto.randomBytes(sizeKB * 1024).toString("hex");
  fs.writeFileSync(filePath, data);
}

function calculateChecksum(filePath) {
  const data = fs.readFileSync(filePath);
  return crypto.createHash("md5").update(data).digest("hex");
}

const server = net.createServer((socket) => {
  const filePath = "/serverdata/random_file.txt";
  createRandomFile(filePath, 1);
  const checksum = calculateChecksum(filePath);

  const fileData = fs.readFileSync(filePath);
  socket.write(fileData);
  socket.write(checksum);
  socket.end();
});

server.listen(5000, () => {
  console.log("Server listening on port 5000");
});
