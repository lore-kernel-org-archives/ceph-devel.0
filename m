From: Jerry Lee <leisurelysw24@gmail.com>
Subject: kernel client get stuck when the cephfs is unreachable
Date: Thu, 23 Mar 2017 17:50:42 +0800
Message-ID: <CAKQB+fsV_BkcGq99XH+u-4nOW6tea1wDFKXgPwdV6uJLXmJT_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33549 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdCWJup (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 05:50:45 -0400
Received: by mail-lf0-f48.google.com with SMTP id a6so79299137lfa.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 02:50:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Is there some way to inform the kernel client and to reject all the on-going
operations when the cluster is destroyed or the CephFS is unreachable?  I find
that many operations (e.g., df, statfs, access, ...) hang with the following
call stack when the CephFS is unreachable:

 7752 admin       844 D   umount -f -l /share/ceph_vol
 [~] # cat /proc/7752/stack
 [<ffffffffa07d02a2>] ceph_mdsc_do_request+0xf2/0x270 [ceph]
 [<ffffffffa07b47f3>] __ceph_do_getattr+0xa3/0x1b0 [ceph]
 [<ffffffffa07b4925>] ceph_permission+0x25/0x40 [ceph]
 [<ffffffff8116960b>] __qnap_inode_permission+0xbb/0x130
 [<ffffffff811696d3>] qnap_inode_permission+0x23/0x60
 [<ffffffff81169d1f>] link_path_walk+0x23f/0x510
 [<ffffffff8116a437>] path_lookupat+0x77/0x100
 [<ffffffff8116a555>] filename_lookup+0x95/0x150
 [<ffffffff8116a6b5>] user_path_at_empty+0x35/0x40
 [<ffffffff81163037>] SyS_readlink+0x47/0xf0
 [<ffffffff81a83f57>] entry_SYSCALL_64_fastpath+0x12/0x6a
 [<ffffffffffffffff>] 0xffffffffffffffff

 3520 admin       992 S   grep reboot
 [~] # cat /proc/23739/stack
 [<ffffffffa07d0fab>] ceph_mdsc_sync+0x46b/0x690 [ceph]
 [<ffffffffa07af40a>] ceph_sync_fs+0x5a/0xc0 [ceph]
 [<ffffffff8118e30b>] sync_fs_one_sb+0x1b/0x20
 [<ffffffff81161658>] iterate_supers+0xa8/0x100
 [<ffffffff8118e410>] sys_sync+0x50/0x90
 [<ffffffff81a83f57>] entry_SYSCALL_64_fastpath+0x12/0x6a
 [<ffffffffffffffff>] 0xffffffffffffffff
 8150 admin      1000 D   /bin/df -k /share/ceph_vol

 [~] # cat /proc/8150/stack
 [<ffffffffa07d033c>] ceph_mdsc_do_request+0x18c/0x260 [ceph]
 [<ffffffffa07b47f3>] __ceph_do_getattr+0xa3/0x1b0 [ceph]
 [<ffffffffa07b4963>] ceph_getattr+0x23/0xf0 [ceph]
 [<ffffffff811626d7>] vfs_getattr_nosec+0x27/0x40
 [<ffffffff81162830>] vfs_fstatat+0x60/0xa0
 [<ffffffff81162c8f>] SYSC_newstat+0x1f/0x40
 [<ffffffff81162eb9>] SyS_newstat+0x9/0x10
 [<ffffffff81a83f57>] entry_SYSCALL_64_fastpath+0x12/0x6a
 [<ffffffffffffffff>] 0xffffffffffffffff

The Ceph verion is "version v11.0.2-1-g5b7012b" and the kernel verion is
"linux-4.2.8".  Before sending this e-mail, I find a related patch (48fec5d,
ceph: EIO all operations after forced umount) and it does solve some problem in
my environment.  But, sometimes, even the forced umount gets stuck forever.
After looking into the codes, I find that the req->r_timeout is only used
during mount operation (60 sec.) and for other operations, it will wait forever
even when the remote cluster is dead.  Is there some consideration that the
req->r_timeout is left as zero?

Any ideas will be appreciated, thanks.

- Jerry
