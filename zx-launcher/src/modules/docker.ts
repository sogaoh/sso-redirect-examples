#!/usr/bin/env -S npx zx

import { $ } from 'zx'
import { BaseProps } from '../etc/baseProps.js'
import { Container, ContainerIdentifierMap, ContainerNameMap, DockerOptionsMap, DockerOptionsType } from '../etc/config.js'
import { Parallels } from './parallel.js'

interface DockerProps extends BaseProps {
  contextBaseDir: string
}

interface DockerIF {
  build: (prop: DockerProps) => string[]
  tag: (prop: DockerProps) => string[]
}

const nginx: DockerIF = {
  build: prop => {
    const dockerOptionString = DockerOptionsMap.get(prop.opts.dockerOptions)
    const nginxBuild = [
      //'DOCKER_BUILDKIT=1',
      'docker',
      'build',
    ]
    dockerOptionString?.split(' ').forEach(opt => {
      nginxBuild.push(opt)
    })
    nginxBuild.push(
      '-t',
      `${ContainerNameMap.get(Container.WEB)}:${process.env.IMG_TAG}`,
      '-f',
      `${prop.contextBaseDir}/ship/docker/nginx-node/Dockerfile`,
      `${prop.contextBaseDir}`
    )
    return nginxBuild
  },

  tag: prop => {
    const nginxTag = [
      //'DOCKER_BUILDKIT=1',
      'docker',
      'tag',
    ]
    nginxTag.push(
      `${ContainerNameMap.get(Container.WEB)}:${process.env.IMG_TAG}`,
      `${process.env.AWS_ACCOUNT_ID}.dkr.ecr.${process.env.AWS_REGION}.amazonaws.com/${ContainerNameMap.get(Container.WEB)}:${process.env.IMG_TAG}`,
    )
    return nginxTag
  }
}

const laravel: DockerIF = {
  build: prop => {
    const dockerOptionString = DockerOptionsMap.get(prop.opts.dockerOptions)
    const laravelBuild = [
      //'DOCKER_BUILDKIT=1',
      'docker',
      'build',
    ]
    dockerOptionString?.split(' ').forEach(opt => {
      laravelBuild.push(opt)
    })
    laravelBuild.push(
      '-t',
      `${ContainerNameMap.get(Container.CLN)}:${process.env.IMG_TAG}`,
      '-f',
      `${prop.contextBaseDir}/ship/docker/php/Dockerfile`,
      `${prop.contextBaseDir}`
    )
    const buildArgs = `${process.env.BLDARG_NODEV_OPT}`
    buildArgs.split(' ').forEach(buildArg => {
      laravelBuild.push(buildArg)
    })
    return laravelBuild
  },

  tag: prop => {
    const laravelTag = [
      //'DOCKER_BUILDKIT=1',
      'docker',
      'tag',
    ]
    laravelTag.push(
      `${ContainerNameMap.get(Container.CLN)}:${process.env.IMG_TAG}`,
      `${process.env.AWS_ACCOUNT_ID}.dkr.ecr.${process.env.AWS_REGION}.amazonaws.com/${ContainerNameMap.get(Container.CLN)}:${process.env.IMG_TAG}`,
    )

    return laravelTag
  }
}

const containers = new Map(Object.entries({ nginx, laravel }))

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
  }

  async parallelBuild(): Promise<void> {
    const containerIdentifiers = [
      ContainerIdentifierMap.get(Container.WEB) ?? '',
      ContainerIdentifierMap.get(Container.CLN) ?? ''
    ]
    const p8s = Parallels<void>()
    containerIdentifiers.forEach(async identifier => {
      p8s.add(
        new Promise(async _ => {
          await $`${containers.get(identifier)?.build({
            opts: this.props.opts,
            contextBaseDir: this.props.contextBaseDir
          })}`.nothrow()
        })
      )
    })
    p8s.all()
  }

  async parallelTag(): Promise<void> {
    const containerIdentifiers = [
      ContainerIdentifierMap.get(Container.WEB) ?? '',
      ContainerIdentifierMap.get(Container.CLN) ?? ''
    ]
    const p8s = Parallels<void>()
    containerIdentifiers.forEach(async identifier => {
      p8s.add(
        new Promise(async _ => {
          await $`${containers.get(identifier)?.tag({
            opts: this.props.opts,
            contextBaseDir: this.props.contextBaseDir
          })}`.nothrow()
        })
      )
    })
    p8s.all()
  }
}
