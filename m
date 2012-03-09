From: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Subject: mount via ceph-fuse is failing
Date: Fri, 9 Mar 2012 07:18:27 +0000 (UTC)
Message-ID: <loom.20120309T081725-352@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36580 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab2CIHSm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Mar 2012 02:18:42 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S5u63-0008IQ-LO
	for ceph-devel@vger.kernel.org; Fri, 09 Mar 2012 08:18:39 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 08:18:39 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 09 Mar 2012 08:18:39 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
When i try to mount ceph file systems via fuse, its failing. 


[root@ceph-node-9 ~]# ceph-fuse -m 10.25.12.123,10.25.12.124,10.25.12.125:/ 
/mnt/macharya_ceph/
ceph-fuse[18533]: starting ceph client
ceph-fuse[18533]: starting fuse
fuse: unknown option `big_writes'
2012-03-08 23:12:52.100276 7ffff7ab3760 fuse_lowlevel_new failed
ceph-fuse[18533]: fuse finished with error 33
ceph-fuse[18532]: mount failed: (33) Numerical argument out of domain


what can be the issue ? 

Thanks
__M

