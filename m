From: biyan chen <riby.chen@gmail.com>
Subject: I can't ceph file system in writing on file
Date: Wed, 1 Jun 2011 14:42:51 +0800
Message-ID: <BANLkTik4K1we2z85ob-2Bmx1zNETkTj5Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43738 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab1FAGmw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 02:42:52 -0400
Received: by yia27 with SMTP id 27so2092984yia.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 23:42:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When I mount ceph after the file system. I want to go to create a
file, but hint permissions problem, cannot write

In /var/log/ceph log information inside, didn't see more information

[root@ceph_client /]# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1            472658192  20199408 428449108   5% /
tmpfs                  1984548         0   1984548   0% /dev/shm
/dev/loop0             3351190   3351190         0 100% /mnt/cdrom
192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
[root@ceph_client /]# cd /1
[root@ceph_client 1]# echo "1">>1.txt
-bash: 1.txt: Permission denied
[root@ceph_client 1]# cd ..
[root@ceph_client /]# ll
total 112
drwxr-xr-x.  1 root root     0 Jun  1 20:05 1
