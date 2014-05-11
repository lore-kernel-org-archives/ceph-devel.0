From: Alex Elder <elder@ieee.org>
Subject: Re: crash in rbd_img_request_create
Date: Sat, 10 May 2014 22:11:24 -0500
Message-ID: <536EEA5C.70503@ieee.org>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:44010 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaEKDLR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 May 2014 23:11:17 -0400
Received: by mail-ig0-f169.google.com with SMTP id hl10so3488207igb.4
        for <ceph-devel@vger.kernel.org>; Sat, 10 May 2014 20:11:16 -0700 (PDT)
In-Reply-To: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>, Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Thorwald Lundqvist <thorwald@jumpstarter.io>

On 05/10/2014 05:18 PM, Hannes Landeholm wrote:
> Hello,
>=20
> I have a development machine that I have been running stress tests on
> for a week as I'm trying to reproduce some hard to reproduce failures=
=2E
> I've mentioned the same machine previously in the thread "rbd unmap
> deadlock". I just now noticed that some processes had completely
> stalled. I looked in the system log and saw this crash about 9 hours
> ago:

Are you still running kernel rbd as a client of ceph
services running on the same physical machine?

I personally believe that scenario may be at risk of
deadlock in any case--we haven't taken great care to
avoid it in this case.

Anyway...

I can build v3.14.1 but I don't know what kernel configuration
you are using.  Knowing that could be helpful.  I built it using
a config I have though, and it's *possible* you crashed on
this line, in rbd_segment_name():
        ret =3D snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
                        rbd_dev->header.object_prefix, segment);
And if so, the only reason I can think that this failed is if
rbd_dev->header.object_prefix were null (or an otherwise bad
pointer value).  But at this point it's a lot of speculation.

Depending on what your stress tests were doing, I suppose it
could be that you unmapped an in-use rbd image and there was
some sort of insufficient locking.

Can you also give a little insight about what your stress
tests were doing?

Thanks.

					-Alex

> kernel: BUG: unable to handle kernel paging request at ffff87ff3fbcdc=
58
> kernel: IP: [<ffffffffa0357203>] rbd_img_request_fill+0x123/0x6d0 [rb=
d]
> kernel: PGD 0
> kernel: Oops: 0000 [#1] PREEMPT SMP
> kernel: Modules linked in: xt_recent xt_conntrack ipt_REJECT xt_limit
> xt_tcpudp iptable_filter veth ipt_MASQUERADE iptable_nat
> nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
> ip_tables x_tables cbc bridge stp llc coretemp x86_pkg_temp_thermal
> intel_powerclamp kvm_intel kvm cr
> kernel:  crc32c libcrc32c ext4 crc16 mbcache jbd2 sd_mod sr_mod cdrom
> crc_t10dif crct10dif_common atkbd libps2 ahci libahci libata ehci_pci
> xhci_hcd ehci_hcd scsi_mod usbcore usb_common i8042 serio
> kernel: CPU: 4 PID: 3015 Comm: mysqld Tainted: P           O 3.14.1-1=
-js #1
> kernel: Hardware name: ASUSTeK COMPUTER INC. RS100-E8-PI2/P9D-M
> Series, BIOS 0302 05/10/2013
> kernel: task: ffff88003f046220 ti: ffff88011d3d2000 task.ti: ffff8801=
1d3d2000
> kernel: RIP: 0010:[<ffffffffa0357203>]  [<ffffffffa0357203>]
> rbd_img_request_fill+0x123/0x6d0 [rbd]
> kernel: RSP: 0018:ffff88011d3d3ac0  EFLAGS: 00010286
> kernel: RAX: ffff87ff3fbcdc00 RBX: 0000000008814000 RCX: 00000000011b=
cf84
> kernel: RDX: ffffffffa035c867 RSI: 0000000000000065 RDI: ffff8800b338=
f000
> kernel: RBP: ffff88011d3d3b78 R08: 000000000001abe0 R09: ffffffffa035=
71e0
> kernel: R10: 772d736a2f73656e R11: 6e61682d637a762f R12: ffff8800b338=
f000
> kernel: R13: ffff88025609d100 R14: 0000000000000000 R15: 000000000000=
0001
> kernel: FS:  00007fffe17fb700(0000) GS:ffff88042fd00000(0000)
> knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: ffff87ff3fbcdc58 CR3: 0000000126e0e000 CR4: 000000000014=
07e0
> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000
> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000=
0400
> kernel: Stack:
> kernel:  ffff880128ad0d98 0000000000000000 000022011d3d3bb8 ffff87ff3=
fbcdc20
> kernel:  ffff87ff3fbcdcc8 ffff8803b6459c90 682d637a762fea80 000000000=
0000001
> kernel:  0000000000000000 ffff87ff3fbcdc00 ffff8803b6459c30 000000000=
0004000
> kernel: Call Trace:
> kernel:  [<ffffffffa03554d5>] ? rbd_img_request_create+0x155/0x220 [r=
bd]
> kernel:  [<ffffffff8125cab9>] ? blk_add_timer+0x19/0x20
> kernel:  [<ffffffffa035aa1d>] rbd_request_fn+0x1ed/0x330 [rbd]
> kernel:  [<ffffffff81252f13>] __blk_run_queue+0x33/0x40
> kernel:  [<ffffffff8127a4dd>] cfq_insert_request+0x34d/0x560
> kernel:  [<ffffffff8124fa1c>] __elv_add_request+0x1bc/0x300
> kernel:  [<ffffffff81256cd0>] blk_flush_plug_list+0x1d0/0x230
> kernel:  [<ffffffff812570a4>] blk_finish_plug+0x14/0x40
> kernel:  [<ffffffffa027fd6e>] ext4_writepages+0x48e/0xd50 [ext4]
> kernel:  [<ffffffff811417ae>] do_writepages+0x1e/0x40
> kernel:  [<ffffffff811363d9>] __filemap_fdatawrite_range+0x59/0x60
> kernel:  [<ffffffff811364da>] filemap_write_and_wait_range+0x2a/0x70
> kernel:  [<ffffffffa027749a>] ext4_sync_file+0xba/0x360 [ext4]
> kernel:  [<ffffffff811d50ce>] do_fsync+0x4e/0x80
> kernel:  [<ffffffff811d5350>] SyS_fsync+0x10/0x20
> kernel:  [<ffffffff814e66e9>] system_call_fastpath+0x16/0x1b
> kernel: Code: 00 00 00 e8 a0 25 e3 e0 48 85 c0 49 89 c4 0f 84 0c 04 0=
0
> 00 48 8b 45 90 48 8b 5d b0 48 c7 c2 67 c8 35 a0 be 65 00 00 00 4c 89
> e7 <0f> b6 48 58 48 d3 eb 83 78 18 02 48 89 c1 48 8b 49 50 48 c7 c0
> kernel: RIP  [<ffffffffa0357203>] rbd_img_request_fill+0x123/0x6d0 [r=
bd]
> kernel:  RSP <ffff88011d3d3ac0>
> kernel: CR2: ffff87ff3fbcdc58
> kernel: ---[ end trace bebc1d7ea3182129 ]---
>=20
> uname: Linux localhost 3.14.1-1-js #1 SMP PREEMPT Tue Apr 15 17:59:05
> CEST 2014 x86_64 GNU/Linux
>=20
> This is a "stock" Arch 3.14.1 kernel with no custom patches.
>=20
> For some reason the rest of the system still works fine but trying to
> clean up with SIGKILL makes the system full of unkillable deferred
> zombie processes.
>=20
> Ceph cluster looks fine, I ran a successful deep scrub as well. It
> still uses the same machine but it runs a new cluster now:
>=20
>     cluster 32c6af82-73ff-4ea8-9220-cd47c6976ecb
>      health HEALTH_WARN
>      monmap e1: 1 mons at {margarina=3D192.168.0.215:6789/0}, electio=
n
> epoch 1, quorum 0 margarina
>      osdmap e54: 2 osds: 2 up, 2 in
>       pgmap v62043: 492 pgs, 6 pools, 4240 MB data, 1182 objects
>             18810 MB used, 7083 GB / 7101 GB avail
>                  492 active+clean
>=20
> 2014-05-11 00:03:00.551688 mon.0 [INF] pgmap v62043: 492 pgs: 492
> active+clean; 4240 MB data, 18810 MB used, 7083 GB / 7101 GB avail
>=20
> Trying to unmap the related rbd volume goes horribly wrong. "rbd
> unmap" waits for a child process (wait4) with an empty cmdline that
> has deadlocked with the following stack:
>=20
> [<ffffffff811e83b3>] fsnotify_clear_marks_by_group_flags+0x33/0xb0
> [<ffffffff811e8443>] fsnotify_clear_marks_by_group+0x13/0x20
> [<ffffffff811e75c2>] fsnotify_destroy_group+0x12/0x50
> [<ffffffff811e96a2>] inotify_release+0x22/0x50
> [<ffffffff811a811c>] __fput+0x9c/0x220
> [<ffffffff811a82ee>] ____fput+0xe/0x10
> [<ffffffff810848ec>] task_work_run+0xbc/0xe0
> [<ffffffff81067556>] do_exit+0x2a6/0xa70
> [<ffffffff814df85b>] oops_end+0x9b/0xe0
> [<ffffffff814d5f8a>] no_context+0x296/0x2a3
> [<ffffffff814d601d>] __bad_area_nosemaphore+0x86/0x1dc
> [<ffffffff814d6186>] bad_area_nosemaphore+0x13/0x15
> [<ffffffff814e1e4e>] __do_page_fault+0x3ce/0x5a0
> [<ffffffff814e2042>] do_page_fault+0x22/0x30
> [<ffffffff814ded38>] page_fault+0x28/0x30
> [<ffffffff811ea249>] SyS_inotify_add_watch+0x219/0x360
> [<ffffffff814e66e9>] system_call_fastpath+0x16/0x1b
> [<ffffffffffffffff>] 0xffffffffffffffff
>=20
> As before rbd likely still doesn't contain any debug symbols as we
> haven't recompiled anything yet. I should really get that done. I
> could double check though if that would really, really help you.
>=20
> I will probably hard reboot this machine soon so I can continue my
> stress tests so if you want me to pull out some other data from the
> run time state you should reply immediately.
>=20
> Thank you for your time,
> --
> Hannes Landeholm
> Co-founder & CTO
> Jumpstarter - www.jumpstarter.io
>=20
> =E2=98=8E +46 72 301 35 62
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
