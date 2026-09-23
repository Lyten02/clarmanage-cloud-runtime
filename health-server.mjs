import { createServer } from 'node:http';

createServer((_request, response) => {
  response.writeHead(200, { 'content-type': 'text/plain; charset=utf-8' });
  response.end('ready\n');
}).listen(80, '0.0.0.0');
