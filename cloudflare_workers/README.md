# Develop with Wrangler CLI

### Install Wrangler
```bash
npm install -g wrangler
```
---

### Authenticate Wrangler
Authenticate Wrangler with your Cloudflare account
To enable Wrangler to deploy your scripts to Cloudflare, you'll need to authenticate by logging in to your Cloudflare account.
```bash
wrangler login
```
When wrangler automatically opens your browser to display Cloudflare’s consent screen, click the Allow button. This will send an API Token to Wrangler.

---

### Initialise a project
Initialise a new project from a Worker created via dashboard:
```bash
wrangler init --from-dash <worker-name>
```
---

### Deploy your Wrangler project
Deploy your project to Cloudflare’s global network:
```bash
wrangler deploy ./src/worker.js
```