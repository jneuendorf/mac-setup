import { promises as fs } from 'fs'
import os from 'os'

import { Process } from './abstract'


export class DotFilesProcess extends Process<string[]> {
    IGNORED_DOT_FILES = new Set([
        '.DS_Store',
        '.Trash',
        '.cache',
    ])
    protected outFile = 'dot-files'

    shouldSkip(): boolean {
        return false
    }

    async runBackup(): Promise<string[]> {
        const files = await this.getFiles()
        const filteredFiles = this.filteredFiles(files)
        return filteredFiles
    }

    async getFiles(): Promise<string[]> {
        const home = os.homedir()
        const files = await fs.readdir(home, { withFileTypes: true })
        const dotFiles = files.filter(file => (
            file.isFile()
            && !this.IGNORED_DOT_FILES.has(file.name)
            && file.name.startsWith('.'))
        ).map(file => file.name)
        return dotFiles
    }

    filteredFiles(files: string[]): string[] {
        return files
    }

    runRestore(data: string[]): Promise<void> {
        throw new Error('Method not implemented.')
    }
}