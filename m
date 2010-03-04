From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: users, 2.6.34
Date: Thu, 4 Mar 2010 13:29:53 +0100
Message-ID: <ce7365351003040429w39061f24yb614988339828bc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi,

we are currently in the evaluation of ceph. We want to use ceph as
filesystem to store kvm virtual machine block images, as well as a s3
object store.
Our test setup is build of 4 servers with 1.2TB raid0, composed of
4*300GB SCSI drives. We have 4 osds and 1 mds running actually but we
want to have at least 2-3 mds.

We use fedora12 x64 and we had a couple of issues so far.

1. We were not able to start 4 individual osd per server. With this
configuration we tried to get best cpu utilization (one osd per
CPU-Core, one osd per single disk). We always got Kernel OOPS when we
tried to stop osd.

################################################################
Feb 26 15:20:42 sc02 kernel: Oops: 0000 [#3] SMP
Feb 26 15:20:42 sc02 kernel: last sysfs file: /sys/module/btrfs/initstate
Feb 26 15:20:42 sc02 kernel: CPU 0
Feb 26 15:20:42 sc02 kernel: Modules linked in: btrfs zlib_deflate
libcrc32c ip6t_REJECT nf_conntrack_ipv6 ip6table_filter ip6_tables
ipv6 e1000 tg3 hpwdt iTCO_wdt iTCO_vendor_support shpchp e752x_edac
edac_core cciss floppy [last unloaded: scsi_wait_scan]
Feb 26 15:20:42 sc02 kernel: Pid: 1427, comm: cosd Tainted: G      D
 2.6.31.12-174.2.22.fc12.x86_64 #1 ProLiant DL380 G4
Feb 26 15:20:42 sc02 kernel: RIP: 0010:[<ffffffff8119f89f>]
[<ffffffff8119f89f>] jbd2_journal_start+0x43/0xe1
Feb 26 15:20:42 sc02 kernel: RSP: 0018:ffff88015400daa8  EFLAGS: 00010286
Feb 26 15:20:42 sc02 kernel: RAX: 0000000000051766 RBX:
ffff8801504d2000 RCX: 0000000000000400
Feb 26 15:20:42 sc02 kernel: RDX: 0000000000000401 RSI:
0000000000000001 RDI: ffff8801528cd000
Feb 26 15:20:42 sc02 kernel: RBP: ffff88015400dac8 R08:
0000000000000000 R09: ffff88015400dc30
Feb 26 15:20:42 sc02 kernel: R10: ffffffff81441330 R11:
ffff88015400de00 R12: ffff8801528cd000
Feb 26 15:20:42 sc02 kernel: R13: 0000000000000001 R14:
0000000000000000 R15: 0000000000000d19
Feb 26 15:20:42 sc02 kernel: FS:  00007f425824a710(0000)
GS:ffff880028028000(0000) knlGS:0000000000000000
Feb 26 15:20:42 sc02 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 26 15:20:42 sc02 kernel: CR2: 0000000000051766 CR3:
0000000152c50000 CR4: 00000000000006f0
Feb 26 15:20:42 sc02 kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Feb 26 15:20:42 sc02 kernel: DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000400
Feb 26 15:20:42 sc02 kernel: Process cosd (pid: 1427, threadinfo
ffff88015400c000, task ffff880154025e00)
Feb 26 15:20:42 sc02 kernel: Stack:
Feb 26 15:20:42 sc02 kernel: ffff880152ef5800 ffff880150463e40
ffff88015305a9c0 ffff88015400dc28
Feb 26 15:20:42 sc02 kernel: <0> ffff88015400dad8 ffffffff81180d65
ffff88015400dae8 ffffffff8116ad83
Feb 26 15:20:42 sc02 kernel: <0> ffff88015400db88 ffffffff811710ce
ffff88015400db28 ffffffff81201809
Feb 26 15:20:42 sc02 kernel: Call Trace:
Feb 26 15:20:42 sc02 kernel: [<ffffffff81180d65>]
ext4_journal_start_sb+0x54/0x7e
Feb 26 15:20:42 sc02 kernel: [<ffffffff8116ad83>] ext4_journal_start+0x15/0x17
Feb 26 15:20:42 sc02 kernel: [<ffffffff811710ce>]
ext4_da_write_begin+0x105/0x20a
Feb 26 15:20:42 sc02 kernel: [<ffffffff81201809>] ? __up_read+0x76/0x81
Feb 26 15:20:42 sc02 kernel: [<ffffffff81194fe4>] ? ext4_xattr_get+0x1e6/0x255
Feb 26 15:20:42 sc02 kernel: [<ffffffff810c22c1>]
generic_file_buffered_write+0x125/0x303
Feb 26 15:20:42 sc02 kernel: [<ffffffff8110dee3>] ? file_update_time+0xb8/0xed
Feb 26 15:20:42 sc02 kernel: [<ffffffff810c28ac>]
__generic_file_aio_write_nolock+0x251/0x286
Feb 26 15:20:42 sc02 kernel: [<ffffffff811c800f>] ? selinux_capable+0xe0/0x10c
Feb 26 15:20:42 sc02 kernel: [<ffffffff811c422e>] ? inode_has_perm+0x71/0x87
Feb 26 15:20:42 sc02 kernel: [<ffffffff810c2b7e>]
generic_file_aio_write+0x6a/0xca
Feb 26 15:20:42 sc02 kernel: [<ffffffff8116894f>] ext4_file_write+0x98/0x11d
Feb 26 15:20:42 sc02 kernel: [<ffffffff810fc6ca>] do_sync_write+0xe8/0x125
Feb 26 15:20:42 sc02 kernel: [<ffffffff81067b37>] ?
autoremove_wake_function+0x0/0x39
Feb 26 15:20:42 sc02 kernel: [<ffffffff811c466c>] ?
selinux_file_permission+0x58/0x5d
Feb 26 15:20:42 sc02 kernel: [<ffffffff811bcdbd>] ?
security_file_permission+0x16/0x18
Feb 26 15:20:42 sc02 kernel: [<ffffffff810fcca6>] vfs_write+0xae/0x10b
Feb 26 15:20:42 sc02 kernel: [<ffffffff810fcdc3>] sys_write+0x4a/0x6e
Feb 26 15:20:42 sc02 kernel: [<ffffffff81011d32>] system_call_fastpath+0x16/0x1b
Feb 26 15:20:42 sc02 kernel: Code: c6 00 00 48 85 ff 49 89 fc 41 89 f5
48 8b 80 90 06 00 00 48 c7 c3 e2 ff ff ff 0f 84 9d 00 00 00 48 85 c0
48 89 c3 74 14 48 8b 00 <48> 39 38 74 04 0f 0b eb fe ff 43 0c e9 81 00
00 00 48 8b 3d a9
Feb 26 15:20:42 sc02 kernel: RIP  [<ffffffff8119f89f>]
jbd2_journal_start+0x43/0xe1
Feb 26 15:20:42 sc02 kernel: RSP <ffff88015400daa8>
Feb 26 15:20:42 sc02 kernel: CR2: 0000000000051766
Feb 26 15:20:42 sc02 kernel: ---[ end trace 58cde2a32eccd54c ]---
################################################################


2. With the actual configuration (4 disks per server configured to
raid0, one osd per server ) we sometimes have similar crashes when we
try to stop ceph.

3. modifying the crushmap does not work at all:

[root@sc01 ~]# ceph osd getcrushmap -o /tmp/crush
10.03.04 14:25:53.944335 mon <- [osd,getcrushmap]
10.03.04 14:25:53.944921 mon0 -> 'got crush map from osdmap epoch 33' (0)
10.03.04 14:25:53.945578 wrote 349 byte payload to /tmp/crush
[root@sc01 ~]# crushtool -d /tmp/crush -o /tmp/crush.txt
[root@sc01 ~]#  crushtool -c /tmp/crush.txt -o /tmp/crush.new
/tmp/crush.txt:52 error: parse error at ''

Beside that we think that ceph is very promising and we would like to
contribute to bring this filesystem to a production quality, at least
with extensive testing.

thanx a lot
-- 
Stefan Majer

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
