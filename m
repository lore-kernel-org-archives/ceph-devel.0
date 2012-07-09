From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Mon, 09 Jul 2012 18:54:18 +0200
Message-ID: <4FFB0CBA.6090806@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr> <4FF77FE8.9040408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:54839 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752418Ab2GIQyY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:54:24 -0400
In-Reply-To: <4FF77FE8.9040408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Le 07/07/2012 02:16, Alex Elder a =E9crit :

[...]
> There are a number of bugs that have been fixed since Linux 3.4,
> and the fixes have not made it into the 3.4.y stable releases.
>
> I just sent an announcement about the Ceph stable branch that's
> available in the Ceph git repository.  If possible I would
> recommend you try using that for 3.4 testing.  The branch is here:
>
>      http://github.com/ceph/ceph-client/tree/linux-3.4.4-ceph

Ok. I've compiled the kernel this afternoon, and tested it without much=
=20
success :

Jul  9 18:17:23 label5.u14.univ-nantes.prive kernel: [  284.116236]=20
libceph: osd0 172.20.14.130:6801 socket closed
Jul  9 18:17:43 label5.u14.univ-nantes.prive kernel: [  304.101545]=20
libceph: osd6 172.20.14.137:6800 socket closed
Jul  9 18:17:53 label5.u14.univ-nantes.prive kernel: [  314.095155]=20
libceph: osd3 172.20.14.134:6800 socket closed
Jul  9 18:18:38 label5.u14.univ-nantes.prive kernel: [  359.075473]=20
libceph: osd5 172.20.14.136:6800 socket closed
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.107334]=20
libceph: osd6 172.20.14.137:6800 socket closed
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.121001] BUG=
:=20
unable to handle kernel NULL pointer dereference at 0000000000000048
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.121184] IP:=
=20
[<ffffffffa0822940>] con_work+0xfb0/0x20e0 [libceph]
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.121307] PGD=
=20
a122d4067 PUD a11753067 PMD 0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.121512]=20
Oops: 0000 [#1] SMP
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.121670] CPU=
 0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.121721]=20
Modules linked in: ext4 jbd2 crc16 rbd libceph drbd lru_cache cn=20
ip6table_filter ip6_tables iptable_filter ip_tables x_tables bridge stp=
=20
dlm sctp nfsd nfs lockd fscache auth_rpcgss nfs_acl sunrpc ocfs2_dlmfs=20
ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs=20
ipv6 fuse ext2 mbcache dm_round_robin dm_multipath scsi_dh snd_pcm=20
snd_timer snd ioatdma soundcore coretemp dcdbas i7core_edac edac_core=20
snd_page_alloc iTCO_wdt crc32c_intel dca processor joydev pcspkr hed=20
evdev button microcode thermal_sys xfs exportfs btrfs zlib_deflate=20
dm_mod sd_mod usbhid hid ata_generic ata_piix libata uhci_hcd mptsas=20
mptscsih ide_pci_generic mptbase ide_core scsi_transport_sas lpfc bnx2x=
=20
ehci_hcd scsi_transport_fc scsi_tgt crc32c scsi_mod libcrc32c bnx2 mdio=
=20
[last unloaded: scsi_wait_scan]
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126062]
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126127] Pid=
:=20
15886, comm: kworker/0:3 Not tainted 3.4.4-dsiun-120521+ #1 Dell Inc.=20
PowerEdge M610/0V56FN
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126351] RIP=
:=20
0010:[<ffffffffa0822940>]  [<ffffffffa0822940>] con_work+0xfb0/0x20e0=20
[libceph]
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126491] RSP=
:=20
0000:ffff880a08fa5d50  EFLAGS: 00010246
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126560] RAX=
:=20
0000000000000000 RBX: 0000000000000000 RCX: 0000000000020000
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126633] RDX=
:=20
0000000000000000 RSI: ffff880a0d9854a0 RDI: ffff880a0d985498
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126707] RBP=
:=20
0000000000080000 R08: 0000000000000020 R09: 0000000000000000
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126779] R10=
:=20
0000000000000029 R11: ffff880509d30808 R12: 0000000000000001
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126852] R13=
:=20
ffff880a0d985400 R14: ffffea0014151f00 R15: ffff880a12ffa830
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.126925] FS:=
 =20
0000000000000000(0000) GS:ffff880a2fc00000(0000) knlGS:0000000000000000
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127014] CS:=
 =20
0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127084] CR2=
:=20
0000000000000048 CR3: 0000000a0d275000 CR4: 00000000000007f0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127157] DR0=
:=20
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127229] DR3=
:=20
0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127302]=20
Process kworker/0:3 (pid: 15886, threadinfo ffff880a08fa4000, task=20
ffff880a07960000)
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127391] Sta=
ck:
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127454]=20
0000000200000000 ffff880a08fa5dfc 0000000000000400 ffffffff00000000
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127721]=20
ffff880a08fa5dd8 0000000000080000 ffff880a00080000 ffff880a00000000
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.127990]=20
ffff880a12ffac20 ffff880a0d9854a0 ffff880a12ffab08 ffff880a12ffa9a8
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.128260] Cal=
l=20
Trace:
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.128335]=20
[<ffffffff810534d2>] ? process_one_work+0x122/0x3f0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.128412]=20
[<ffffffffa0821990>] ? ceph_con_revoke_message+0xc0/0xc0 [libceph]
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.128503]=20
[<ffffffff81054c65>] ? worker_thread+0x125/0x2e0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.128576]=20
[<ffffffff81054b40>] ? manage_workers.isra.25+0x1f0/0x1f0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.129863]=20
[<ffffffff81059b85>] ? kthread+0x85/0x90
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.129938]=20
[<ffffffff813baee4>] ? kernel_thread_helper+0x4/0x10
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.130012]=20
[<ffffffff81059b00>] ? flush_kthread_worker+0x80/0x80
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.130085]=20
[<ffffffff813baee0>] ? gs_change+0x13/0x13
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.130154]=20
Code: ea f4 ff ff 0f 1f 80 00 00 00 00 49 83 bd 90 00 00 00 00 0f 84 ca=
=20
03 00 00 49 63 85 a0 00 00 00 49 8b 95 98 00 00 00 48 c1 e0 04 <48> 03=20
42 48 4c 8b 30 44 8b 48 0c 8b 70 08 e9 32 fc ff ff 31 c0
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.133172] RIP=
 =20
[<ffffffffa0822940>] con_work+0xfb0/0x20e0 [libceph]
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.133297] RSP=
=20
<ffff880a08fa5d50>
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.133363] CR2=
:=20
0000000000000048
Jul  9 18:19:48 label5.u14.univ-nantes.prive kernel: [  429.133526] ---=
[=20
end trace 00282dc1efb5b115 ]---
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.133654] BUG=
:=20
unable to handle kernel paging request at fffffffffffffff8
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.133817] IP:=
=20
[<ffffffff81059d27>] kthread_data+0x7/0x10
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.133938] PGD=
=20
14fe067 PUD 14ff067 PMD 0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.134141]=20
Oops: 0000 [#2] SMP
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.134294] CPU=
 0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.134341]=20
Modules linked in: ext4 jbd2 crc16 rbd libceph drbd lru_cache cn=20
ip6table_filter ip6_tables iptable_filter ip_tables x_tables bridge stp=
=20
dlm sctp nfsd nfs lockd fscache auth_rpcgss nfs_acl sunrpc ocfs2_dlmfs=20
ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs=20
ipv6 fuse ext2 mbcache dm_round_robin dm_multipath scsi_dh snd_pcm=20
snd_timer snd ioatdma soundcore coretemp dcdbas i7core_edac edac_core=20
snd_page_alloc iTCO_wdt crc32c_intel dca processor joydev pcspkr hed=20
evdev button microcode thermal_sys xfs exportfs btrfs zlib_deflate=20
dm_mod sd_mod usbhid hid ata_generic ata_piix libata uhci_hcd mptsas=20
mptscsih ide_pci_generic mptbase ide_core scsi_transport_sas lpfc bnx2x=
=20
ehci_hcd scsi_transport_fc scsi_tgt crc32c scsi_mod libcrc32c bnx2 mdio=
=20
[last unloaded: scsi_wait_scan]
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.138608]
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.138673] Pid=
:=20
15886, comm: kworker/0:3 Tainted: G      D 3.4.4-dsiun-120521+ #1 Dell=20
Inc. PowerEdge M610/0V56FN
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.138903] RIP=
:=20
0010:[<ffffffff81059d27>]  [<ffffffff81059d27>] kthread_data+0x7/0x10
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139041] RSP=
:=20
0000:ffff880a08fa5a30  EFLAGS: 00010002
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139110] RAX=
:=20
0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139182] RDX=
:=20
ffffffff8164a380 RSI: 0000000000000000 RDI: ffff880a07960000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139254] RBP=
:=20
ffff880a07960000 R08: 0000000000989680 R09: ffffffff8164a380
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139325] R10=
:=20
0000000000000400 R11: 0000000000000000 R12: ffff880a2fc120c0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139397] R13=
:=20
0000000000000000 R14: ffff880a0795fff0 R15: ffff880a07960000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139470] FS:=
 =20
0000000000000000(0000) GS:ffff880a2fc00000(0000) knlGS:0000000000000000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139557] CS:=
 =20
0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139627] CR2=
:=20
fffffffffffffff8 CR3: 0000000a0d275000 CR4: 00000000000007f0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139700] DR0=
:=20
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139773] DR3=
:=20
0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139847]=20
Process kworker/0:3 (pid: 15886, threadinfo ffff880a08fa4000, task=20
ffff880a07960000)
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.139937] Sta=
ck:
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.140000]=20
ffffffff81055ae8 ffff880a079602d0 ffffffff813b807d ffff880a07960000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.140266]=20
ffff880a07960000 ffff880a08fa5fd8 ffff880a08fa5fd8 ffff880a08fa5fd8
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.140530]=20
ffff880a07960000 ffff880a07960000 ffff880a079604e4 0000000000000000
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.140795] Cal=
l=20
Trace:
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.140865]=20
[<ffffffff81055ae8>] ? wq_worker_sleeping+0x8/0x90
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.140943]=20
[<ffffffff813b807d>] ? __schedule+0x41d/0x6c0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141019]=20
[<ffffffff8103e2a2>] ? do_exit+0x592/0x8c0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141093]=20
[<ffffffff81006068>] ? oops_end+0x98/0xe0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141166]=20
[<ffffffff813b0f96>] ? no_context+0x24e/0x279
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141240]=20
[<ffffffff8102e31b>] ? do_page_fault+0x3ab/0x460
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141314]=20
[<ffffffff8135677b>] ? tcp_established_options+0x3b/0xd0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141387]=20
[<ffffffff813589aa>] ? tcp_write_xmit+0x15a/0xac0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141460]=20
[<ffffffff813b9179>] ? _raw_spin_lock_bh+0x9/0x30
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141535]=20
[<ffffffff812f9a79>] ? release_sock+0x19/0x100
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141606]=20
[<ffffffff8134af43>] ? tcp_sendpage+0xf3/0x700
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141677]=20
[<ffffffff813b94f5>] ? page_fault+0x25/0x30
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141754]=20
[<ffffffffa0822940>] ? con_work+0xfb0/0x20e0 [libceph]
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141828]=20
[<ffffffff810534d2>] ? process_one_work+0x122/0x3f0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141901]=20
[<ffffffffa0821990>] ? ceph_con_revoke_message+0xc0/0xc0 [libceph]
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.141991]=20
[<ffffffff81054c65>] ? worker_thread+0x125/0x2e0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.142062]=20
[<ffffffff81054b40>] ? manage_workers.isra.25+0x1f0/0x1f0
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.142135]=20
[<ffffffff81059b85>] ? kthread+0x85/0x90
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.142207]=20
[<ffffffff813baee4>] ? kernel_thread_helper+0x4/0x10
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.142281]=20
[<ffffffff81059b00>] ? flush_kthread_worker+0x80/0x80
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.142354]=20
[<ffffffff813baee0>] ? gs_change+0x13/0x13
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.142423]=20
Code: fe ff ff 90 eb 90 be 57 01 00 00 48 c7 c7 9c 70 47 81 e8 cd 00 fe=
=20
ff e9 94 fe ff ff 0f 1f 84 00 00 00 00 00 48 8b 87 78 02 00 00 <48> 8b=20
40 f8 c3 0f 1f 40 00 48 3b 3d b1 05 5f 00 74 0f 65 8b 04
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.145429] RIP=
 =20
[<ffffffff81059d27>] kthread_data+0x7/0x10
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.145549] RSP=
=20
<ffff880a08fa5a30>
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.145615] CR2=
:=20
fffffffffffffff8
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.145682] ---=
[=20
end trace 00282dc1efb5b116 ]---
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  429.145764]=20
=46ixing recursive fault but reboot is needed!
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  489.120508]=20
INFO: rcu_sched detected stalls on CPUs/tasks: { 0} (detected by 5,=20
t=3D6002 jiffies)
Jul  9 18:20:48 label5.u14.univ-nantes.prive kernel: [  489.120772]=20
INFO: Stall ended before state dump start

>
> If you do have troubles I would very much like to hear about it.
> And if you don't run into the problems you've been seeing that
> would be good to know as well.

As the error is the same than plain 3.4.4,
I just doubled-checked to see If I don't mess with an older kernel but=20
as far as I can tell, it's the good kernel .

root@label5:/usr/src/GIT/ceph-client# uname -a
Linux label5 3.4.4-dsiun-120521+ #1 SMP Mon Jul 9 17:23:49 CEST 2012=20
x86_64 GNU/Linux


root@label5:~# modinfo libceph
filename: /lib/modules/3.4.4-dsiun-120521+/kernel/net/ceph/libceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
depends:        libcrc32c
intree:         Y
vermagic:       3.4.4-dsiun-120521+ SMP mod_unload modversions
root@label5:~# modinfo ceph
filename: /lib/modules/3.4.4-dsiun-120521+/kernel/fs/ceph/ceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
depends:        libceph
intree:         Y
vermagic:       3.4.4-dsiun-120521+ SMP mod_unload modversions


So maybe I messed with git ? for me the last commit in my local branch=20
(tracking remote branch linux-3.4.4-ceph from origin)
is that :

root@label5:/usr/src/GIT/ceph-client# git branch
   for-linus
* linux-3.4.4-ceph

root@label5:/usr/src/GIT/ceph-client# git log
commit c92a3ead0da1f13f5c971bba4eaa041ed22bb06e
Author: Sage Weil <sage@inktank.com>
Date:   Sun Jun 10 20:43:56 2012 -0700

=2E..

> 					-Alex
>
>> I'll launch realistic load on our ceph volume this week end (bacula
>> backups). I'll see if 3.2.22 is solid.

At least a good news : as far as I can say, it is. backuping since=20
friday without problems on 3.2.22.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
