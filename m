From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: How to set MDS log size
Date: Wed, 11 Apr 2012 07:33:41 +0000 (UTC)
Message-ID: <loom.20120411T092920-80@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35077 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab2DKHdv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Apr 2012 03:33:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SHs3q-0007m9-38
	for ceph-devel@vger.kernel.org; Wed, 11 Apr 2012 09:33:50 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 09:33:50 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 09:33:50 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
In my MDS system of ceph cluster, my entire root partition is full bcz of 
one big mds log file


[root@ceph-node-7 ceph]# du -sh *
0       mds.admin.log
27G     mds.ceph-node-7.log

[root@ceph-node-7 ceph]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda2              39G   39G     0 100% /
tmpfs                  24G     0   24G   0% /dev/shm
/dev/sda1             2.0G   76M  1.8G   5% /boot
/dev/sda5              19G  409M   18G   3% /ceph

How to set a max size for mds log ? does it auto rotate ? Bcz my root 
partition is full, will this affect read/write performance in
my ceph cluster?

Thanks
Madhusudhana

