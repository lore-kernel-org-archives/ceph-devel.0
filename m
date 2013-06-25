From: Milosz Tanski <milosz@adfin.com>
Subject: Re: soft loockup in ceph_put_cap_refs
Date: Tue, 25 Jun 2013 17:15:35 -0400
Message-ID: <CANP1eJHGB-oTB6Vs9mYN11qFxd9rjGqqxsX_+piU3V8gkr4Y_g@mail.gmail.com>
References: <CANP1eJH0R0kw=E8BW24O2_x-GcEC3wO66v=EswyPbVD-QWXW3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57718 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab3FYVPg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 17:15:36 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so29247765iec.41
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jun 2013 14:15:36 -0700 (PDT)
In-Reply-To: <CANP1eJH0R0kw=E8BW24O2_x-GcEC3wO66v=EswyPbVD-QWXW3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After looking at my changes in git there's only one place I use the
lock and it's unlocked right away (without gotos). I'm going to
recompile with log debugging next and try to repro this.

- M

On Tue, Jun 25, 2013 at 4:47 PM, Milosz Tanski <milosz@adfin.com> wrote:
> Hey guys,
>
> I've ran into this issue with a soft lookup in the client when using
> the Ceph filesystem (trace bellow). I've ran into this twice so far on
> my cluster (separated by days) when my application is doing work
> (opening a new database segment).
>
> It's entirely possible this might be self inflicted with the fscache
> code I've been working on. I'm investigating what I could have done to
> cause it, but in the mean time I'd like to know if this looks familiar
> to any other bug?
>
> Thanks,
> - Milosz
>
> [2938098.374766] BUG: soft lockup - CPU#1 stuck for 23s! [petabucket:2257]
> [2938098.374778] Modules linked in: ceph libceph cachefiles
> ghash_clmulni_intel aesni_intel ablk_helper cryptd lrw gf128mul
> glue_helper aes_x86_64 microcode auth_rpcgss oid_registry nfsv4 nfs
> fscache lockd sunrpc raid10 raid456 async_pq async_xor async_memcpy
> async_raid6_recov async_tx raid1 multipath linear btrfs raid6_pq
> lzo_compress raid0 xor zlib_deflate lib
> crc32c
> [2938098.374803] CPU: 1 PID: 2257 Comm: petabucket Not tainted
> 3.10.0-rc6-virtual #9
> [2938098.374805] task: ffff880ecd68c4d0 ti: ffff880ecff2e000 task.ti:
> ffff880ecff2e000
> [2938098.374807] RIP: e030:[<ffffffff81553c42>]  [<ffffffff81553c42>]
> _raw_spin_lock+0x22/0x30
> [2938098.374816] RSP: e02b:ffff880ecff2fd88  EFLAGS: 00000202
> [2938098.374817] RAX: 0000000000000045 RBX: ffff880eaf68a530 RCX:
> 000000000001518e
> [2938098.374819] RDX: 0000000000000046 RSI: 0000000000000001 RDI:
> ffff880eaf68a540
> [2938098.374820] RBP: ffff880ecff2fd88 R08: 000000000001a490 R09:
> ffffea0039d01400
> [2938098.374822] R10: ffffffffa02bcc82 R11: 0000000000000000 R12:
> ffff880ed0254a70
> [2938098.374823] R13: 0000000000000000 R14: 0000000000000001 R15:
> ffff880ecb3dbc00
> [2938098.374828] FS:  00007f1231eba700(0000) GS:ffff880f1b420000(0000)
> knlGS:0000000000000000
> [2938098.374830] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
> [2938098.374832] CR2: 00007f1241bf0000 CR3: 0000000ecc3c2000 CR4:
> 0000000000002660
> [2938098.374833] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [2938098.374835] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [2938098.374836] Stack:
> [2938098.374837]  ffff880ecff2fdb8 ffffffffa02ee92c ffff880ed0254800
> ffff880ed0254a70
> [2938098.374840]  0000000000000000 0000000000000155 ffff880ecff2fdd8
> ffffffffa02f40eb
> [2938098.374843]  ffff880eaf68a848 ffff880ed0254800 ffff880ecff2fe18
> ffffffffa02e410c
> [2938098.374847] Call Trace:
> [2938098.374856]  [<ffffffffa02ee92c>] ceph_put_cap_refs+0x2c/0x1c0 [ceph]
> [2938098.374861]  [<ffffffffa02f40eb>]
> ceph_mdsc_release_request+0x8b/0x190 [ceph]
> [2938098.374865]  [<ffffffffa02e410c>] ceph_do_getattr+0xfc/0x110 [ceph]
> [2938098.374869]  [<ffffffffa02e4144>] ceph_getattr+0x24/0x100 [ceph]
> [2938098.374874]  [<ffffffff81175a4d>] vfs_getattr+0x4d/0x80
> [2938098.374876]  [<ffffffff81175c9d>] vfs_fstat+0x3d/0x70
> [2938098.374879]  [<ffffffff81175ce5>] SYSC_newfstat+0x15/0x30
> [2938098.374883]  [<ffffffff8117beab>] ? putname+0x2b/0x40
> [2938098.374888]  [<ffffffff8116fc14>] ? do_sys_open+0x174/0x1e0
> [2938098.374890]  [<ffffffff81175d9e>] SyS_newfstat+0xe/0x10
> [2938098.374895]  [<ffffffff8155c559>] system_call_fastpath+0x16/0x1b
> [2938098.374896] Code: ff 48 89 d0 5d c3 0f 1f 00 66 66 66 66 90 55 48
> 89 e5 b8 00 01 00 00 f0 66 0f c1 07 0f b6 d4 38 c2 74 0f 66 0f 1f 44
> 00 00 f3 90 <0f> b6 07 38 c2 75 f7 5d c3 0f 1f 44 00 00 66 66 66 66 90
> 55 48
