import { DotFilesProcess } from '../src/processes/dot-files'

describe('dot files', () => {
    it('works', async () => {
        const process = new DotFilesProcess()
        const dotFiles = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        // console.log(dotFiles)
        expect(dotFiles).not.toEqual([])
    })
})
