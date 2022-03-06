import path from 'path'

import { exec } from '../../utils'
import { Process } from '../abstract'

export class IStatMenusProcess extends Process<string[]> {
    name = 'istat-menus'
    private command = `osascript ${path.resolve(
        __dirname,
        '../../istat-menus.applescript'
    )} ${process.cwd()}`

    shouldSkip(): boolean {
        throw new Error('Method not implemented.')
    }

    async runBackup(): Promise<string[]> {
        console.log('running', this.command)
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
