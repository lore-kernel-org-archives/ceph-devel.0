From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Performance test on Ceph cluster
Date: Wed, 22 Feb 2012 09:39:00 +0000 (UTC)
Message-ID: <loom.20120222T102830-526@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43680 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab2BVJjO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Feb 2012 04:39:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S08fG-0002Dq-NS
	for ceph-devel@vger.kernel.org; Wed, 22 Feb 2012 10:39:10 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 10:39:10 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 10:39:10 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I have finally configured a ceph cluster with 8 nodes. I have 2 MDS
servers and 3 monitors and rest of 3 nodes are OSD. Each system has
2T SATA drives. I have 3 partitions created, one for root file
system, another for CEPH journal and the rest of the space is for
OSD. I was able to get 5.6T space from three nodes. 

All the machines are of same type (HP DL160 G7) with 48 of RAM and 
quad core dual cpu's. 

I am using iozone for testing the performance against NetApp filer
Below is the command what I am using for iozone test

/opt/iozone/bin/iozone -R -e -l i -u 1 -r 4096k -s 1024m -F /mnt/ceph-
test/ceph.iozone

When I see the result, the value from ceph cluster is not at all
coming near to an entry level NetApp filer. I would like to
know the ideal way (if there is any) for testing ceph cluster 
performance so that we can compare it with other file systems.
If required, I can share the test results.


Any suggestion greatly appreciated.

Thanks
__madhusudhan

