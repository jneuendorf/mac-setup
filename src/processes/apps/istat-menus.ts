import { Process } from '../abstract'

export class IStatMenusProcess extends Process<string[]> {
    name = 'istat-menus'

    shouldSkip(): boolean {
        throw new Error('Method not implemented.')
    }

    runBackup(): Promise<string[]> {
        throw new Error('Method not implemented.')
    }

    runRestore(data: string[]): Promise<void> {
        throw new Error('Method not implemented.')
    }
}
