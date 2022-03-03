import { HomebrewFormulaeProcess, HomebrewCasksProcess } from '../src/processes/homebrew'
import { ScutilProcess } from '../src/processes/scutil'


describe.skip('homebrew', () => {
    it('formulae', async () => {
        const process = new HomebrewFormulaeProcess()
        const formulae = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        console.log(formulae)
        expect(formulae).not.toEqual([])
    })

    it('casks', async () => {
        const process = new HomebrewCasksProcess()
        const casks = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        console.log(casks)
        expect(casks).not.toEqual([])
    })
})


describe('scutil', () => {
    it('computer names', async () => {
        const process = new ScutilProcess()
        const data = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        console.log(data)
        expect(data).not.toEqual([])
    })
})
