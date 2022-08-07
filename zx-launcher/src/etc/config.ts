const ComposeAction = {
  NONE: 'none',
  UP:   'up',
  DOWN: 'down',
  EXEC: 'exec',
  LOGS: 'logs',
  BLD:  'build',
  CHMOD:'chmod',
}
type ComposeAction = typeof ComposeAction[keyof typeof ComposeAction]

const Container = {
  WEB:   'web',
  CLN:   'client',
  DB:    'db',
  REDIS: 'redis'
}
type Container = typeof Container[keyof typeof Container]

const ContainerShellMap = new Map([
  [Container.WEB,   'ash'],
  [Container.CLN,   'bash'],
  [Container.DB,    'bash'],
  [Container.REDIS, 'ash'],
])
type ContainerShellMap = typeof ContainerShellMap[keyof typeof ContainerShellMap]

const ComposeOptionsType = {
  NONE: 'none',
  U_D:  'u_d',
  U_DB: 'u_db',
  D_RO: 'd_ro',
  B_RB: 'b_rb',
}
type ComposeOptionsType = typeof ComposeOptionsType[keyof typeof ComposeOptionsType]

const ComposeOptionsMap = new Map([
  [ComposeOptionsType.NONE, ''],
  [ComposeOptionsType.U_D,  '-d'],
  [ComposeOptionsType.U_DB, '-d --build'],
  [ComposeOptionsType.D_RO, '--remove-orphans'],
  [ComposeOptionsType.B_RB, '--no-cache --force-rm'],
])
type ComposeOptionsMap = typeof ComposeOptionsMap[keyof typeof ComposeOptionsMap]

const DockerAction = {
  NONE:  'none',
  PRUNE: 'prune',
  PS:    'ps',
  IMAGES:'images',
  BUILD: 'build',
  TAG:   'tag',
  PUSH:  'push',
}
type DockerAction = typeof DockerAction[keyof typeof DockerAction]

const DockerOptionsType = {
  NONE:  'none',
  P_VF:  'p_vf',
  P_ALL: 'p_all',
}
type DockerOptionsType = typeof DockerOptionsType[keyof typeof DockerOptionsType]

const DockerOptionsMap = new Map([
  [DockerOptionsType.NONE,  ''],
  [DockerOptionsType.P_VF,  '--volumes --force'],
  [DockerOptionsType.P_ALL, '--all --force'],
])
type DockerOptionsMap = typeof DockerOptionsMap[keyof typeof DockerOptionsMap]

const ActivateType = {
  OFF: '0',
  ON:  '1',
}
type ActivateType = typeof ActivateType[keyof typeof ActivateType]

export {
  ComposeAction,
  Container,
  ContainerShellMap,
  ComposeOptionsMap,
  DockerAction,
  DockerOptionsMap,
  DockerOptionsType,
  ActivateType
}
