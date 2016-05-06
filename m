From: Sage Weil <sage@newdream.net>
Subject: Re: OSDs continuously crashing with v9.2.1
Date: Fri, 6 May 2016 08:45:50 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605060842230.15518@cpach.fuggernut.com>
References: <572C6C60.3090808@greenhost.nl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-574103004-1462538753=:15518"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55798 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbcEFMpl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 08:45:41 -0400
In-Reply-To: <572C6C60.3090808@greenhost.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ana Aviles <ana@greenhost.nl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-574103004-1462538753=:15518
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 6 May 2016, Ana Aviles wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hello,
> 
> We are currently experiencing an unstable cluster on a backup cluster,
> we believe it is due to the latest Cephversion 9.2.1
> (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd). OSDs keep on crashing,
> segfaulting, which eventually leads some of them to be down, or leave
> the cluster on strange scenarios like having unfound objects.
> 
> [Fri May  6 09:45:09 2016] ceph-osd[17588]: segfault at 0 ip
> 00007f2bbc5e692a sp 00007f2ba8905060 error 4 in
> libtcmalloc.so.4.1.2[7f2bbc5c3000+43000]
> [Fri May  6 09:45:09 2016] init: ceph-osd (ceph/72) main process (16509)
> killed by SEGV signal
> [Fri May  6 09:45:09 2016] init: ceph-osd (ceph/72) main process ended,
> respawning
> 
> Our nodes run Ubuntu 14.04.4 LTS, and two of them Ceph version 9.2.0
> (bb2ecea240f3a1d525bcb35670cb07bd1f0ca299) while the other two run ceph
> version 9.2.1 (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd). Only on
> v.9.2.1. osds keep on segfaulting. On some of them we see:
> 
> ceph version 9.2.1 (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd)
>  1: (()+0x7d1aca) [0x7f42100b3aca]
>  2: (()+0x10340) [0x7f420e7c6340]
>  3:
> (tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
> unsigned long, int)+0x103) [0x7f420e9f7923]
>  4:
> (tcmalloc::ThreadCache::ListTooLong(tcmalloc::ThreadCache::FreeList*,
> unsigned long)+0x1b) [0x7f420e9f79db]
>  5: (tc_free()+0x1f8) [0x7f420ea052c8]
>  6: (()+0x50451) [0x7f420e4cc451]
>  7: (PK11_FreeSlotList()+0x9) [0x7f420e4cc479]
>  8: (PK11_GetAllTokens()+0x1cc) [0x7f420e4cec5c]
>  9: (PK11_GetBestSlotMultipleWithAttributes()+0x23b) [0x7f420e4cf06b]
>  10: (PK11_GetBestSlot()+0x1f) [0x7f420e4cf0df]
>  11: (CryptoAES::get_key_handler(ceph::buffer::ptr const&,
> std::string&)+0x1f4) [0x7f42100d3484]
>  12: (CryptoKey::_set_secret(int, ceph::buffer::ptr const&)+0xcc)
> [0x7f42100d25fc]
>  13: (CryptoKey::decode(ceph::buffer::list::iterator&)+0xa2)
> [0x7f42100d2922]
>  14: (void decode_decrypt_enc_bl<CephXServiceTicket>(CephContext*,
> CephXServiceTicket&, CryptoKey, ceph::buffer::list&,
> std::string&)+0x4a5) [0x7f42100c0f05]
>  15: (int decode_decrypt<CephXServiceTicket>(CephContext*,
> CephXServiceTicket&, CryptoKey const&, ceph::buffer::list::iterator&,
> std::string&)+0x1cf) [0x7f42100c12df]
>  16: (CephXTicketHandler::verify_service_ticket_reply(CryptoKey&,
> ceph::buffer::list::iterator&)+0xdb) [0x7f42100bb5ab]
>  17: (CephXTicketManager::verify_service_ticket_reply(CryptoKey&,
> ceph::buffer::list::iterator&)+0x122) [0x7f42100bd442]
>  18: (CephxClientHandler::handle_response(int,
> ceph::buffer::list::iterator&)+0xef4) [0x7f421024a2b4]
>  19: (MonClient::handle_auth(MAuthReply*)+0xce) [0x7f421014589e]
>  20: (MonClient::ms_dispatch(Message*)+0x297) [0x7f4210147b27]
>  21: (DispatchQueue::entry()+0x63a) [0x7f421025683a]
>  22: (DispatchQueue::DispatchThread::entry()+0xd) [0x7f4210180ecd]
>  23: (()+0x8182) [0x7f420e7be182]
>  24: (clone()+0x6d) [0x7f420cb0547d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 
> Which is the same error reported 8 days ago
> http://tracker.ceph.com/issues/15628
> 
> 
> Here is the log of one of the down OSDs: http://pastebin.com/dcHKrE8f
> 
> Now we would like to downgrade to version 9.2.0 all nodes, since we keep
> on having osds down and sometimes OSDs with corrupted metadata. However,
> it looks like it is not possible to downgrade a Ceph version?

Our goal is to make downgrades within a stable series possible, but we 
have not tested them for infernalis.

There was one fix in the auth code that may affect this.  I pushed a 
branch that backports it to infernalis and pushed a wip-auth-infernalis 
branch. The packages should show up on gitbuilder.ceph.com in an hour or 
so.  Can you give those a try?

	http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/wip-auth-infernalis

We haven't seen this crash at all in any of our testing.  :(

> Besides that, we also have "wrong node!" messages on most of our osd
> logs (on both nodes with v9.2.1 and v9.2.0). We don't know if it is
> related, or if we should also have a look at that.
> 
> 2016-05-05 15:30:16.994946 7f7272cc3700  0 --
> [2a00:c6c0:0:120::201]:6893/5870 >> [2a00:c6c0:0:120::202]:6807/10502
> pipe(0x7f72cc272000 sd=24 :53006 s=1 pgs=309 cs=19 l=0
> c=0x7f72d23f31e0).connect claims to be [2a00:c6c0:0:120::202]:6807/4013
> not [2a00:c6c0:0:120::202]:6807/10502 - wrong node!

These are harmless--they're just there because OSDs are restarting and 
reusing some of the same ports.

sage


> 
> Thanks!
> 
> 
> 
> - -- 
> Ana Avilés
> Greenhost - sustainable hosting & digital security
> E: ana@greenhost.nl
> T: +31 20 4890444
> W: https://greenhost.nl
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJXLGxZAAoJEOUdSHwFo2bgT7IIAIMHE5x6Qhqn/nskuB1k2QJl
> NWC/nR0Cmlc5OSEoAHu1fZKMtnP8XAfH+zW+MO7xNpgDks5zCZ0oLXPo9hYndGNN
> yVgUMDcm7hw8saYiRumsEr84ER2Hsv7kMcAdEAFyt4IJ056WRUGduFBWmc6VkRx5
> OtOqmlHKpnX+BW8UPGoNXD6JjmAog38+rUszdkQmn1WpvG+aBx/plQlcZXNnfIMM
> mclsDzTkSO5LStVYSNaBfp7OpYiXwESVjz4X73ZnoTX61q0cOfL4W9Kvp+xeXfyV
> RkRhPLXuffrX9bV5HVRE4zpexXy781o2ugAh5ZwCFgGSJgkRJM+IxA6OAqSo+Kg=
> =sDhn
> -----END PGP SIGNATURE-----
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-574103004-1462538753=:15518--
