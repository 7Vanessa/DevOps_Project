# test-webapp-simple

A simple repo that has the smallest dependencies for webapp/ static webpage

By default accessing to the webpage you should be able to see

```text
Hello! Anonymous!
Greeting!
```

You can change `Anonymous` by setting the build args (only at static page)
and `Greeting` by setting the env vars (only at webapp)

## Static Website

Build

```bash
npm install && npm run build
```

### Build Args

- `USERNAME`: default `nobody`

Then serve the content at `public`

## Web app

Install

```bash
npm install
```

Run

```bash
npm run start
```

### Env Variables

`SERVER_PORT`: default `3000`
`GREETING`: default `ALOHA!`
