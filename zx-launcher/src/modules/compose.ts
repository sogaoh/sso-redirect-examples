#!/usr/bin/env -S npx zx

import { $ } from 'zx'
import { ComposeOptionsMap } from '../etc/config.js'
import { Options } from '../etc/options.js'

interface ComposeProps {
  opts: Options
}

export class Compose {
  private props: ComposeProps
  constructor(props: ComposeProps) {
    this.props = props
  }
  executor = async (): Promise<void> => {
    const composeOptionString = ComposeOptionsMap.get(this.props.opts.composeOptions)

    const execCmd = ['docker-compose', '-f', `${process.env.WORK_DIR}/docker-compose.yml`]
    execCmd.push(this.props.opts.composeAction)
    composeOptionString?.split(' ').forEach(opt => {
      execCmd.push(opt)
    })

    await $`cd ${process.env.WORK_DIR};`.pipe($`${execCmd}`)
  }
}
