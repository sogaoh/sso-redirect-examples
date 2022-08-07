import { program, Option } from 'commander'
import { ComposeAction, Container, DockerAction } from './config.js'

const workDir = new Option('-wd, --workDir [workDir]', 'working directory.')
  .default('run')
  .choices(['run', 'ship'])

const composeAction = new Option('-ca, --composeAction [composeAction]', 'compose action.')
  .default('none')
  .choices(['none', 'up', 'down', 'exec', 'logs', 'build', 'chmod'])

const composeOptions = new Option('-co, --composeOptions [composeOptions]', 'compose options.')
  .default('none')
  .choices(['none', 'u_d', 'u_db', 'd_ro', 'b_rb'])

const targetContainer = new Option('-tc, --targetContainer [targetContainer]', 'target container.')
  .default('')
  .choices(['', 'web', 'client', 'db', 'redis'])

const dockerAction = new Option('-da, --dockerAction [dockerAction]', 'docker action.')
  .default('none')
  .choices(['none', 'prune', 'ps', 'images', 'build', 'tag', 'push'])

const dockerOptions = new Option('-do, --dockerOptions [dockerOptions]', 'docker options.')
  .default('none')
  .choices(['none', 'p_vf', 'p_all', 'b_nc'])

const debug = new Option('-D, --debug [debug]', 'use debug mode(show console log)').default(false)

program
  .usage('[options]')
  .addOption(workDir)
  .addOption(composeAction)
  .addOption(composeOptions)
  .addOption(targetContainer)
  .addOption(dockerAction)
  .addOption(dockerOptions)
  .addOption(debug)
  .parse(process.argv)

export type Options = {
  workDir: string
  composeAction: ComposeAction
  composeOptions: string
  targetContainer: Container
  dockerAction: DockerAction
  dockerOptions: string
  debug: boolean
}
export const Options = program.opts<Options>()
