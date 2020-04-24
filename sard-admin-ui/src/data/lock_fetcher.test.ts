import { getLocksCore } from './lock_fetcher'

describe('locker', () => {
    it('returns [] with empty response', async () => {
        const got = await getLocksCore(new Response(' \n    '))
        expect(got).toHaveLength(0)
    })
    it('returns results', async () => {
        const got = await getLocksCore(new Response(' leading space \nokresult  extra  '))
        expect(got).toHaveLength(1)
        expect(got[0]).toEqual('okresult')
    })
    it('accepts real data', async () => {
        const got = await getLocksCore(new Response(`
/operacoes/2020.0010712/Equipe03/item04_M200234/item04_M200234.dd
<a href='./unlock/?path=%2Foperacoes%2F2020.0010712%2FEquipe03%2Fitem04_M200234%2Fitem04_M200234.dd'>Unlock</a>
<br>
        `))
        expect(got).toHaveLength(1)
        expect(got[0]).toEqual('/operacoes/2020.0010712/Equipe03/item04_M200234/item04_M200234.dd')
    })
})