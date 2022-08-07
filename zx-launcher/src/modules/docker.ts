#!/usr/bin/env -S npx zx

import { $ } from 'zx'
import { BaseProps } from '../etc/baseProps.js'
import { DockerOptionsMap, DockerOptionsType } from '../etc/config.js'
import { Parallels } from './parallel.js'

interface DockerProps extends BaseProps {
  contextBaseDir: string
}

export class Docker {
  private props: DockerProps
  constructor(props: DockerProps) {
    this.props = props
  }

  ps = async (): Promise<void> => {
    const psCmd = [
      'docker',
      'ps',
    ]
    await $`${psCmd}`.nothrow()
  }

  images = async (): Promise<void> => {
    const imagesCmd = [
      'docker',
      'images',
    ]
    await $`${imagesCmd}`.nothrow()
  }

  prune = async (): Promise<void> => {
    const opts = this.props.opts
    const dockerOptionString = DockerOptionsMap.get(opts.dockerOptions)

    const systemPruneCmd = [
      'docker',
      'system',
      'prune',
    ]
    dockerOptionString?.split(' ').forEach(opt => {
      systemPruneCmd.push(opt)
    })

    const builderPruneCmd = [
      'docker',
      'builder',
      'prune',
    ]
    dockerOptionString?.split(' ').forEach(opt => {
      builderPruneCmd.push(opt)
    })

    const p8s = Parallels<void>()
    p8s.add(
      new Promise(async _ => {
        await $`${systemPruneCmd}`.nothrow()
      }),
    )
    if (opts.dockerOptions == DockerOptionsType.P_ALL) {
      p8s.add(
        new Promise(async _ => {
          await $`${builderPruneCmd}`.nothrow()
        }),
      )
    }
    p8s.all()

    //await $`cd ${process.env.WORK_DIR};`.pipe($`${systemPruneCmd}`)
  }


}
