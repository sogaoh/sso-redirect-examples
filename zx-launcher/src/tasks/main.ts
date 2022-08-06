#!/usr/bin/env -S npx zx

import { $ } from 'zx'
import 'dotenv/config.js'
import { Options as opts } from '../etc/options.js'
import { SetEnv } from '../etc/env.js'
import { Compose } from '../modules/compose.js'

const runDir = ((await $`(cd ../applications/run && pwd)`).stdout as string).replaceAll('\n', '')

SetEnv({
  workDir: runDir
})

if (opts.debug) console.log($.env)


const composeExecutor = new Compose({ opts })
if (true) { //TODO
    await composeExecutor.executor()
}
