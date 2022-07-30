import { ActivateType } from './config.js'

type ProcessEnvs = {
  workDir: string
}

export const SetEnv = async (pe: ProcessEnvs) => {
  process.env.WORK_DIR = pe.workDir
  process.env.DOCKER_BUILDKIT = ActivateType.ON
}
