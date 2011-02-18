From: Mark Nigh <mnigh@netelligent.com>
Subject: A Few Questions about Ceph
Date: Fri, 18 Feb 2011 04:39:23 +0000 (UTC)
Message-ID: <loom.20110218T053907-813@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50058 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab1BREpI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Feb 2011 23:45:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PqIDI-0006fC-Ta
	for ceph-devel@vger.kernel.org; Fri, 18 Feb 2011 05:45:07 +0100
Received: from 99-72-217-5.lightspeed.stlsmo.sbcglobal.net ([99.72.217.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 05:45:04 +0100
Received: from mnigh by 99-72-217-5.lightspeed.stlsmo.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 05:45:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have been doing significant research and testing of Ceph as a long-term
solution for our Cloud Storage Solution. 

I hope this is the right forum to ask a few questions. 

1. I have a 3 node cluster. the first cluster is running the mon, msd and osd0
daemons. The second node is running the osd1 daemon only. I am able to mount the
x.x.x.x:/ /mnt/ceph just fine. I have added a 3 node and am running the osd
daemon only. I don't want to add this node to the placement group of the 1st 2
nodes, but rather add a 4th and have the 3rd and 4th in a placement group. This
would be helpful for different customers or different applications that may or
may not need replication to a second data center. 

2. Is there anyway to create sub-directories in the client mount for example,
mount -t ceph x.x.x.x:/subdirectory /mnt/ceph

I am looking forward to placing ceph into our production network as our backup
target. 

Thank you, 

Mark Nigh 

