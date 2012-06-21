From: ramu <ramu.freesystems@gmail.com>
Subject: ceph init script didn't stop the ceph.
Date: Thu, 21 Jun 2012 11:35:10 +0000 (UTC)
Message-ID: <loom.20120621T131015-713@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40805 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759273Ab2FULfY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jun 2012 07:35:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ShffU-00045k-RF
	for ceph-devel@vger.kernel.org; Thu, 21 Jun 2012 13:35:21 +0200
Received: from segment-124-30.sify.net ([segment-124-30.sify.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 13:35:20 +0200
Received: from ramu.freesystems by segment-124-30.sify.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 13:35:20 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

The sudo /etc/init.d/ceph -a stop script command was didn't stop the ceph.
I tried with the version ceph-0.47.3 also ,but it was not stopping.
The sudo /etc/init.d/ceph -a start is working fine.
And i tried with the sudo /etc/init.d/ceph -a killall it's working fine but when 
iam stop the single osd it is not working.please help me.

Thanks,
Ramu.

