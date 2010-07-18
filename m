From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Block Allocation Reservation Windows Map (ext3_try_to_allocate_with_rsv)
Date: Sun, 18 Jul 2010 21:49:53 +0200
Message-ID: <AANLkTinpD-keOw0N2HXIDqb9rm0GG797NzXmPTE4381y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44134 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab0GRTtz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jul 2010 15:49:55 -0400
Received: by wyb42 with SMTP id 42so3731716wyb.19
        for <ceph-devel@vger.kernel.org>; Sun, 18 Jul 2010 12:49:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'm reproducibly facing the the following panic, server side, when
trying to cp -a /usr /mnt/ceph/ from a quite decent client onto a very
low end server (an atom nettop):

Jul 18 20:53:04 kernel: [  825.096369] kjournald starting.  Commit
interval 5 seconds
Jul 18 20:53:04 kernel: [  825.096843] EXT3 FS on sda8, internal journal
Jul 18 20:53:04 kernel: [  825.096853] EXT3-fs: mounted filesystem
with ordered data mode.
Jul 18 20:59:29 kernel: [ 1210.224202] Block Allocation Reservation
Windows Map (ext3_try_to_allocate_with_rsv):
Jul 18 20:59:29 kernel: [ 1210.224214] reservation window
0xffff880037b58958 start:  0, end:  0
Jul 18 20:59:29 kernel: [ 1210.224220] reservation window
0xffff8800378f2340 start:  25700771, end:  25700778
Jul 18 20:59:29 kernel: [ 1210.224226] reservation window
0xffff88006d34e380 start:  25700803, end:  25700810
Jul 18 20:59:29 kernel: [ 1210.224232] reservation window
0xffff8800378f2380 start:  25700811, end:  25700818
... (truncated, 1.9k "reservation window"-like lines) ...
Jul 18 20:59:29 kernel: [ 1210.253764] reservation window
0xffff88003796ff40 start:  30115046, end:  30115053
Jul 18 20:59:29 kernel: [ 1210.253772] reservation window
0xffff88006d0b64c0 start:  30115054, end:  30115061
Jul 18 20:59:29 kernel: [ 1210.253780] Window map complete.
Jul 18 20:59:29 kernel: [ 1210.254339] CPU 2
Jul 18 20:59:29 kernel: [ 1210.254468] Modules linked in: parport_pc
ppdev lp parport cpufreq_stats cpufreq_conservative cpufreq_userspace
cpufreq_powersave fuse lo
Jul 18 20:59:29 kernel: [ 1210.259400] Pid: 2199, comm: cosd Not
tainted 2.6.32-5-amd64 #1 To Be Filled By O.E.M.
Jul 18 20:59:29 kernel: [ 1210.259491] RIP: 0010:[<ffffffffa01c4332>]
[<ffffffffa01c4332>] ext3_try_to_allocate_with_rsv+0x4b1/0x5c1 [ext3]
Jul 18 20:59:29 kernel: [ 1210.259673] RSP: 0018:ffff8800376b59f8
EFLAGS: 00010246
Jul 18 20:59:29 kernel: [ 1210.259753] RAX: 0000000000000027 RBX:
0000000001c4037f RCX: 0000000000002b5b
Jul 18 20:59:29 kernel: [ 1210.259831] RDX: 0000000000000000 RSI:
0000000000000096 RDI: 0000000000000246
Jul 18 20:59:29 kernel: [ 1210.259906] RBP: ffff88006d0a5b80 R08:
ffff880037b58950 R09: ffffffff813a9526
Jul 18 20:59:29 kernel: [ 1210.259987] R10: 0000000000000000 R11:
00000000000186a0 R12: ffff88006d09b800
Jul 18 20:59:29 kernel: [ 1210.260067] R13: ffff880037b58800 R14:
00000000ffffffff R15: ffff88006d70f400
Jul 18 20:59:29 kernel: [ 1210.260150] FS:  00007fb45ac58710(0000)
GS:ffff880001900000(0000) knlGS:0000000000000000
Jul 18 20:59:29 kernel: [ 1210.260241] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul 18 20:59:29 kernel: [ 1210.260323] CR2: 00007fb44f5f4000 CR3:
0000000037bf6000 CR4: 00000000000006e0
Jul 18 20:59:29 kernel: [ 1210.260404] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Jul 18 20:59:29 kernel: [ 1210.260485] DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000400
Jul 18 20:59:29 kernel: [ 1210.260572] Process cosd (pid: 2199,
threadinfo ffff8800376b4000, task ffff88006e618710)
Jul 18 20:59:29 kernel: [ 1210.260732]  ffff88006f76d6c0
01c4000000008000 0000000000000010 ffff880030ee6310
Jul 18 20:59:29 kernel: [ 1210.260986] <0> 000003886d70f400
ffff88006f76d6c0 0000000000000388 ffff88006d0a5ba0
Jul 18 20:59:29 kernel: [ 1210.261372] <0> 0000000001c40000
0000000001c47fff ffff880037b58948 000000106ba9d100
Jul 18 20:59:29 kernel: [ 1210.261916]  [<ffffffffa01c4650>] ?
ext3_new_blocks+0x20e/0x5e6 [ext3]
Jul 18 20:59:29 kernel: [ 1210.262018]  [<ffffffffa01c4a45>] ?
ext3_new_block+0x1d/0x24 [ext3]
Jul 18 20:59:29 kernel: [ 1210.262118]  [<ffffffffa01d426d>] ?
ext3_xattr_block_set+0x522/0x6ec [ext3]
Jul 18 20:59:29 kernel: [ 1210.262218]  [<ffffffffa01d4713>] ?
ext3_xattr_set_handle+0x2dc/0x44c [ext3]
Jul 18 20:59:29 kernel: [ 1210.262309]  [<ffffffff8103a417>] ?
enqueue_task+0x5c/0x65
Jul 18 20:59:29 kernel: [ 1210.262399]  [<ffffffffa01d4904>] ?
ext3_xattr_set+0x81/0xc9 [ext3]
Jul 18 20:59:29 kernel: [ 1210.262488]  [<ffffffff81105afc>] ?
__vfs_setxattr_noperm+0x3d/0xb1
Jul 18 20:59:29 kernel: [ 1210.262571]  [<ffffffff81105be4>] ?
vfs_setxattr+0x74/0x8c
Jul 18 20:59:29 kernel: [ 1210.262655]  [<ffffffff81105ca3>] ?
setxattr+0xa7/0xdc
Jul 18 20:59:29 kernel: [ 1210.262741]  [<ffffffff81102781>] ?
mntput_no_expire+0x23/0xee
Jul 18 20:59:29 kernel: [ 1210.262827]  [<ffffffff810e4f09>] ?
virt_to_head_page+0x9/0x2a
Jul 18 20:59:29 kernel: [ 1210.262913]  [<ffffffff810f8e1c>] ?
user_path_at+0x52/0x79
Jul 18 20:59:29 kernel: [ 1210.262998]  [<ffffffff810f838a>] ?
getname+0x23/0x1a0
Jul 18 20:59:29 kernel: [ 1210.263084]  [<ffffffff81073b79>] ?
sys_futex+0x113/0x131
Jul 18 20:59:29 kernel: [ 1210.263169]  [<ffffffff81105e2d>] ?
sys_setxattr+0x59/0x80
Jul 18 20:59:29 kernel: [ 1210.263261]  [<ffffffff81010b42>] ?
system_call_fastpath+0x16/0x1b
Jul 18 20:59:29 kernel: [ 1210.267351]  RSP <ffff8800376b59f8>
Jul 18 20:59:29 kernel: [ 1210.267436] ---[ end trace db503f602ea8578f ]---

It may actually not be directly related to ceph, I however have to
admit I never got this one in other situation on my stock Debian
kernel (and the multiple blocks allocation patch should be at least as
old as the 2.6.16 iirc).

I've also found this post describing an equivalent situation:
http://www.linuxquestions.org/questions/linux-general-1/alternative-to-nfs-602712/page2.html
(middle of page).

I don't know how (or even if) it's related but I'm simultaneously (and
regularly) getting a "mds laggy or crashed" messages during the test
(laggy seems to be the correct answer). I do however also got this
very message when using btrfs, with a better end;)

Sebastien


10.07.18_20:59:04.093645    pg v43: 264 pgs: 264
active+clean+degraded; 1429 MB data, 1725 MB used, 117 GB / 125 GB
avail; 16614/33228 degraded (50.000%)
10.07.18_20:59:08.348394   mds e13: 1/1/1 up {0=up:active(laggy or crashed)}
10.07.18_20:59:09.376428    pg v44: 264 pgs: 264
active+clean+degraded; 1661 MB data, 1963 MB used, 117 GB / 125 GB
avail; 17294/34588 degraded (50.000%)
10.07.18_20:59:10.687956   mds e14: 1/1/1 up {0=up:active}
10.07.18_20:59:11.707158   log 10.07.18_20:59:10.687549 mon0
192.168.0.3:6789/0 9 : [INF] mds0 192.168.0.3:6802/2217 up:active
10.07.18_20:59:12.493888    pg v45: 264 pgs: 264
active+clean+degraded; 1682 MB data, 1983 MB used, 117 GB / 125 GB
avail; 17301/34602 degraded (50.000%)
10.07.18_20:59:17.498511    pg v46: 264 pgs: 264
active+clean+degraded; 1689 MB data, 1989 MB used, 117 GB / 125 GB
avail; 17304/34608 degraded (50.000%)
10.07.18_20:59:22.498215    pg v47: 264 pgs: 264
active+clean+degraded; 1703 MB data, 2004 MB used, 117 GB / 125 GB
avail; 17312/34624 degraded (50.000%)
10.07.18_20:59:28.037937    pg v48: 264 pgs: 264
active+clean+degraded; 1743 MB data, 2044 MB used, 117 GB / 125 GB
avail; 17343/34686 degraded (50.000%)

Message from syslogd at Jul 18 20:59:29 ...
 kernel:[ 1210.253874] ------------[ cut here ]------------

Message from syslogd at Jul 18 20:59:29 ...
 kernel:[ 1210.254053] invalid opcode: 0000 [#1] SMP

Message from syslogd at Jul 18 20:59:29 ...
 kernel:[ 1210.254240] last sysfs file:
/sys/devices/pci0000:00/0000:00:0b.0/host2/target2:0:0/2:0:0:0/block/sda/removable

Message from syslogd at Jul 18 20:59:29 ...
 kernel:[ 1210.260661] Stack:

Message from syslogd at Jul 18 20:59:29 ...
 kernel:[ 1210.261813] Call Trace:

Message from syslogd at Jul 18 20:59:29 ...
 kernel:[ 1210.263342] Code: 0b 48 8b 44 24 40 48 39 45 28 73 23 49 8b
bf 90 02 00 00 48 c7 c2 00 5b 1d a0 be 01 00 00 00 48 81 c7 50 01 00
00 e8 cd f0 ff ff <0f> 0b eb fe 48 8b 54 24 38 48 8b 4c 24 18 4c 8d 8c
24 80 00 00
10.07.18_20:59:32.539932    pg v49: 264 pgs: 264
active+clean+degraded; 1783 MB data, 2086 MB used, 117 GB / 125 GB
avail; 17450/34900 degraded (50.000%)
