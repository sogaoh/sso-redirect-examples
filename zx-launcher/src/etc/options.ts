import { program, Option } from 'commander'
import { ComposeAction, Container } from './config.js'

const composeAction = new Option('-ca, --composeAction [composeAction]', 'compose action.')
  .default('up')
  .choices(['up', 'down', 'exec', 'logs'])

const composeOptions = new Option('-co, --composeOptions [composeOptions]', 'compose options.')
  .default('none')
  .choices(['none', 'u_d', 'u_db', 'd_ro'])

const targetContainer = new Option('-tc, --targetContainer [targetContainer]', 'target container.')
  .default('')
  .choices(['', 'web', 'client', 'db', 'redis'])

const debug = new Option('-D, --debug [debug]', 'use debug mode(show console log)').default(false)

program
  .usage('[options]')
  .addOption(composeAction)
  .addOption(composeOptions)
  .addOption(targetContainer)
  .addOption(debug)
  .parse(process.argv)

export type Options = {
  composeAction: ComposeAction
  composeOptions: string
  targetContainer: Container
  debug: boolean
}
export const Options = program.opts<Options>()
