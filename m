From: Ana Aviles <ana@greenhost.nl>
Subject: Re: OSDs continuously crashing with v9.2.1
Date: Fri, 6 May 2016 18:29:01 +0200
Message-ID: <572CC64D.5050204@greenhost.nl>
References: <572C6C60.3090808@greenhost.nl>
 <alpine.DEB.2.11.1605060842230.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smarthost1.greenhost.nl ([195.190.28.81]:35706 "EHLO
	smarthost1.greenhost.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbcEFQ3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 12:29:04 -0400
In-Reply-To: <alpine.DEB.2.11.1605060842230.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



On 05/06/2016 02:45 PM, Sage Weil wrote:
> On Fri, 6 May 2016, Ana Aviles wrote: Hello,
>=20
> We are currently experiencing an unstable cluster on a backup
> cluster, we believe it is due to the latest Cephversion 9.2.1=20
> (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd). OSDs keep on crashing,=20
> segfaulting, which eventually leads some of them to be down, or
> leave the cluster on strange scenarios like having unfound
> objects.
>=20
> [Fri May  6 09:45:09 2016] ceph-osd[17588]: segfault at 0 ip=20
> 00007f2bbc5e692a sp 00007f2ba8905060 error 4 in=20
> libtcmalloc.so.4.1.2[7f2bbc5c3000+43000] [Fri May  6 09:45:09 2016]
> init: ceph-osd (ceph/72) main process (16509) killed by SEGV
> signal [Fri May  6 09:45:09 2016] init: ceph-osd (ceph/72) main
> process ended, respawning
>=20
> Our nodes run Ubuntu 14.04.4 LTS, and two of them Ceph version
> 9.2.0 (bb2ecea240f3a1d525bcb35670cb07bd1f0ca299) while the other
> two run ceph version 9.2.1
> (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd). Only on v.9.2.1. osds
> keep on segfaulting. On some of them we see:
>=20
> ceph version 9.2.1 (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd) 1:
> (()+0x7d1aca) [0x7f42100b3aca] 2: (()+0x10340) [0x7f420e7c6340] 3:=20
> (tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::=
=46
reeList*,
>
>=20
unsigned long, int)+0x103) [0x7f420e9f7923]
> 4:=20
> (tcmalloc::ThreadCache::ListTooLong(tcmalloc::ThreadCache::FreeList*,
>
>=20
unsigned long)+0x1b) [0x7f420e9f79db]
> 5: (tc_free()+0x1f8) [0x7f420ea052c8] 6: (()+0x50451)
> [0x7f420e4cc451] 7: (PK11_FreeSlotList()+0x9) [0x7f420e4cc479] 8:
> (PK11_GetAllTokens()+0x1cc) [0x7f420e4cec5c] 9:
> (PK11_GetBestSlotMultipleWithAttributes()+0x23b) [0x7f420e4cf06b]=20
> 10: (PK11_GetBestSlot()+0x1f) [0x7f420e4cf0df] 11:
> (CryptoAES::get_key_handler(ceph::buffer::ptr const&,=20
> std::string&)+0x1f4) [0x7f42100d3484] 12:
> (CryptoKey::_set_secret(int, ceph::buffer::ptr const&)+0xcc)=20
> [0x7f42100d25fc] 13:
> (CryptoKey::decode(ceph::buffer::list::iterator&)+0xa2)=20
> [0x7f42100d2922] 14: (void
> decode_decrypt_enc_bl<CephXServiceTicket>(CephContext*,=20
> CephXServiceTicket&, CryptoKey, ceph::buffer::list&,=20
> std::string&)+0x4a5) [0x7f42100c0f05] 15: (int
> decode_decrypt<CephXServiceTicket>(CephContext*,=20
> CephXServiceTicket&, CryptoKey const&,
> ceph::buffer::list::iterator&, std::string&)+0x1cf)
> [0x7f42100c12df] 16:
> (CephXTicketHandler::verify_service_ticket_reply(CryptoKey&,=20
> ceph::buffer::list::iterator&)+0xdb) [0x7f42100bb5ab] 17:
> (CephXTicketManager::verify_service_ticket_reply(CryptoKey&,=20
> ceph::buffer::list::iterator&)+0x122) [0x7f42100bd442] 18:
> (CephxClientHandler::handle_response(int,=20
> ceph::buffer::list::iterator&)+0xef4) [0x7f421024a2b4] 19:
> (MonClient::handle_auth(MAuthReply*)+0xce) [0x7f421014589e] 20:
> (MonClient::ms_dispatch(Message*)+0x297) [0x7f4210147b27] 21:
> (DispatchQueue::entry()+0x63a) [0x7f421025683a] 22:
> (DispatchQueue::DispatchThread::entry()+0xd) [0x7f4210180ecd] 23:
> (()+0x8182) [0x7f420e7be182] 24: (clone()+0x6d) [0x7f420cb0547d]=20
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
> needed to interpret this.
>=20
> Which is the same error reported 8 days ago=20
> http://tracker.ceph.com/issues/15628
>=20
>=20
> Here is the log of one of the down OSDs:
> http://pastebin.com/dcHKrE8f
>=20
> Now we would like to downgrade to version 9.2.0 all nodes, since we
> keep on having osds down and sometimes OSDs with corrupted
> metadata. However, it looks like it is not possible to downgrade a
> Ceph version?
>=20
>> Our goal is to make downgrades within a stable series possible,
>> but we have not tested them for infernalis.
>=20
>> There was one fix in the auth code that may affect this.  I
>> pushed a branch that backports it to infernalis and pushed a
>> wip-auth-infernalis branch. The packages should show up on
>> gitbuilder.ceph.com in an hour or so.  Can you give those a try?
>=20
>> http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/wip-auth=
-
infernalis

Thanks!
>>=20
We just installed them and it's running so far so good. We'll
keep an eye on it and report if we see them happening again.

>=20
>> We haven't seen this crash at all in any of our testing.  :(
>=20
> Besides that, we also have "wrong node!" messages on most of our
> osd logs (on both nodes with v9.2.1 and v9.2.0). We don't know if
> it is related, or if we should also have a look at that.
>=20
> 2016-05-05 15:30:16.994946 7f7272cc3700  0 --=20
> [2a00:c6c0:0:120::201]:6893/5870 >>
> [2a00:c6c0:0:120::202]:6807/10502 pipe(0x7f72cc272000 sd=3D24 :53006
> s=3D1 pgs=3D309 cs=3D19 l=3D0 c=3D0x7f72d23f31e0).connect claims to b=
e
> [2a00:c6c0:0:120::202]:6807/4013 not
> [2a00:c6c0:0:120::202]:6807/10502 - wrong node!
>=20
>> These are harmless--they're just there because OSDs are
>> restarting and reusing some of the same ports.
>=20
>> sage
>=20
>=20
>=20
> Thanks!
>=20
>=20
>=20
>>=20
>> -- To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>=20

- --=20
Ana Avil=C3=A9s
Greenhost - sustainable hosting & digital security
E: ana@greenhost.nl
T: +31 20 4890444
W: https://greenhost.nl
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXLMZFAAoJEOUdSHwFo2bgw9IH/iCforwStrJFIO3i33QXuu0b
N0HgmInlUc0DvkrurysrK+3wcK2jAnkgIoy3ESN+pj62X9QlSiHcQGhEknLoW0JS
NOzh7yB2srX6UQKKqm6RU7E7lQ9eO1OK1rQRFi4q1mVQU+y0yOk0YS6JXm8/+4gf
rRN1p7LRHEVIQF9X2zn+FmXHP9z22LCHX4/8RDwnx4uEYwhSijBDPq4pmxFgWABJ
OpWs3/HxZuQZpnDhKHfzizK1LpWR27paZjpwiVC2gYsed8V+Nat5mmsRs9cl2VIM
N+OlDHVSklPGa/QytZzFVhIOs/bY1VwigmdSQ51SSztWWbmC4ddK2kJU+PKMtUQ=3D
=3D61AE
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
