import { promises as fs, Dirent } from 'fs'
import os from 'os'

import { Process } from './abstract'
import { isError } from '../utils'

type ScutilData = {
    ComputerName: string
    LocalHostName: string
    HostName: string
}

export class SshProcess extends Process<string[]> {
    outFile = 'scutil'
    command = 'scutil --get {key}'
    data_template: ScutilData = {
        ComputerName: '',
        LocalHostName: '',
        HostName: '',
    }

    shouldSkip(): boolean {
        return false
    }

    async runBackup(): Promise<string[]> {
        const home = os.homedir()
        let files: Dirent[]
        try {
            files = await fs.readdir(`${home}/.ssh`, { withFileTypes: true })
        } catch (error) {
            if (
                isError(error) &&
                error.message.includes('no such file or directory')
            ) {
                this.log('no ~/.ssh directory. skipping')
                return []
            } else {
                throw error
            }
        }
        const sshFiles = files
            .filter(file => file.isFile())
            .map(file => file.name)
        return sshFiles
    }

    runRestore(data: string[]): Promise<void> {
        console.log(data)
        throw new Error('Method not implemented.')
    }
}
