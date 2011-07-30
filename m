From: Fyodor Ustinov <ufm@ufm.su>
Subject: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 12:38:09 +0300
Message-ID: <4E33D101.1050504@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:43569 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab1G3JiN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 05:38:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 12D61600247
	for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2011 12:38:11 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3D7YppNPXFK for <ceph-devel@vger.kernel.org>;
	Sat, 30 Jul 2011 12:38:11 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id E6461600245
	for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2011 12:38:10 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

fail. Epic fail.

Absolutely reproducible.

I have ceph cluster with this configuration:

8 physical servers
14 osd servers.
Each osd server have personal fs.
48T total size of ceph cluster.
17T used.

Now, step by step:

1. Stop ceph server osd0
/etc/init.d/ceph stop

2. Make fresh fs for osd
umount /osd.0
mkfs.ext4 /dev/sdc1
tune2fs -o journal_data_writeback /dev/sdc1
mount -a
# string from /etc/fstab:
# /dev/sdc1 /osd.0          ext4    
user_xattr,rw,noexec,nodev,noatime,nodiratime,data=writeback,barrier=0        
0       2
ceph mon getmap -o /tmp/monmap
cosd --mkfs -i 0 --monmap /tmp/monmap

3. Start ceph server osd0
/etc/init.d/ceph start

Now, make a big cup of coffee and begin to wait.

After completion of rebalancing do:
/etc/init.d/ceph stop
umount /osd.0
fsck.ext4 -fy /dev/sdc1

and see many-many messages like:

Inode 238551053, i_blocks is 24, should be 32.  Fix? yes

Inode 238551054, i_blocks is 40, should be 32.  Fix? yes

Inode 238551066, i_blocks is 24, should be 32.  Fix? yes

Inode 238944257, i_blocks is 8, should be 16.  Fix? yes

Inode 239206414, i_blocks is 8, should be 16.  Fix? yes

Inode 239206416, i_blocks is 40, should be 32.  Fix? yes

Inode 239206431, i_blocks is 8, should be 16.  Fix? yes

Inode 239206441, i_blocks is 24, should be 32.  Fix? yes

Voila.

P.S. No any message in syslog. No any message in console.

WBR,
     Fyodor.

