import { ActivateType } from './config.js'

type ProcessEnvs = {
  workDir: string
  imgTag: string
  noDevOpt: string
}

export const SetEnv = async (pe: ProcessEnvs) => {
  process.env.WORK_DIR = pe.workDir
  process.env.DOCKER_BUILDKIT = ActivateType.ON,
  process.env.IMG_TAG = pe.imgTag
  process.env.NO_DEV_OPT = pe.noDevOpt
  process.env.BLDARG_NODEV_OPT = '--build-arg NO_DEV_OPT=' + pe.noDevOpt
  process.env.AWS_REGION = 'ap-northeast-1'
  process.env.AWS_ACCOUNT_ID = '123456789012'
}
