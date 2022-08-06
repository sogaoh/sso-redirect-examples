const ComposeAction = {
  NONE: 'none',
  UP:   'up',
  DOWN: 'down',
  EXEC: 'exec',
  LOGS: 'logs',
  BLD:  'build',
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
  ActivateType
}
