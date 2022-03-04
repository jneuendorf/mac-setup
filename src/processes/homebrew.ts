import childProcess from 'child_process'
import util from 'util'
import { Process } from './abstract'

const exec = util.promisify(childProcess.exec)

export class HomebrewFormulaeProcess extends Process<string[]> {
    name = 'homebrew-formulae'
    command = 'brew leaves'

    shouldSkip(): boolean {
        return false
    }

    async runBackup(): Promise<string[]> {
        const { stderr, stdout } = await exec(this.command)
        if (stderr) {
            await this.log(stderr)
        }
        return stdout.trim().split('\n')
    }

    runRestore(data: string[]): Promise<void> {
        console.log(data)
        throw new Error('Method not implemented.')
    }
}

export class HomebrewCasksProcess extends Process<string[]> {
    name = 'homebrew-casks'
    command = 'brew list --cask'

    shouldSkip(): boolean {
        return false
    }

    async runBackup(): Promise<string[]> {
        const { stderr, stdout } = await exec(this.command)
        if (stderr) {
            await this.log(stderr)
            // fs.appendFile(this.logFile, stderr)
            // console.log(`errors from '${this.command}'`, stderr)
        }
        return stdout.trim().split('\n')
    }

    runRestore(data: string[]): Promise<void> {
        console.log(data)
        throw new Error('Method not implemented.')
    }
}
