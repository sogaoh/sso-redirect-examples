#!/usr/bin/env -S npx zx

import { $ } from 'zx'
import { ComposeAction, ComposeOptionsMap, ContainerShellMap } from '../etc/config.js'
import { Options } from '../etc/options.js'
import { Parallels } from './parallel.js'

interface ComposeProps {
  opts: Options
}

export class Compose {
  private props: ComposeProps
  constructor(props: ComposeProps) {
    this.props = props
  }

  executor = async (): Promise<void> => {
    const opts = this.props.opts
    const composeOptionString = ComposeOptionsMap.get(opts.composeOptions)

    const execCmd = [
      'docker-compose',
      '-f',
      `${process.env.WORK_DIR}/docker-compose.yml`
    ]
    execCmd.push(this.props.opts.composeAction)
    switch (this.props.opts.composeAction) {
      case ComposeAction.UP:
      case ComposeAction.DOWN:
        composeOptionString?.split(' ').forEach(opt => {
          execCmd.push(opt)
        })
        break
      case ComposeAction.EXEC:
        if (this.props.opts.targetContainer != '') {
          const containerShell = ContainerShellMap.get(opts.targetContainer)
          execCmd.push(opts.targetContainer)
          execCmd.push(String(containerShell))
          console.log(execCmd.join(' '))
          return
        } else {
          return
        }
        break
      case ComposeAction.LOGS:
        execCmd.push('-f')
        execCmd.push(opts.targetContainer)
        break
      default:  break
    }

    //console.log(this.props.opts)
    //console.log(execCmd)
    await $`cd ${process.env.WORK_DIR};`.pipe($`${execCmd}`)
  }

  chmod = async () => {
    const chmodStorage = [
      'docker-compose',
      '-f',
      `${process.env.WORK_DIR}/docker-compose.yml`,
      'exec',
      'client',
      'chmod',
      '-R',
      'a+w',
      'storage'
    ]
    const chmodBootstrapCache = [
      'docker-compose',
      '-f',
      `${process.env.WORK_DIR}/docker-compose.yml`,
      'exec',
      'client',
      'chmod',
      '-R',
      'a+w',
      'bootstrap/cache'
    ]

    const p8s = Parallels<void>()
    p8s.add(
      new Promise(async _ => {
        await $`${chmodStorage}`.nothrow()
      }),
    )
    p8s.add(
      new Promise(async _ => {
        await $`${chmodBootstrapCache}`.nothrow()
      }),
    )
    p8s.all()
  }
}
