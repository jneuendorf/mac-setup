import { IStatMenusProcess } from '../src/processes/apps/istat-menus'

describe('scutil', () => {
    it('computer names', async () => {
        const process = new IStatMenusProcess()
        const data = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        // console.log(data)
        expect(data).not.toEqual([])
    })
})
