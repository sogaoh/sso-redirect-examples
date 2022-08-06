import { program, Option } from 'commander'
import { ComposeAction, Container } from './config.js'

const workDir = new Option('-wd, --workDir [workDir]', 'working directory.')
  .default('run')
  .choices(['run', 'ship'])

const composeAction = new Option('-ca, --composeAction [composeAction]', 'compose action.')
  .default('none')
  .choices(['none', 'up', 'down', 'exec', 'logs', 'build'])

const composeOptions = new Option('-co, --composeOptions [composeOptions]', 'compose options.')
  .default('none')
  .choices(['none', 'u_d', 'u_db', 'd_ro', 'b_rb'])

const targetContainer = new Option('-tc, --targetContainer [targetContainer]', 'target container.')
  .default('')
  .choices(['', 'web', 'client', 'db', 'redis'])

const debug = new Option('-D, --debug [debug]', 'use debug mode(show console log)').default(false)

program
  .usage('[options]')
  .addOption(workDir)
  .addOption(composeAction)
  .addOption(composeOptions)
  .addOption(targetContainer)
  .addOption(debug)
  .parse(process.argv)

export type Options = {
  workDir: string
  composeAction: ComposeAction
  composeOptions: string
  targetContainer: Container
  debug: boolean
}
export const Options = program.opts<Options>()
