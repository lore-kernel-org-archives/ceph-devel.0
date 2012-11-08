From: Travis Rhoden <trhoden@gmail.com>
Subject: problems creating new ceph cluster when using journal on block device
Date: Thu, 8 Nov 2012 02:29:05 -0500
Message-ID: <CACkq2mozdJackj__AB_ZJnN5KR9mdqN_LRG8RPu0hN1qh_8e_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:49562 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2KHH30 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 02:29:26 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so2352108vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 23:29:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey folks,

I'm trying to set up a brand new Ceph cluster, based on v0.53.  My
hardware has SSDs for journals, and I'm trying to get mkcephfs to
intialize everything for me. However, the command hangs forever and I
eventually have to kill it.

After poking around a bit, it's clear that the problem has something
to do with the journal.  If I comment out the journal in ceph.conf,
the commands proceed just find.  This is the first time I've tried to
throw a journal on a block device rather than a file, so maybe I've
done something wrong with that.

Here is the info from ceph.conf:


[osd]
        osd journal size = 4000
[osd.0]
        host = ceph1
        osd journal = /dev/sda5


when I log in the log file, here is what I see:

2012-11-07 23:18:20.578623 7fe2743e3780  1
filestore(/var/lib/ceph/osd/ceph-0) mkfs in /var/lib/ceph/osd/ceph-0
2012-11-07 23:18:20.578699 7fe2743e3780  1
filestore(/var/lib/ceph/osd/ceph-0) mkfs fsid is already set to
4aac6842-8d71-4405-88ad-e3e9e4da308d
2012-11-07 23:18:20.632138 7fe2743e3780  1
filestore(/var/lib/ceph/osd/ceph-0) leveldb db exists/created
2012-11-07 23:18:20.634338 7fe2743e3780  0 journal  kernel version is 3.2.0
2012-11-07 23:18:20.634579 7fe2743e3780  1 journal _open /dev/sda5 fd
9: 4194304000 bytes, block size 4096 bytes, directio = 1, aio = 0
2012-11-07 23:18:20.634995 7fe2743e3780  1 journal check: header looks ok
2012-11-07 23:18:20.636020 7fe2743e3780  1
filestore(/var/lib/ceph/osd/ceph-0) mkfs done in
/var/lib/ceph/osd/ceph-0
2012-11-07 23:18:20.682113 7fe2743e3780  0
filestore(/var/lib/ceph/osd/ceph-0) mount FIEMAP ioctl is supported
and appears to work
2012-11-07 23:18:20.682125 7fe2743e3780  0
filestore(/var/lib/ceph/osd/ceph-0) mount FIEMAP ioctl is disabled via
'filestore fiemap' config option
2012-11-07 23:18:20.682424 7fe2743e3780  0
filestore(/var/lib/ceph/osd/ceph-0) mount did NOT detect btrfs
2012-11-07 23:18:20.781938 7fe2743e3780  0
filestore(/var/lib/ceph/osd/ceph-0) mount syncfs(2) syscall fully
supported (by glibc and kernel)
2012-11-07 23:18:20.782061 7fe2743e3780  0
filestore(/var/lib/ceph/osd/ceph-0) mount found snaps <>
2012-11-07 23:18:20.823915 7fe2743e3780  0
filestore(/var/lib/ceph/osd/ceph-0) mount: enabling WRITEAHEAD journal
mode: btrfs not detected
2012-11-07 23:18:20.826137 7fe2743e3780  0 journal  kernel version is 3.2.0
2012-11-07 23:18:20.826386 7fe2743e3780  1 journal _open /dev/sda5 fd
15: 4194304000 bytes, block size 4096 bytes, directio = 1, aio = 0

So I know it is trying to use the right partition/block device.  It
just never get's past that line.

Finally, I tried to track things down myself to see what was hanging
using strace.  I ran:

strace /usr/bin/ceph-osd -c /tmp/travis/conf --monmap
/tmp/travis/monmap -i 0 --mkfs --mkkey

And the final output from that is:

open("/dev/sda5", O_RDONLY)             = 15
fstat(15, {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 5), ...}) = 0
ioctl(15, BLKGETSIZE64, 0x7fffe7a587a8) = 0
geteuid()                               = 0
pipe2([16, 17], O_CLOEXEC)              = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x7f5365f28a50) = 707
close(17)                               = 0
fcntl(16, F_SETFD, 0)                   = 0
fstat(16, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f5365f14000
read(16, "\n/dev/sda5:\n write-caching =  1 "..., 4096) = 37
open("/proc/version", O_RDONLY)         = 17
read(17, "Linux version 3.2.0-23-generic ("..., 127) = 127
futex(0x2db807c, FUTEX_WAKE_OP_PRIVATE, 1, 1, 0x2db8078,
{FUTEX_OP_SET, 0, FUTEX_OP_CMP_GT, 1}) = 1
futex(0x2db8028, FUTEX_WAKE_PRIVATE, 1) = 1
close(17)                               = 0
close(16)                               = 0
wait4(707, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 707
munmap(0x7f5365f14000, 4096)            = 0
io_setup(128, {139996169318400})        = 0
futex(0x2db807c, FUTEX_WAKE_OP_PRIVATE, 1, 1, 0x2db8078,
{FUTEX_OP_SET, 0, FUTEX_OP_CMP_GT, 1}) = 1
futex(0x2db8028, FUTEX_WAKE_PRIVATE, 1) = 1
pread(15, "\2\0\0\0000\0\0\0\1\0\0\0\0\0\0\0J\254hB\215qD\5\210\255\343\351\344\3320\215"...,
4096, 0) = 4096

And that's as far as it gets.  Any thoughts?

After some sleep, I'll try throwing the journal back on a file instead
of a block device and see if that does it.

Can anyone confirm that using a block device instead of a file is
actually better performance?

Thanks,

 - Travis
