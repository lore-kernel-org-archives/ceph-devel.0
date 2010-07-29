From: Thomas Mueller <thomas@chaschperli.ch>
Subject: thounds of files in monX/logm dir
Date: Thu, 29 Jul 2010 15:30:46 +0000 (UTC)
Message-ID: <i2s6r5$33r$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60702 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757352Ab0G2PbA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jul 2010 11:31:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OeV4T-0004uU-3K
	for ceph-devel@vger.kernel.org; Thu, 29 Jul 2010 17:30:57 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 17:30:57 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 17:30:57 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

had running a 4 node cluster with 3mon,3mds,4osd for a while with no one 
accessing it (actually nobody mounted it, i just forgot to stop the 
services). this was about ceph.git/unstable a month ago.

today i've upgraded to the latest ceph.git/unstable . to start over I 
deleted the ceph data completly. 

after 3mins of deleting i got curious.

every of the 3 mon nodes got about 530'000 files in the monX/logm dir.

is this expected?

- Thomas

