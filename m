From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [Regression,bisected] 2.6.39-rc3 ceph client write hangs
Date: Fri, 15 Apr 2011 11:00:58 -0600
Message-ID: <4DA879CA.8060305@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:56417 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab1DORBZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 13:01:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dchinner@redhat.com, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

This command is hanging on 2.6.39-rc3, where /mnt/ceph is
a ceph file system:
   dd conv=fdatasync if=/dev/zero of=/mnt/ceph/zero.`hostname -s` bs=4k count=4k

It works on 2.6.38.  As of commit e38f5b745075 in Linus'
tree it still doesn't work.

I bisected this to:

250df6ed274d767da844a5d9f05720b804240197 is the first bad commit
commit 250df6ed274d767da844a5d9f05720b804240197
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Mar 22 22:23:36 2011 +1100

     fs: protect inode->i_state with inode->i_lock

In the early stages of the bisection, bad commits would show this
in dmesg:

[  137.004963] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[  137.056431] ceph: loaded (mds proto 32)
[  137.063213] libceph: client4283 fsid 950217ad-499e-eab1-03f7-f6d245f42751
[  137.063826] libceph: mon0 172.17.40.34:6789 session established
[  219.658002] INFO: rcu_sched_state detected stall on CPU 0 (t=60000 jiffies)

For the last couple of bad commits during the bisection, the
client box would just hang and I'd have to power-cycle it.

When I reboot/remount after a hang, the file I was trying
to write is there, with size and date both zero:

# ls -l --time-style=+%s /mnt/ceph/zero.an1024
-rw-r--r-- 1 jaschut jaschut 0 0 /mnt/ceph/zero.an1024

strace suggests it's the write that hangs:

close(3)                                = 0
close(0)                                = 0
open("/dev/zero", O_RDONLY)             = 0
lseek(0, 0, SEEK_CUR)                   = 0
close(1)                                = 0
open("/mnt/ceph/zero.an1024", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 1
rt_sigaction(SIGUSR1, NULL, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, NULL, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGUSR1, {0x401a20, [INT USR1], SA_RESTORER, 0x7f3a97f292d0}, NULL, 8) = 0
rt_sigaction(SIGINT, {0x401a10, [INT USR1], SA_RESTORER|SA_NODEFER|SA_RESETHAND, 0x7f3a97f292d0}, NULL, 8) = 0
clock_gettime(CLOCK_MONOTONIC, {216, 671807533}) = 0
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096

Let me know if I can do anything else to help sort this out.

-- Jim

(Please Cc: me as I am not subscribed to lkml.)

