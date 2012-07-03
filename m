From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Throughput increase by LACP bonding
Date: Tue, 3 Jul 2012 07:42:03 +0000 (UTC)
Message-ID: <loom.20120703T093148-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43009 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab2GCHmV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Jul 2012 03:42:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SlxkX-00065z-UW
	for ceph-devel@vger.kernel.org; Tue, 03 Jul 2012 09:42:18 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 09:42:17 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 09:42:17 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I am trying to increase the throughput in the cluster by enabling
LACP on both in clients and all ceph cluster nodes. Each client and 
ceph nodes has two 1G Ethernet interface which I want to aggregate
and make it 2G. LACP has been configured at switch side too. But even after
the configuration, I am not seeing any through put increase in ceph tell osd
bench command and also dd. They are taking the same amount as earlier. I am 
constantly seeing around 100MB/sec throughput in both DD and ceph bench 
commands. Can someone suggest me how i can increase the throughput of the
cluster ? Below are my configurations.

	No of OSD's 	: 5
	No of MON's 	: 3
	No of MDS's	: 2
	Linux Kernel	: 3.4.4
	Ceph version	: 0.47.3
        Hard disks      : 2x160G SAS drives (raid 0 configuration)
        CPU             : Intel(R) Xeon(R) Quad CPU E5506  @ 2.13GHz
        Memory          : 6G

Thanks
__M

