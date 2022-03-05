import { SshProcess } from '../src/processes/ssh'

describe('SSH files', () => {
    it('works', async () => {
        const process = new SshProcess()
        const sshFiles = await process.backup({
            skip: false,
            writeOutFile: false,
        })
        // console.log(sshFiles)
        if (sshFiles) {
            for (const file of sshFiles) {
                try {
                    expect(['config', 'known_hosts', '.DS_Store']).toContain(
                        file
                    )
                } catch (error) {
                    // Check for (id_rsa, id_ras.pub) pairs
                    if (file.endsWith('.pub')) {
                        expect(sshFiles).toContain(file.slice(0, -4))
                    } else {
                        expect(sshFiles).toContain(`${file}.pub`)
                    }
                }
            }
        }
    })
})
