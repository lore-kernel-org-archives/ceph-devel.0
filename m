From: Maxim Mikheev <mikhmv@gmail.com>
Subject: Ceph copy-on-write
Date: Thu, 03 Nov 2011 23:09:08 -0400
Message-ID: <4EB35754.1040506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65351 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1KDDJK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 23:09:10 -0400
Received: by vcbf1 with SMTP id f1so1092vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 20:09:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Friends,

Is Ceph copy on write system?
If so, I think I do something wrong.
Files copying take too much time and disks space in my Ceph installation.
Could you like to help me resolve my problem?

I am using Ubuntu 11.10 server with ceph packages from ubuntu repository 
(v. 0.34-1).
-------------------------------------------------------------------------------------------------
df -h
192.168.2.11:/OpenNebula/           1417063424  25535488 1228367872   3% 
/srv/ceph/OpenNebula

oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$ date; cp -rv 
W7-Peter.iso temp/ ; date
Thu Nov  3 21:01:13 EDT 2011
`W7-Peter.iso' -> `temp/W7-Peter.iso'
Thu Nov  3 21:03:02 EDT 2011
oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$

df -h
192.168.2.11:/OpenNebula/         1417063424  29011968 1224902656   3% 
/srv/ceph/OpenNebula

oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$ ls -la
total 3149408
drwxr-xr-x 1 oneadmin cloud  6449987584 2011-11-03 20:18 .
drwxr-xr-x 1 oneadmin cloud 18997465448 2011-11-03 19:20 ..
drwxr-xr-x 1 oneadmin cloud  3224993792 2011-11-03 21:01 temp
-rw-r--r-- 1 oneadmin cloud  3224993792 2011-11-03 19:29 W7-Peter.iso
oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$

mount:
/dev/sda3 on /srv/osd.1 type btrfs (rw,noatime)
192.168.2.11:/OpenNebula/ on /srv/ceph/OpenNebula type ceph 
(name=admin,key=client.admin)

-----------------------------------------------------------------------
it took 129 seconds ~ 30 Mb/s. It is great rate for network file system 
but it is not good for "copy-on-write" system

other operations work well:
------------------------------------------
oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$ date; mv -v 
W7-Peter.iso temp/ ; date
Thu Nov  3 21:11:15 EDT 2011
`W7-Peter.iso' -> `temp/W7-Peter.iso'
Thu Nov  3 21:11:15 EDT 2011

oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$ date; mkdir 
.snap/my_snapshot; date
Thu Nov  3 22:57:24 EDT 2011
Thu Nov  3 22:57:25 EDT 2011
oneadmin@s2-8core:/srv/ceph/OpenNebula/one/tests$

Thanks,
     Max
