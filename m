From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: Block Allocation Reservation Windows Map (ext3_try_to_allocate_with_rsv)
Date: Tue, 20 Jul 2010 23:54:26 +0200
Message-ID: <AANLkTinYukqSuxvs0DNN3ohQfvSmg-likYd7QsM8K-wA@mail.gmail.com>
References: <AANLkTinpD-keOw0N2HXIDqb9rm0GG797NzXmPTE4381y@mail.gmail.com>
	<Pine.LNX.4.64.1007190949300.996@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55652 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab0GTVy2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jul 2010 17:54:28 -0400
Received: by ewy23 with SMTP id 23so1986846ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jul 2010 14:54:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1007190949300.996@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello Sage,

I alas confirm that it does still happen on a 2.6.35-rc (Debian build).

That's not a domain I'm very familiar with, I just had quick look at
fs/ext3/balloc.c which seems to incriminate windows that overlap with
immediate neighbors (__rsv_window_dump). I've however checked the
traces and it seems to not be the case. FYI, here is a denser summary
of allocated windows (occurrences & block count):
1165 8
 129 16
  40 32
  24 64
  10 128
   3 256
   2 1024

Google is not very prolific on the subject and I don't have any damn
idea about what could lead to such a situation. Whatever ceph does,
the panic should anyway not happen.

Sebastien

Jul 20 20:35:04 kernel: [  245.903097] EXT3-fs: barriers not enabled
Jul 20 20:35:04 kernel: [  245.915298] kjournald starting.  Commit
interval 5 seconds
Jul 20 20:35:04 kernel: [  245.915910] EXT3-fs (sda8): using internal j=
ournal
Jul 20 20:35:04 kernel: [  245.915920] EXT3-fs (sda8): mounted
filesystem with ordered data mode
Jul 20 20:40:48 kernel: [  590.455751] Block Allocation Reservation
Windows Map (ext3_try_to_allocate_with_rsv):
Jul 20 20:40:48 kernel: [  590.455766] reservation window
0xffff88006e5ff958 start:  0, end:  0
Jul 20 20:40:48 kernel: [  590.455775] reservation window
0xffff88006e9a83c0 start:  2949908, end:  2949915
Jul 20 20:40:48 kernel: [  590.455783] reservation window
0xffff8800379870c0 start:  2949916, end:  2949923
(...)
Jul 20 20:40:48 kernel: [  590.477494] reservation window
0xffff88006d67a700 start:  7373396, end:  7373403
Jul 20 20:40:48 kernel: [  590.477544] reservation window
0xffff88003476d080 start:  7373404, end:  7373411
Jul 20 20:40:48 kernel: [  590.477567] Window map complete.
Jul 20 20:40:48 kernel: [  590.489502] CPU 3
Jul 20 20:40:48 kernel: [  590.489561] Modules linked in: parport_pc
ppdev lp parport mperf cpufreq_stats cpufreq_conservative
cpufreq_userspace cpufreq_powersave fJul 20 20:40:48 kernel: [
590.497930]
Jul 20 20:40:48 kernel: [  590.498918] Pid: 2426, comm: cosd Not
tainted 2.6.35-rc5-amd64 #1 MCP7A-ION/To Be Filled By O.E.M.
Jul 20 20:40:48 kernel: [  590.499939] RIP: 0010:[<ffffffffa02a7edb>]
[<ffffffffa02a7edb>] ext3_try_to_allocate_with_rsv+0x4e5/0x5f0 [ext3]
Jul 20 20:40:48 kernel: [  590.501045] RSP: 0018:ffff88003745d998
EFLAGS: 00010292
Jul 20 20:40:48 kernel: [  590.502117] RAX: 0000000000000027 RBX:
ffff88006e8cc680 RCX: 000000000000024e
Jul 20 20:40:48 kernel: [  590.503164] RDX: 0000000000000000 RSI:
0000000000000046 RDI: 0000000000000246
Jul 20 20:40:48 kernel: [  590.504185] RBP: ffff88006e5fd800 R08:
0000000000000002 R09: 0000000000000005
Jul 20 20:40:48 kernel: [  590.504890] R10: 0000000000000000 R11:
000000000000000f R12: 00000000ffffffff
Jul 20 20:40:48 kernel: [  590.505601] R13: ffff88003745daf0 R14:
ffff88006e5ff800 R15: 0000000000500000
Jul 20 20:40:48 kernel: [  590.506329] FS:  00007f3f19fa7710(0000)
GS:ffff880001b80000(0000) knlGS:0000000000000000
Jul 20 20:40:48 kernel: [  590.507036] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul 20 20:40:48 kernel: [  590.507755] CR2: 00007f3f0e251000 CR3:
0000000044649000 CR4: 00000000000006e0
Jul 20 20:40:48 kernel: [  590.508474] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Jul 20 20:40:48 kernel: [  590.509194] DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000400
Jul 20 20:40:48 kernel: [  590.509952] Process cosd (pid: 2426,
threadinfo ffff88003745c000, task ffff8800447d2fb0)
Jul 20 20:40:48 kernel: [  590.511423]  ffff880014d013c8
ffffffffa02ab2a5 0000000000000000 000000000050023a
Jul 20 20:40:48 kernel: [  590.511462] <0> ffff88001e9c1f40
0000000000000008 ffff880018b180d0 ffff88006f77e690
Jul 20 20:40:48 kernel: [  590.512222] <0> 0000000000507fff
ffff88006e5ff948 00000000000000a0 ffff88006e5ff948
Jul 20 20:40:48 kernel: [  590.514594]  [<ffffffffa02ab2a5>] ?
ext3_mark_iloc_dirty+0x2d5/0x33a [ext3]
Jul 20 20:40:48 kernel: [  590.515348]  [<ffffffffa02a81f1>] ?
ext3_new_blocks+0x20b/0x565 [ext3]
Jul 20 20:40:48 kernel: [  590.516082]  [<ffffffff8105b70f>] ?
bit_waitqueue+0x14/0xa1
Jul 20 20:40:48 kernel: [  590.516844]  [<ffffffffa02a8565>] ?
ext3_new_block+0x1a/0x1f [ext3]
Jul 20 20:40:48 kernel: [  590.517617]  [<ffffffffa02b89c0>] ?
ext3_xattr_block_set+0x515/0x691 [ext3]
Jul 20 20:40:48 kernel: [  590.518393]  [<ffffffffa0297565>] ?
journal_put_journal_head+0x19/0x4e [jbd]
Jul 20 20:40:48 kernel: [  590.519143]  [<ffffffffa02b8e18>] ?
ext3_xattr_set_handle+0x2dc/0x42c [ext3]
Jul 20 20:40:48 kernel: [  590.519897]  [<ffffffffa02b8fe6>] ?
ext3_xattr_set+0x7e/0xd0 [ext3]
Jul 20 20:40:48 kernel: [  590.520651]  [<ffffffff810f819c>] ?
__d_lookup+0xc1/0x107
Jul 20 20:40:48 kernel: [  590.521367]  [<ffffffff810ff9ed>] ?
__vfs_setxattr_noperm+0x39/0xb6
Jul 20 20:40:48 kernel: [  590.522140]  [<ffffffff810ffad7>] ?
vfs_setxattr+0x6d/0x8c
Jul 20 20:40:48 kernel: [  590.522865]  [<ffffffff810ffbb0>] ?
setxattr+0xba/0xed
Jul 20 20:40:48 kernel: [  590.523569]  [<ffffffff810de71f>] ?
virt_to_head_page+0x9/0x2a
Jul 20 20:40:48 kernel: [  590.524300]  [<ffffffff810f2a0d>] ?
user_path_at+0x52/0x78
Jul 20 20:40:48 kernel: [  590.525036]  [<ffffffff810f0d9b>] ?
getname+0x23/0x1b1
Jul 20 20:40:48 kernel: [  590.525755]  [<ffffffff810ffcc5>] ?
sys_setxattr+0x60/0x85
Jul 20 20:40:48 kernel: [  590.526466]  [<ffffffff810089c2>] ?
system_call_fastpath+0x16/0x1b
Jul 20 20:40:48 kernel: [  590.529817]  RSP <ffff88003745d998>
Jul 20 20:40:48 kernel: [  590.530550] ---[ end trace d8e7653724ca3e02 =
]---



2010/7/19 Sage Weil <sage@newdream.net>:
> Hi,
>
> I hit a but like this myself on ext3 and 2.6.32 (I think?), but I was=
n't
> able to reproduce it on a newer kernel (2.6.34, iirc). =A0Can you try
> reproducing this on a newer kernel?
>
> Thanks-
> sage
>
> On Sun, 18 Jul 2010, S=E9bastien Paolacci wrote:
>
>> Hello,
>>
>> I'm reproducibly facing the the following panic, server side, when
>> trying to cp -a /usr /mnt/ceph/ from a quite decent client onto a ve=
ry
>> low end server (an atom nettop):
>>
>> Jul 18 20:53:04 kernel: [ =A0825.096369] kjournald starting. =A0Comm=
it
>> interval 5 seconds
>> Jul 18 20:53:04 kernel: [ =A0825.096843] EXT3 FS on sda8, internal j=
ournal
>> Jul 18 20:53:04 kernel: [ =A0825.096853] EXT3-fs: mounted filesystem
>> with ordered data mode.
>> Jul 18 20:59:29 kernel: [ 1210.224202] Block Allocation Reservation
>> Windows Map (ext3_try_to_allocate_with_rsv):
>> Jul 18 20:59:29 kernel: [ 1210.224214] reservation window
>> 0xffff880037b58958 start: =A00, end: =A00
>> Jul 18 20:59:29 kernel: [ 1210.224220] reservation window
>> 0xffff8800378f2340 start: =A025700771, end: =A025700778
>> Jul 18 20:59:29 kernel: [ 1210.224226] reservation window
>> 0xffff88006d34e380 start: =A025700803, end: =A025700810
>> Jul 18 20:59:29 kernel: [ 1210.224232] reservation window
>> 0xffff8800378f2380 start: =A025700811, end: =A025700818
>> ... (truncated, 1.9k "reservation window"-like lines) ...
>> Jul 18 20:59:29 kernel: [ 1210.253764] reservation window
>> 0xffff88003796ff40 start: =A030115046, end: =A030115053
>> Jul 18 20:59:29 kernel: [ 1210.253772] reservation window
>> 0xffff88006d0b64c0 start: =A030115054, end: =A030115061
>> Jul 18 20:59:29 kernel: [ 1210.253780] Window map complete.
>> Jul 18 20:59:29 kernel: [ 1210.254339] CPU 2
>> Jul 18 20:59:29 kernel: [ 1210.254468] Modules linked in: parport_pc
>> ppdev lp parport cpufreq_stats cpufreq_conservative cpufreq_userspac=
e
>> cpufreq_powersave fuse lo
>> Jul 18 20:59:29 kernel: [ 1210.259400] Pid: 2199, comm: cosd Not
>> tainted 2.6.32-5-amd64 #1 To Be Filled By O.E.M.
>> Jul 18 20:59:29 kernel: [ 1210.259491] RIP: 0010:[<ffffffffa01c4332>=
]
>> [<ffffffffa01c4332>] ext3_try_to_allocate_with_rsv+0x4b1/0x5c1 [ext3=
]
>> Jul 18 20:59:29 kernel: [ 1210.259673] RSP: 0018:ffff8800376b59f8
>> EFLAGS: 00010246
>> Jul 18 20:59:29 kernel: [ 1210.259753] RAX: 0000000000000027 RBX:
>> 0000000001c4037f RCX: 0000000000002b5b
>> Jul 18 20:59:29 kernel: [ 1210.259831] RDX: 0000000000000000 RSI:
>> 0000000000000096 RDI: 0000000000000246
>> Jul 18 20:59:29 kernel: [ 1210.259906] RBP: ffff88006d0a5b80 R08:
>> ffff880037b58950 R09: ffffffff813a9526
>> Jul 18 20:59:29 kernel: [ 1210.259987] R10: 0000000000000000 R11:
>> 00000000000186a0 R12: ffff88006d09b800
>> Jul 18 20:59:29 kernel: [ 1210.260067] R13: ffff880037b58800 R14:
>> 00000000ffffffff R15: ffff88006d70f400
>> Jul 18 20:59:29 kernel: [ 1210.260150] FS: =A000007fb45ac58710(0000)
>> GS:ffff880001900000(0000) knlGS:0000000000000000
>> Jul 18 20:59:29 kernel: [ 1210.260241] CS: =A00010 DS: 0000 ES: 0000
>> CR0: 0000000080050033
>> Jul 18 20:59:29 kernel: [ 1210.260323] CR2: 00007fb44f5f4000 CR3:
>> 0000000037bf6000 CR4: 00000000000006e0
>> Jul 18 20:59:29 kernel: [ 1210.260404] DR0: 0000000000000000 DR1:
>> 0000000000000000 DR2: 0000000000000000
>> Jul 18 20:59:29 kernel: [ 1210.260485] DR3: 0000000000000000 DR6:
>> 00000000ffff0ff0 DR7: 0000000000000400
>> Jul 18 20:59:29 kernel: [ 1210.260572] Process cosd (pid: 2199,
>> threadinfo ffff8800376b4000, task ffff88006e618710)
>> Jul 18 20:59:29 kernel: [ 1210.260732] =A0ffff88006f76d6c0
>> 01c4000000008000 0000000000000010 ffff880030ee6310
>> Jul 18 20:59:29 kernel: [ 1210.260986] <0> 000003886d70f400
>> ffff88006f76d6c0 0000000000000388 ffff88006d0a5ba0
>> Jul 18 20:59:29 kernel: [ 1210.261372] <0> 0000000001c40000
>> 0000000001c47fff ffff880037b58948 000000106ba9d100
>> Jul 18 20:59:29 kernel: [ 1210.261916] =A0[<ffffffffa01c4650>] ?
>> ext3_new_blocks+0x20e/0x5e6 [ext3]
>> Jul 18 20:59:29 kernel: [ 1210.262018] =A0[<ffffffffa01c4a45>] ?
>> ext3_new_block+0x1d/0x24 [ext3]
>> Jul 18 20:59:29 kernel: [ 1210.262118] =A0[<ffffffffa01d426d>] ?
>> ext3_xattr_block_set+0x522/0x6ec [ext3]
>> Jul 18 20:59:29 kernel: [ 1210.262218] =A0[<ffffffffa01d4713>] ?
>> ext3_xattr_set_handle+0x2dc/0x44c [ext3]
>> Jul 18 20:59:29 kernel: [ 1210.262309] =A0[<ffffffff8103a417>] ?
>> enqueue_task+0x5c/0x65
>> Jul 18 20:59:29 kernel: [ 1210.262399] =A0[<ffffffffa01d4904>] ?
>> ext3_xattr_set+0x81/0xc9 [ext3]
>> Jul 18 20:59:29 kernel: [ 1210.262488] =A0[<ffffffff81105afc>] ?
>> __vfs_setxattr_noperm+0x3d/0xb1
>> Jul 18 20:59:29 kernel: [ 1210.262571] =A0[<ffffffff81105be4>] ?
>> vfs_setxattr+0x74/0x8c
>> Jul 18 20:59:29 kernel: [ 1210.262655] =A0[<ffffffff81105ca3>] ?
>> setxattr+0xa7/0xdc
>> Jul 18 20:59:29 kernel: [ 1210.262741] =A0[<ffffffff81102781>] ?
>> mntput_no_expire+0x23/0xee
>> Jul 18 20:59:29 kernel: [ 1210.262827] =A0[<ffffffff810e4f09>] ?
>> virt_to_head_page+0x9/0x2a
>> Jul 18 20:59:29 kernel: [ 1210.262913] =A0[<ffffffff810f8e1c>] ?
>> user_path_at+0x52/0x79
>> Jul 18 20:59:29 kernel: [ 1210.262998] =A0[<ffffffff810f838a>] ?
>> getname+0x23/0x1a0
>> Jul 18 20:59:29 kernel: [ 1210.263084] =A0[<ffffffff81073b79>] ?
>> sys_futex+0x113/0x131
>> Jul 18 20:59:29 kernel: [ 1210.263169] =A0[<ffffffff81105e2d>] ?
>> sys_setxattr+0x59/0x80
>> Jul 18 20:59:29 kernel: [ 1210.263261] =A0[<ffffffff81010b42>] ?
>> system_call_fastpath+0x16/0x1b
>> Jul 18 20:59:29 kernel: [ 1210.267351] =A0RSP <ffff8800376b59f8>
>> Jul 18 20:59:29 kernel: [ 1210.267436] ---[ end trace db503f602ea857=
8f ]---
>>
>> It may actually not be directly related to ceph, I however have to
>> admit I never got this one in other situation on my stock Debian
>> kernel (and the multiple blocks allocation patch should be at least =
as
>> old as the 2.6.16 iirc).
>>
>> I've also found this post describing an equivalent situation:
>> http://www.linuxquestions.org/questions/linux-general-1/alternative-=
to-nfs-602712/page2.html
>> (middle of page).
>>
>> I don't know how (or even if) it's related but I'm simultaneously (a=
nd
>> regularly) getting a "mds laggy or crashed" messages during the test
>> (laggy seems to be the correct answer). I do however also got this
>> very message when using btrfs, with a better end;)
>>
>> Sebastien
>>
>>
>> 10.07.18_20:59:04.093645 =A0 =A0pg v43: 264 pgs: 264
>> active+clean+degraded; 1429 MB data, 1725 MB used, 117 GB / 125 GB
>> avail; 16614/33228 degraded (50.000%)
>> 10.07.18_20:59:08.348394 =A0 mds e13: 1/1/1 up {0=3Dup:active(laggy =
or crashed)}
>> 10.07.18_20:59:09.376428 =A0 =A0pg v44: 264 pgs: 264
>> active+clean+degraded; 1661 MB data, 1963 MB used, 117 GB / 125 GB
>> avail; 17294/34588 degraded (50.000%)
>> 10.07.18_20:59:10.687956 =A0 mds e14: 1/1/1 up {0=3Dup:active}
>> 10.07.18_20:59:11.707158 =A0 log 10.07.18_20:59:10.687549 mon0
>> 192.168.0.3:6789/0 9 : [INF] mds0 192.168.0.3:6802/2217 up:active
>> 10.07.18_20:59:12.493888 =A0 =A0pg v45: 264 pgs: 264
>> active+clean+degraded; 1682 MB data, 1983 MB used, 117 GB / 125 GB
>> avail; 17301/34602 degraded (50.000%)
>> 10.07.18_20:59:17.498511 =A0 =A0pg v46: 264 pgs: 264
>> active+clean+degraded; 1689 MB data, 1989 MB used, 117 GB / 125 GB
>> avail; 17304/34608 degraded (50.000%)
>> 10.07.18_20:59:22.498215 =A0 =A0pg v47: 264 pgs: 264
>> active+clean+degraded; 1703 MB data, 2004 MB used, 117 GB / 125 GB
>> avail; 17312/34624 degraded (50.000%)
>> 10.07.18_20:59:28.037937 =A0 =A0pg v48: 264 pgs: 264
>> active+clean+degraded; 1743 MB data, 2044 MB used, 117 GB / 125 GB
>> avail; 17343/34686 degraded (50.000%)
>>
>> Message from syslogd at Jul 18 20:59:29 ...
>> =A0kernel:[ 1210.253874] ------------[ cut here ]------------
>>
>> Message from syslogd at Jul 18 20:59:29 ...
>> =A0kernel:[ 1210.254053] invalid opcode: 0000 [#1] SMP
>>
>> Message from syslogd at Jul 18 20:59:29 ...
>> =A0kernel:[ 1210.254240] last sysfs file:
>> /sys/devices/pci0000:00/0000:00:0b.0/host2/target2:0:0/2:0:0:0/block=
/sda/removable
>>
>> Message from syslogd at Jul 18 20:59:29 ...
>> =A0kernel:[ 1210.260661] Stack:
>>
>> Message from syslogd at Jul 18 20:59:29 ...
>> =A0kernel:[ 1210.261813] Call Trace:
>>
>> Message from syslogd at Jul 18 20:59:29 ...
>> =A0kernel:[ 1210.263342] Code: 0b 48 8b 44 24 40 48 39 45 28 73 23 4=
9 8b
>> bf 90 02 00 00 48 c7 c2 00 5b 1d a0 be 01 00 00 00 48 81 c7 50 01 00
>> 00 e8 cd f0 ff ff <0f> 0b eb fe 48 8b 54 24 38 48 8b 4c 24 18 4c 8d =
8c
>> 24 80 00 00
>> 10.07.18_20:59:32.539932 =A0 =A0pg v49: 264 pgs: 264
>> active+clean+degraded; 1783 MB data, 2086 MB used, 117 GB / 125 GB
>> avail; 17450/34900 degraded (50.000%)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
