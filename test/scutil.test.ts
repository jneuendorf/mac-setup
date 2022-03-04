import { ScutilProcess } from '../src/processes/scutil'

describe('scutil', () => {
    it('computer names', async () => {
        const process = new ScutilProcess()
        const data = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        // console.log(data)
        expect(data).not.toEqual([])
    })
})
