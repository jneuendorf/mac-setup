import { constants as FS, promises as fs } from 'fs'


export abstract class Process<T> {
    protected abstract outFile: string

    abstract shouldSkip(): boolean

    abstract runBackup(): Promise<T>

    abstract runRestore(data: T): Promise<void>

    get logFile(): string {
        return `${this.outFile}.log`
    }

    async log(data: string): Promise<void> {
        try {
            await fs.access(this.logFile, FS.F_OK | FS.W_OK)
        }
        catch (error) {
            await fs.writeFile(this.logFile, '')
        }
        await fs.appendFile(this.logFile, data.toString())
    }

    /**
     *
     * @param options Options are `skip` and `writeOutFile`:
     *   - `skip` force skip or force not-skip
     *   - `writeOutFile` whether to write JSON to `outFile` or not
     * @returns
     */
    async backup(options: { skip?: boolean, writeOutFile?: boolean } = {}): Promise<T | void> {
        const { skip, writeOutFile = true } = options
        const shouldSkip = (
            skip === undefined
                ? !this.shouldSkip
                : skip
        )
        if (!shouldSkip) {
            try {
                const data = await this.runBackup()
                if (writeOutFile) {
                    await this.writeOutFile(data)
                }
                return data
            }
            catch (error) {
                if (error instanceof Object) {
                    await this.log(error.toString())
                    // await fs.appendFile(this.logFile, error.toString())
                }
                else {
                    throw error
                }
            }
        }
    }

    async writeOutFile(data: T): Promise<void> {
        await fs.writeFile(
            `${this.outFile}.json`,
            JSON.stringify(data, undefined, 2),
        )
    }
}