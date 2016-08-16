From: Jeff Layton <jlayton@redhat.com>
Subject: Re: CephFS and Samba hang on copy of large file
Date: Tue, 16 Aug 2016 10:05:19 -0400
Message-ID: <1471356319.2873.8.camel@redhat.com>
References: <1423426743.2483.1471267435085@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34959 "EHLO
	mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbcHPOF5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 10:05:57 -0400
Received: by mail-qt0-f171.google.com with SMTP id x25so35397333qtx.2
        for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2016 07:05:23 -0700 (PDT)
In-Reply-To: <1423426743.2483.1471267435085@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 2016-08-15 at 15:23 +0200, Wido den Hollander wrote:
> Hi,
> 
> I'm running into a issue in combination of CephFS and Samba and I was
> wondering if a dev knew what is happening here.
> 
> The situation:
> - Jewel cluster
> - CephFS kernel client version 4.7
> - Samba re-export of CephFS
> - Mount options: rw,noatime,acl
> 
> A copy of a 15GB file results in Samba hanging in status D:
> 
> root@hlms-zaken-01:~# ps aux|grep smb|grep D
> jongh       8887  0.0  0.0 376656 19068 ?        D    14:42   0:00
> /usr/sbin/smbd -D
> jongh       9740  0.0  0.0 377380 19244 ?        D    14:49   0:00
> /usr/sbin/smbd -D
> root@hlms-zaken-01:~# cat /proc/8887/stack
> [<ffffffff8132d353>] call_rwsem_down_write_failed+0x13/0x20
> [<ffffffff8121a145>] vfs_setxattr+0x55/0xb0
> [<ffffffff8121a2a5>] setxattr+0x105/0x170
> [<ffffffff81203aa1>] filename_lookup+0xf1/0x180
> [<ffffffff8120369f>] getname_flags+0x6f/0x1e0
> [<ffffffff8121a3bd>] path_setxattr+0xad/0xe0
> [<ffffffff8121a4f0>] SyS_setxattr+0x10/0x20
> [<ffffffff815e8b76>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [<ffffffffffffffff>] 0xffffffffffffffff
> root@hlms-zaken-01:~# cat /proc/9740/stack
> [<ffffffff8132d353>] call_rwsem_down_write_failed+0x13/0x20
> [<ffffffff8121a145>] vfs_setxattr+0x55/0xb0
> [<ffffffff8121a2a5>] setxattr+0x105/0x170
> [<ffffffff81203aa1>] filename_lookup+0xf1/0x180
> [<ffffffff8120369f>] getname_flags+0x6f/0x1e0
> [<ffffffff8121a3bd>] path_setxattr+0xad/0xe0
> [<ffffffff8121a4f0>] SyS_setxattr+0x10/0x20
> [<ffffffff815e8b76>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [<ffffffffffffffff>] 0xffffffffffffffff
> root@hlms-zaken-01:~#
> 
> Now, when I look in /sys/kernel/debug/ceph/*/osdc / mdsc there are no
> outstanding requests to the OSDs or MDS.
> 
> Both these calls just hang for ever on these requests and they don't
> continue.
> 
> Any pointers where to start looking for this? I tried the 4.4 kernel
> before, it gave me the same hang. So that's why I upgraded to 4.7 to
> see if it was fixed there.
> 
> The Ceph cluster is currently backfilling 17 PGs, but this also
> happend when HEALTH_OK was around.
> 
> There are no block or slow requests in the cluster.
> 
FWIW, looks like those tasks are stuck trying to acquire the inode
rwsem in order to do a setxattr. Most likely, something grabbed that
lock and didn't release it for some reason.

In order to track that down, you'd need to take a look at the state of all of the tasks on the machine and try to track down the one that's holding this lock (or "these locks" -- these could be different inodes after all).

It may be simplest to force a vmcore and then poke around in there with the crash kernel debugger. Identify the inode that has the blocked rwsem, verify that it's still legit (not freed or anything) and then see if you can figure out which task might have failed to release the lock and why.
-- 
Jeff Layton <jlayton@redhat.com>
