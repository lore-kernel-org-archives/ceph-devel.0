From: AnnyRen <annyren6@gmail.com>
Subject: one question about cephfs disk usage
Date: Tue, 2 Aug 2011 15:30:30 +0800
Message-ID: <CADF7qQV1gcaKiuTHt9fY3jpOYZRBUx6X-bn_SCp-0th2VrDeNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43543 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab1HBHab (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2011 03:30:31 -0400
Received: by yxi11 with SMTP id 11so3600636yxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Aug 2011 00:30:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, developers:

I have a question about the information of "ceph -s" result.
The replication size is 2, and I check the ceph mount directory info with

root@MON1:~# ls -l /mnt/ceph/
total 16252928
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:30 0802_1M_1
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:31 0802_1M_2
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:31 0802_1M_3
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:32 0802_1M_4
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:33 0802_1M_5
-rw-r--r-- 1 root root  536870912 2011-08-02 14:50 0802_4k_1
-rw-r--r-- 1 root root  536870912 2011-08-02 14:55 0802_4k_2
-rw-r--r-- 1 root root  536870912 2011-08-02 15:01 0802_4k_3
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:21 0802_4M_1
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:22 0802_4M_2
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:23 0802_4M_3
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:23 0802_4M_4
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:24 0802_4M_5
-rw-r--r-- 1 root root 1073741824 2011-08-02 14:24 0802_4M_6
-rw-r--r-- 1 root root  536870912 2011-08-02 14:39 0802_64k_1
-rw-r--r-- 1 root root  536870912 2011-08-02 14:40 0802_64k_2
-rw-r--r-- 1 root root  536870912 2011-08-02 14:41 0802_64k_3
-rw-r--r-- 1 root root  536870912 2011-08-02 14:42 0802_64k_4
-rw-r--r-- 1 root root  536870912 2011-08-02 14:42 0802_64k_5
-rw-r--r-- 1 root root  536870912 2011-08-02 14:43 0802_64k_6

Total data size in cephfs is 15.5 GB.

I run "ceph -s" to check the file system usage, it shows:

root@MON1:~# ceph -s
2011-08-02 15:12:03.476151    pg v946: 1782 pgs: 1782 active+clean;
15995 MB data, 33880 MB used, 38859 GB / 40974 GB avail
2011-08-02 15:12:03.480076   mds e10: 1/1/1 up {0=a=up:active}
2011-08-02 15:12:03.480113   osd e7: 9 osds: 9 up, 9 in
2011-08-02 15:12:03.480183   log 2011-08-02 14:12:32.391116 mon0
192.168.10.1:6789/0 13 : [INF] mds0 192.168.10.2:6800/1716 up:act
2011-08-02 15:12:03.480263   mon e1: 1 mons at {a=192.168.10.1:6789/0}


but when I remove all the file in ceph FS using

root@MON1:~# rm -rf /mnt/ceph/0802_*


I check ceph data used again with ceph -s

root@MON1:~# ceph -s
2011-08-02 15:20:05.265826    pg v958: 1782 pgs: 1782 active+clean;
6779 MB data, 15428 MB used, 38877 GB / 40974 GB avail
2011-08-02 15:20:05.269863   mds e10: 1/1/1 up {0=a=up:active}
2011-08-02 15:20:05.269900   osd e7: 9 osds: 9 up, 9 in
2011-08-02 15:20:05.269965   log 2011-08-02 14:12:32.391116 mon0
192.168.10.1:6789/0 13 : [INF] mds0 192.168.10.2:6800/1716 up:act
2011-08-02 15:20:05.270045   mon e1: 1 mons at {a=192.168.10.1:6789/0}

Make sure that all files are deleted....

root@MON1:~# ls -lh /mnt/ceph/
total 0


Is there anyone know why it still shows {6779 MB data, 15428 MB used}  ?
6779 MB data means?

Thanks for your help. :-)

Best Regard,
Anny
