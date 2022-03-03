import {
    HomebrewFormulaeProcess,
    HomebrewCasksProcess,
} from '../src/processes/homebrew'

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
