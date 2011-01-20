From: Brian Chrisman <brchrisman@gmail.com>
Subject: sparse file support
Date: Thu, 20 Jan 2011 13:11:11 -0800
Message-ID: <AANLkTik231Dz019ztWhJsMX0tnVKL-EdmkY8ROCSWLnV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34429 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab1ATVLM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jan 2011 16:11:12 -0500
Received: by qwa26 with SMTP id 26so1087514qwa.19
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jan 2011 13:11:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've performed some simple testing of sparse files on ceph.  Summary,
ceph reports full file size to 'du' and 'ls', where it should return
actual storage usage to 'du'.  Creating a sparse file on ceph does not
actually use the full file size in storage (which is correct
behavior).  Is this a known issue, or should I submit a bug?

dd if=/dev/urandom of=random.data bs=1024 count=1024
dd if=random.data of=sparse_file.data
dd if=random.data of=sparse_file.data bs=1024k seek=1024
ls -l sparse_file.data
du -sh sparse_file.data

A reference output: ext3
[root@test11 tmp]# ls -l sparse_file.data
-rw-r-r- 1 root root 1074790400 Jan 19 18:43 sparse_file.data
[root@test11 tmp]#
[root@test11 tmp]# du -sh sparse_file.data
2.1M sparse_file.data
[root@test11 tmp]#

Output from: ceph
[root@test11 fs0]# ls -l sparse_file.data
-rw-r-r- 1 root root 1074790400 Jan 19 18:45 sparse_file.data
[root@test11 fs0]# du -sh sparse_file.data
1.1Gsparse_file.data
[root@test11 fs0]#

However, df shows that 1GB of space is not actually used in the filesytem:

[root@test11 fs0]# df -h
Filesystem            Size  Used Avail Use% Mounted on
...
10.200.98.111:/        11T   30M   11T   1% /fs0
[root@test11 fs0]#

-Brian
