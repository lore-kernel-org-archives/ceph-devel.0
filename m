From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Slow file creating and deleting using bonnie ++ on Hammer
Date: Wed, 20 May 2015 13:15:02 -0500
Message-ID: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:34844 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbbETSPD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 14:15:03 -0400
Received: by yhda23 with SMTP id a23so15129117yhd.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 11:15:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am trying to find out why boniee++ is choking at the creating files
sequentially and deleting sequentially on cephfs.
I enabled mds debug for about 30 seconds and I find a bunch of lines
like the following:

2015-05-19 15:54:12.930829 7f6de4ecf700  1 -- 192.168.40.3:6800/461756
--> 192.168.40.100:0/1741116310 -- client_caps(grant ino 10000004ca9
19656 seq 2 caps=pAsxLsXsxFsxcrwb dirty=- wanted=pAsxXsxFxwb follows 0
size 0/4194304 ts 1 mtime 2015-05-19 15:54:09.098825) v5 -- ?+0
0x557a800 con 0x4fdeca0

Is this statement showing that it takes 4 seconds to create an inode?

Watching ( watch --interval=.2 -d 'ceph df') ceph df, rados df, and
ceph osd pool stats seems to show that an object is being created or
deleted about every 4 seconds.

The test is now running for over 24 hours with the following bonnie++ comand:

~/bonnie++-1.03e/bonnie++ -u root:root -s 256g -r 131072 -d /cephfs/
-m CephBench -f -b

I can give more log output if needed.

OSD + MON/MDS
CentOS 7
ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
kernel version : 3.10.0-229.el7.x86_64

Client
CentOS 6
ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
kernel version : 4.0.0-1.el6.elrepo.x86_64
