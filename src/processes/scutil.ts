import childProcess from 'child_process'
import util from 'util'

import { Process } from './abstract'
import { isError } from '../utils'

const exec = util.promisify(childProcess.exec)

type ScutilData = {
    ComputerName: string
    LocalHostName: string
    HostName: string
}

export class ScutilProcess extends Process<ScutilData> {
    name = 'scutil'
    command = 'scutil --get {key}'
    data_template: ScutilData = {
        ComputerName: '',
        LocalHostName: '',
        HostName: '',
    }

    shouldSkip(): boolean {
        return false
    }

    async runBackup(): Promise<ScutilData> {
        const data: ScutilData = { ...this.data_template }
        const keys = Object.keys(data) as (keyof ScutilData)[]
        for (const key of keys) {
            try {
                const { stderr, stdout } = await exec(
                    this.command.replace('{key}', key)
                )
                if (stderr) {
                    await this.log(stderr)
                }
                data[key] = stdout.trim()
            } catch (error) {
                if (!(isError(error) && error.message.includes('not set'))) {
                    throw error
                }
            }
        }
        return data
    }

    runRestore(data: ScutilData): Promise<void> {
        console.log(data)
        throw new Error('Method not implemented.')
    }
}
