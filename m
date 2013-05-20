From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: General Protection Fault in 3.8.5
Date: Mon, 20 May 2013 11:45:04 -0400
Message-ID: <CACkq2moyYMFRUEShMQffnC3tPxaagH5j8quy5q5bJeappV4oyQ@mail.gmail.com>
References: <CACkq2mpBF4pPmBox4uNv5xcd1aO5cyMviBruFHrij6ourByj9g@mail.gmail.com>
 <alpine.DEB.2.00.1305061952350.11520@cobra.newdream.net> <CACkq2mp34xJhGVN747uYzMyKZ+wk7wsTxFDzJdk06ssWg=0Bmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:50675 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab3ETPp0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 May 2013 11:45:26 -0400
Received: by mail-bk0-f45.google.com with SMTP id je2so372881bkc.18
        for <ceph-devel@vger.kernel.org>; Mon, 20 May 2013 08:45:24 -0700 (PDT)
In-Reply-To: <CACkq2mp34xJhGVN747uYzMyKZ+wk7wsTxFDzJdk06ssWg=0Bmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,

Did a patch for the auth code get submitted for the 3.8 kernel?  I hit
this again over the weekend.  Looks slightly different than the last
one, but still in the auth code.

May 18 13:26:15 nfs1 kernel: [999560.730733] BUG: unable to handle
kernel paging request at ffff880640000000
May 18 13:26:15 nfs1 kernel: [999560.737818] IP: [<ffffffff8135ca9d>]
memcpy+0xd/0x110
May 18 13:26:15 nfs1 kernel: [999560.742974] PGD 1c0e063 PUD 0
May 18 13:26:15 nfs1 kernel: [999560.746150] Oops: 0000 [#1] SMP
May 18 13:26:15 nfs1 kernel: [999560.749498] Modules linked in: btrfs
zlib_deflate ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs reiserfs
ext2 rbd libceph libcrc32c nfsd nfs_acl auth_rpcgss nfs fscache lockd
coretemp sunrpc kvm gpio_ich psmouse microcode serio_raw i7core_edac
ioatdma lpc_ich edac_core ipmi_si mac_hid ipmi_devintf ipmi_msghandler
bonding lp parport tcp_bic raid10 raid456 async_pq async_xor xor
async_memcpy async_raid6_recov hid_generic usbhid hid raid6_pq
async_tx igb ahci myri10ge raid1 ptp libahci raid0 dca pps_core
multipath linear
May 18 13:26:15 nfs1 kernel: [999560.796421] CPU 0
May 18 13:26:15 nfs1 kernel: [999560.798353] Pid: 26234, comm:
kworker/0:0 Not tainted 3.8.5-030805-generic #201303281651 Penguin
Computing Relion 1751/X8DTU
May 18 13:26:15 nfs1 kernel: [999560.809827] RIP:
0010:[<ffffffff8135ca9d>]  [<ffffffff8135ca9d>] memcpy+0xd/0x110
May 18 13:26:15 nfs1 kernel: [999560.817403] RSP:
0018:ffff88062dc3dc40  EFLAGS: 00010246
May 18 13:26:15 nfs1 kernel: [999560.822794] RAX: ffffc90017f4301a
RBX: ffff880323ba4300 RCX: 1ffff100c2f035b2
May 18 13:26:15 nfs1 kernel: [999560.830003] RDX: 0000000000000000
RSI: ffff880640000000 RDI: ffffc9002c335952
May 18 13:26:15 nfs1 kernel: [999560.837209] RBP: ffff88062dc3dc98
R08: ffffc90043b52000 R09: ffff88062dc3dad4
May 18 13:26:15 nfs1 kernel: [999560.844417] R10: ffff88027a45f0e8
R11: ffff88033fffbec0 R12: ffffc90017f4301a
May 18 13:26:15 nfs1 kernel: [999560.851626] R13: 000000002bc0d708
R14: ffff880628407120 R15: 000000002bc0d6c8
May 18 13:26:15 nfs1 kernel: [999560.858834] FS:
0000000000000000(0000) GS:ffff880333c00000(0000)
knlGS:0000000000000000
May 18 13:26:15 nfs1 kernel: [999560.867000] CS:  0010 DS: 0000 ES:
0000 CR0: 000000008005003b
May 18 13:26:15 nfs1 kernel: [999560.872824] CR2: ffff880640000000
CR3: 0000000001c0d000 CR4: 00000000000007f0
May 18 13:26:15 nfs1 kernel: [999560.880032] DR0: 0000000000000000
DR1: 0000000000000000 DR2: 0000000000000000
May 18 13:26:15 nfs1 kernel: [999560.887239] DR3: 0000000000000000
DR6: 00000000ffff0ff0 DR7: 0000000000000400
May 18 13:26:15 nfs1 kernel: [999560.894446] Process kworker/0:0 (pid:
26234, threadinfo ffff88062dc3c000, task ffff88032d8845c0)
May 18 13:26:15 nfs1 kernel: [999560.903298] Stack:
May 18 13:26:15 nfs1 kernel: [999560.905399]  ffffffffa0368a54
ffffffffa035b60d 2bc0d6c8a0368d12 0000000000000098
May 18 13:26:15 nfs1 kernel: [999560.912942]  00000000000000c0
ffffffffa03687bc ffff880323ba4300 ffff880322fec4d8
May 18 13:26:15 nfs1 kernel: [999560.920471]  ffff880628407120
ffff88032bdf5c40 ffff880322fec420 ffff88062dc3dcd8
May 18 13:26:15 nfs1 kernel: [999560.928016] Call Trace:
May 18 13:26:15 nfs1 kernel: [999560.930561]  [<ffffffffa0368a54>] ?
ceph_x_build_authorizer.isra.6+0x144/0x1e0 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.938727]  [<ffffffffa035b60d>] ?
ceph_buffer_release+0x2d/0x50 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.945761]  [<ffffffffa03687bc>] ?
ceph_x_destroy_authorizer+0x2c/0x40 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.953315]  [<ffffffffa0368d2e>]
ceph_x_create_authorizer+0x6e/0xd0 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.960609]  [<ffffffffa035db49>]
get_authorizer+0x89/0xc0 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.967035]  [<ffffffffa0357704>]
prepare_write_connect+0xb4/0x210 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.974161]  [<ffffffffa035b2a5>]
try_read+0x3d5/0x430 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.980249]  [<ffffffffa035b38f>]
con_work+0x8f/0x140 [libceph]
May 18 13:26:15 nfs1 kernel: [999560.986242]  [<ffffffff81078c31>]
process_one_work+0x141/0x490
May 18 13:26:15 nfs1 kernel: [999560.992153]  [<ffffffff81079b08>]
worker_thread+0x168/0x400
May 18 13:26:15 nfs1 kernel: [999560.997800]  [<ffffffff810799a0>] ?
manage_workers+0x120/0x120
May 18 13:26:15 nfs1 kernel: [999561.003713]  [<ffffffff8107eff0>]
kthread+0xc0/0xd0
May 18 13:26:15 nfs1 kernel: [999561.008669]  [<ffffffff8107ef30>] ?
flush_kthread_worker+0xb0/0xb0
May 18 13:26:15 nfs1 kernel: [999561.014927]  [<ffffffff816f532c>]
ret_from_fork+0x7c/0xb0
May 18 13:26:15 nfs1 kernel: [999561.020401]  [<ffffffff8107ef30>] ?
flush_kthread_worker+0xb0/0xb0
May 18 13:26:15 nfs1 kernel: [999561.026657] Code: 2b 43 50 88 43 4e
48 83 c4 08 5b 5d c3 90 e8 fb fd ff ff eb e6 90 90 90 90 90 90 90 90
90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 20
4c 8b 06 4c 8b 4e 08 4c 8b 56 10 4c
May 18 13:26:15 nfs1 kernel: [999561.046667] RIP  [<ffffffff8135ca9d>]
memcpy+0xd/0x110
May 18 13:26:15 nfs1 kernel: [999561.051903]  RSP <ffff88062dc3dc40>
May 18 13:26:15 nfs1 kernel: [999561.055477] CR2: ffff880640000000
May 18 13:26:15 nfs1 kernel: [999561.058894] ---[ end trace
2fa4f8a71fe96709 ]---

Thanks!

 - Travis

On Tue, May 7, 2013 at 10:54 AM, Travis Rhoden <trhoden@gmail.com> wrote:
> Thanks Sage, I'll monitor the 3.8 point releases and update when I see
> a release with those changes.
>
>  - Travis
>
> On Mon, May 6, 2013 at 10:54 PM, Sage Weil <sage@inktank.com> wrote:
>> On Mon, 6 May 2013, Travis Rhoden wrote:
>>> Hey folks,
>>>
>>> We have two servers that map a lot of RBDs (20 to 30 each so far),
>>> using the RBD kernel module.  They are running Ubuntu 12.10, and I
>>> originally saw a lot of kernel panics (obviously from Ceph) when
>>> running a 3.5.7 kernel.
>>>
>>> I upgrade a while back to a 3.8.5 kernel to get a much newer RBD
>>> module, and the kernel panics from Ceph went away...and were replaced
>>> by these nebulous "General Protection Faults" that I couldn't really
>>> tell what was causing them.
>>>
>>> Today we saw one that actually had a Ceph backtrace in it, so I wanted
>>> to throw it on here:
>>>
>>> May  6 23:02:58 nfs1 kernel: [295972.423165] general protection fault:
>>> 0000 [#3] SMP
>>> May  6 23:02:58 nfs1 kernel: [295972.428252] Modules linked in: rbd
>>> libceph libcrc32c coretemp nfsd kvm nfs_acl auth_rpcgss nfs fscache
>>> lockd sunrpc gpio_ich psmouse microcode serio_raw i7core_edac ipmi_si
>>> edac_core lpc_ich ioatdma ipmi_devintf mac_hid ipmi_msghandler bonding
>>> lp parport tcp_bic raid10 raid456 async_pq async_xor xor async_memcpy
>>> async_raid6_recov hid_generic raid6_pq usbhid async_tx hid igb raid1
>>> myri10ge raid0 ahci ptp libahci dca pps_core multipath linear
>>> May  6 23:02:58 nfs1 kernel: [295972.468114] CPU 17
>>> May  6 23:02:58 nfs1 kernel: [295972.470133] Pid: 15920, comm:
>>> kworker/17:2 Tainted: G      D      3.8.5-030805-generic #201303281651
>>> Penguin Computing Relion 1751/X8DTU
>>> May  6 23:02:58 nfs1 kernel: [295972.482635] RIP:
>>> 0010:[<ffffffff811851ff>]  [<ffffffff811851ff>]
>>> kmem_cache_alloc_trace+0x5f/0x140
>>> May  6 23:02:58 nfs1 kernel: [295972.491686] RSP:
>>> 0018:ffff880624cb1a98  EFLAGS: 00010202
>>> May  6 23:02:58 nfs1 kernel: [295972.497074] RAX: 0000000000000000
>>> RBX: ffff88032ddc46d0 RCX: 000000000003c867
>>> May  6 23:02:58 nfs1 kernel: [295972.504283] RDX: 000000000003c866
>>> RSI: 0000000000008050 RDI: 0000000000016c80
>>> May  6 23:02:58 nfs1 kernel: [295972.511490] RBP: ffff880624cb1ae8
>>> R08: ffff880333d76c80 R09: 0000000000000002
>>> May  6 23:02:58 nfs1 kernel: [295972.518697] R10: ffff88032ce40070
>>> R11: 000000000000000d R12: ffff880333802200
>>> May  6 23:02:58 nfs1 kernel: [295972.525906] R13: 2e0460b9275465f2
>>> R14: ffffffffa023901e R15: 0000000000008050
>>> May  6 23:02:58 nfs1 kernel: [295972.533113] FS:
>>> 0000000000000000(0000) GS:ffff880333d60000(0000)
>>> knlGS:0000000000000000
>>> May  6 23:02:58 nfs1 kernel: [295972.541274] CS:  0010 DS: 0000 ES:
>>> 0000 CR0: 000000008005003b
>>> May  6 23:02:58 nfs1 kernel: [295972.547095] CR2: 00007fbf9467f2b0
>>> CR3: 0000000001c0d000 CR4: 00000000000007e0
>>> May  6 23:02:58 nfs1 kernel: [295972.554305] DR0: 0000000000000000
>>> DR1: 0000000000000000 DR2: 0000000000000000
>>> May  6 23:02:58 nfs1 kernel: [295972.561512] DR3: 0000000000000000
>>> DR6: 00000000ffff0ff0 DR7: 0000000000000400
>>> May  6 23:02:58 nfs1 kernel: [295972.568720] Process kworker/17:2
>>> (pid: 15920, threadinfo ffff880624cb0000, task ffff88032b600000)
>>> May  6 23:02:58 nfs1 kernel: [295972.577656] Stack:
>>> May  6 23:02:58 nfs1 kernel: [295972.579756]  0000000000000000
>>> 0000000000000000 0000000000000060 0000000000000000
>>> May  6 23:02:58 nfs1 kernel: [295972.587292]  0000000000000000
>>> ffff88032ddc46d0 0000000000000004 ffff88032ddc46c0
>>> May  6 23:02:58 nfs1 kernel: [295972.594819]  ffff88032b432b30
>>> 0000000000000000 ffff880624cb1b28 ffffffffa023901e
>>> May  6 23:02:58 nfs1 kernel: [295972.602347] Call Trace:
>>> May  6 23:02:58 nfs1 kernel: [295972.604886]  [<ffffffffa023901e>]
>>> get_ticket_handler.isra.4+0x5e/0xc0 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.612271]  [<ffffffffa02394b4>]
>>> ceph_x_proc_ticket_reply+0x274/0x440 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.619740]  [<ffffffffa023973d>]
>>> ceph_x_handle_reply+0xbd/0x110 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.626696]  [<ffffffffa023765c>]
>>> ceph_handle_auth_reply+0x18c/0x200 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.633988]  [<ffffffffa022d590>]
>>> handle_auth_reply.isra.12+0xa0/0x230 [libceph]
>>
>> Ah, this is in the auth code.  There was a series of patches that fixed
>> the locking and a few other things that jsut went upstream for 3.10.  I'll
>> prepare some patches to backport those fixes to stable kernels (3.8 and
>> 3.4).  It could easily explain your crashes.
>>
>> Thanks!
>> sage
>>
>>
>>> May  6 23:02:58 nfs1 kernel: [295972.641457]  [<ffffffffa022e87d>]
>>> dispatch+0xbd/0x120 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.647450]  [<ffffffffa0228205>]
>>> process_message+0xa5/0xc0 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.653966]  [<ffffffffa022c1b1>]
>>> try_read+0x2e1/0x430 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.660048]  [<ffffffffa022c38f>]
>>> con_work+0x8f/0x140 [libceph]
>>> May  6 23:02:58 nfs1 kernel: [295972.666043]  [<ffffffff81078c31>]
>>> process_one_work+0x141/0x490
>>> May  6 23:02:58 nfs1 kernel: [295972.671952]  [<ffffffff81079b08>]
>>> worker_thread+0x168/0x400
>>> May  6 23:02:58 nfs1 kernel: [295972.677601]  [<ffffffff810799a0>] ?
>>> manage_workers+0x120/0x120
>>> May  6 23:02:58 nfs1 kernel: [295972.683513]  [<ffffffff8107eff0>]
>>> kthread+0xc0/0xd0
>>> May  6 23:02:58 nfs1 kernel: [295972.688469]  [<ffffffff8107ef30>] ?
>>> flush_kthread_worker+0xb0/0xb0
>>> May  6 23:02:58 nfs1 kernel: [295972.694726]  [<ffffffff816f532c>]
>>> ret_from_fork+0x7c/0xb0
>>> May  6 23:02:58 nfs1 kernel: [295972.700203]  [<ffffffff8107ef30>] ?
>>> flush_kthread_worker+0xb0/0xb0
>>> May  6 23:02:58 nfs1 kernel: [295972.706456] Code: 00 4d 8b 04 24 65
>>> 4c 03 04 25 08 dc 00 00 49 8b 50 08 4d 8b 28 4d 85 ed 0f 84 cf 00 00
>>> 00 49 63 44 24 20 49 8b 3c 24 48 8d 4a 01 <49> 8b 5c 05 00 4c 89 e8 65
>>> 48 0f c7 0f 0f 94 c0 84 c0 74 c2 49
>>> May  6 23:02:58 nfs1 kernel: [295972.726468] RIP  [<ffffffff811851ff>]
>>> kmem_cache_alloc_trace+0x5f/0x140
>>> May  6 23:02:58 nfs1 kernel: [295972.733182]  RSP <ffff880624cb1a98>
>>> May  6 23:02:58 nfs1 kernel: [295972.736838] ---[ end trace
>>> 20e9b6a1bb611aba ]---
>>>
>>> I'm not sure whether the problem started here or not.  I mentioned
>>> that the previous GPFs were nebulous -- one thing most of them have
>>> had in common is that it's almost always from nfsd (this one isn't --
>>> first and only time I've seen this one).  Howevever, I am using NFS to
>>> re-export some RBDs (to provide access to multiple clients) so Ceph is
>>> still in the picture on those.
>>>
>>> I know its not a lot to go on, but any advice would be appreciated.
>>>
>>>  - Travis
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
