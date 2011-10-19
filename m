From: Mandell Degerness <mandell@pistoncloud.com>
Subject: rbd hangs
Date: Wed, 19 Oct 2011 16:41:32 -0700
Message-ID: <CA+jddaOT9TrgVNtdakpBfeH+Z0mShYot7eTYMiCn+W=VrT7Wew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53981 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab1JSXld convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2011 19:41:33 -0400
Received: by vcge1 with SMTP id e1so2016413vcg.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2011 16:41:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm having an occasional bug where rbd is hanging.  This trace is in th=
e logs:


Oct 19 16:33:04 node-172-16-0-130 kernel: ------------[ cut here ]-----=
-------
Oct 19 16:33:04 node-172-16-0-130 kernel: kernel BUG at fs/btrfs/inode.=
c:3653!
Oct 19 16:33:04 node-172-16-0-130 kernel: invalid opcode: 0000 [#1] SMP
Oct 19 16:33:04 node-172-16-0-130 kernel: CPU 10
Oct 19 16:33:04 node-172-16-0-130 kernel: Modules linked in: 8021q
garp bridge stp llc ses enclosure sd_mod crc_t10dif pcspkr serio_raw
i2c_i801 i2c_core iTCO_wdt iTCO_vendor_support mpt2sas ixgbe
i7core_edac ioatdma edac_core scsi_transport_sas dca mdio raid_class
Oct 19 16:33:04 node-172-16-0-130 kernel:
Oct 19 16:33:04 node-172-16-0-130 kernel: Pid: 21278, comm: ceph-osd
Tainted: G =A0 =A0 =A0 =A0W =A0 3.1.0-rc10-master-176 #1 Supermicro X8D=
T6/X8DT6
Oct 19 16:33:04 node-172-16-0-130 kernel: RIP:
0010:[<ffffffff812caf81>] =A0[<ffffffff812caf81>]
btrfs_evict_inode+0x151/0x21d
Oct 19 16:33:04 node-172-16-0-130 kernel: RSP: 0018:ffff880424a8dd88
EFLAGS: 00010293
Oct 19 16:33:04 node-172-16-0-130 kernel: RAX: 00000000ffffffe4 RBX:
ffff88042090bc00 RCX: 000000000000000a
Oct 19 16:33:04 node-172-16-0-130 kernel: RDX: 0000000000000000 RSI:
ffff88042090bc00 RDI: ffff880827eca6f8
Oct 19 16:33:04 node-172-16-0-130 kernel: RBP: ffff880424a8ddb8 R08:
0000000000000005 R09: 0000000000000001
Oct 19 16:33:04 node-172-16-0-130 kernel: R10: 00000000556e9a99 R11:
0000000000000001 R12: ffff88080c61d1d8
Oct 19 16:33:04 node-172-16-0-130 kernel: R13: ffff880815480df8 R14:
0000000000000000 R15: 00007f30eb04fde0
Oct 19 16:33:04 node-172-16-0-130 kernel: FS: =A000007f30eb051700(0000)
GS:ffff88083fc80000(0000) knlGS:0000000000000000
Oct 19 16:33:04 node-172-16-0-130 kernel: CS: =A00010 DS: 0000 ES: 0000
CR0: 0000000080050033
Oct 19 16:33:04 node-172-16-0-130 kernel: CR2: 00007f9172e90d80 CR3:
00000004255ac000 CR4: 00000000000006e0
Oct 19 16:33:04 node-172-16-0-130 kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 19 16:33:04 node-172-16-0-130 kernel: DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000400
Oct 19 16:33:04 node-172-16-0-130 kernel: Process ceph-osd (pid:
21278, threadinfo ffff880424a8c000, task ffff880411067560)
Oct 19 16:33:04 node-172-16-0-130 kernel: Stack:
Oct 19 16:33:04 node-172-16-0-130 kernel: ffff88080c61d1d8
00000000556e9a99 ffff88080c61d1d8 ffff88080c61d2d8
Oct 19 16:33:04 node-172-16-0-130 kernel: ffffffff81840310
0000000000000000 ffff880424a8ddf8 ffffffff8115bcda
Oct 19 16:33:04 node-172-16-0-130 kernel: ffff880424a8ddf8
00000000556e9a99 0000000000000000 ffff88080c61d1d8
Oct 19 16:33:04 node-172-16-0-130 kernel: Call Trace:
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff8115bcda>] evict+0x=
a5/0x172
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff8115bf07>]
iput_final+0x160/0x17f
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff8115bf75>] iput+0x4=
f/0x6a
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff81151ccc>]
do_unlinkat+0x133/0x1a1
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff81147de2>] ?
sys_newstat+0x3d/0x5c
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff8115294d>]
sys_unlink+0x29/0x3f
Oct 19 16:33:04 node-172-16-0-130 kernel: [<ffffffff816324ab>]
system_call_fastpath+0x16/0x1b
Oct 19 16:33:04 node-172-16-0-130 kernel: Code: a0 03 00 00 31 c9 41
b8 05 00 00 00 48 89 de 4c 89 ef 49 89 45 38 48 8b 93 a0 03 00 00 e8
ad 4d fe ff 85 c0 74 18 83 f8 f5 74 02 <0f> 0b 48 89 de 4c 89 ef e8 fc
58 ff ff 85 c0 74 ac 0f 0b 45 31
Oct 19 16:33:04 node-172-16-0-130 kernel: RIP =A0[<ffffffff812caf81>]
btrfs_evict_inode+0x151/0x21d
Oct 19 16:33:04 node-172-16-0-130 kernel: RSP <ffff880424a8dd88>
Oct 19 16:33:04 node-172-16-0-130 kernel: ---[ end trace 63e048c55b4b5c=
4c ]---
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
