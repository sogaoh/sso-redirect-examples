# sso-redirect-examples/zx-launcher

Example(s) of replacing Makefile(s) to command(s) using [google/zx](https://github.com/google/zx)

## PreRequirements

- Install [nvm](https://github.com/nvm-sh/nvm)
- Node.js v16.15.1 〜


## Usage 

### Initialize 

- cd

  ```bash
  cd /path/to/zx-launcher
  ```

- .nvmrc によって Node.js を自動設定

  ```bash
  nvm use
  ```

- 依存ライブラリのインストール

  ```bash
  npm ci
  ```


### Execute 

- Show Command List

  ```bash
  npm run
  ```

- Debug Mode : `-D / --debug`  
  (example) 

  ```bash
  npm run local:upb -- -D
  ```
