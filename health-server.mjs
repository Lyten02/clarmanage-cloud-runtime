import { spawnSync } from 'node:child_process';
import { existsSync, mkdirSync } from 'node:fs';
import { createServer } from 'node:http';

mkdirSync('/home/workspace/.codex', { recursive: true });
mkdirSync('/home/workspace/.config/gh', { recursive: true });
if (existsSync('/home/workspace/.config/gh/hosts.yml')) {
  const setup = spawnSync('gh', ['auth', 'setup-git'], { stdio: 'ignore' });
  if (setup.status !== 0) console.error('Git credential helper setup failed');
}

createServer((_request, response) => {
  response.writeHead(200, { 'content-type': 'text/plain; charset=utf-8' });
  response.end('ready\n');
}).listen(80, '0.0.0.0');
