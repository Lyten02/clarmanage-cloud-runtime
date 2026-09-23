import { existsSync } from 'node:fs';
import { createRequire } from 'node:module';
import { dirname, join } from 'node:path';

const clarmanageRoot = '/usr/local/lib/node_modules/@armanage/clarmanage';
const sdkPath = join(clarmanageRoot, 'node_modules/@openai/codex-sdk/dist/index.js');
if (!existsSync(sdkPath)) throw new Error('Clarmanage Codex SDK is missing');
const sdkRequire = createRequire(sdkPath);
const cliPath = sdkRequire.resolve('@openai/codex/package.json');
const cliRequire = createRequire(cliPath);

const target = {
  x64: ['@openai/codex-linux-x64', 'x86_64-unknown-linux-musl'],
  arm64: ['@openai/codex-linux-arm64', 'aarch64-unknown-linux-musl'],
}[process.arch];

if (!target) throw new Error(`Unsupported architecture: ${process.arch}`);

const [packageName, triple] = target;
const packagePath = cliRequire.resolve(`${packageName}/package.json`);
const binary = join(dirname(packagePath), 'vendor', triple, 'bin', 'codex');
if (!existsSync(binary)) throw new Error(`Missing Codex binary: ${triple}`);

console.log(`Codex binary available: ${triple}`);
