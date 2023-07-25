var http = require("http"),
    url = require("url"),
    path = require("path"),
    fs = require("fs"),
    port = process.env.SERVER_PORT || 3000;

http.createServer(function (request, response) {
  var uri = url.parse(request.url).pathname,
      filename = path.join(process.cwd(), 'web', uri);

  fs.exists(filename, function (exists) {
    if (!exists) {
      response.writeHead(404, { "Content-Type": "text/plain" });
      response.write("404 Not Found\n");
      response.end();
      return;
    }

    if (fs.statSync(filename).isDirectory()) filename += '/index.html';

    fs.readFile(filename, "utf8", function (err, file) { // Changed "binary" to "utf8"
      if (err) {
        response.writeHead(500, { "Content-Type": "text/plain" });
        response.write(err + "\n");
        response.end();
        return;
      }

      response.writeHead(200, { "Content-Type": "text/html" }); // Added "Content-Type" header
      response.write(file.toString().replace('Greeting', process.env.GREETING || 'ALOHA'));
      response.end();
    });
  });
}).listen(parseInt(port, 10));

console.log("Static file server running at\n  => http://localhost:" + port + "/\nCTRL + C to shutdown");
