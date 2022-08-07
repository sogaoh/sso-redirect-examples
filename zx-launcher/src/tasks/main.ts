#!/usr/bin/env -S npx zx

import { $ } from 'zx'
import 'dotenv/config.js'
import { Options as opts } from '../etc/options.js'
import { SetEnv } from '../etc/env.js'
import { Compose } from '../modules/compose.js'
import { ComposeAction, DockerAction } from '../etc/config.js'
import { Docker } from '../modules/docker.js'

const runDir = ((await $`(cd ../applications/run && pwd)`).stdout as string).replaceAll('\n', '')
const shipDir = ((await $`(cd ../applications && pwd)`).stdout as string).replaceAll('\n', '')
const workDir = opts.workDir == 'ship' ? shipDir : runDir

SetEnv({
  workDir: workDir
})

if (opts.debug) console.log($.env)
if (opts.debug) console.log(opts)


const composeExecutor = new Compose({ opts })
if (opts.composeAction == ComposeAction.CHMOD) {
  await composeExecutor.chmod()
} else if (opts.composeAction != ComposeAction.NONE) {
  await composeExecutor.executor()
}

const dockerExecutor = new Docker({ opts, contextBaseDir:workDir })
if (opts.dockerAction == DockerAction.PRUNE) {
  await dockerExecutor.prune()
} else if (opts.dockerAction == DockerAction.PS) {
  await dockerExecutor.ps()
} else if (opts.dockerAction == DockerAction.IMAGES) {
  await dockerExecutor.images()
} else if (opts.dockerAction != DockerAction.NONE) {

}
