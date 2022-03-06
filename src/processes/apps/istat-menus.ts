import { constants as FS, promises as fs } from 'fs'
import path from 'path'

import { exec } from '../../utils'
import { Process } from '../abstract'

const CWD = process.cwd()
const SETTINGS_FILE = path.resolve(CWD, 'iStat Menus Settings.ismp')

export class IStatMenusProcess extends Process<string> {
    name = 'istat-menus'
    private command = `osascript ${path.resolve(
        __dirname,
        '../../istat-menus.applescript'
    )} ${CWD}`

    shouldSkip(): boolean {
        throw new Error('Method not implemented.')
    }

    async runBackup(): Promise<string> {
        try {
            await fs.access(SETTINGS_FILE, FS.F_OK)
            this.log(`${SETTINGS_FILE} already exists, skipping...`)
        } catch (error) {
            // console.log('running', this.command)
            const { stderr, stdout } = await exec(this.command)
            if (stderr) {
                await this.log(stderr)
            }
            console.log(stdout)
        }
        return SETTINGS_FILE
    }

    runRestore(data: string): Promise<void> {
        console.log(data)
        throw new Error('Method not implemented.')
    }
}
