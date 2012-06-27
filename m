From: ramu <ramu.freesystems@gmail.com>
Subject: ceph was didn't stop.
Date: Wed, 27 Jun 2012 04:19:39 +0000 (UTC)
Message-ID: <loom.20120627T061404-977@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59923 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2F0ETy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jun 2012 00:19:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SjjjK-0007fT-7D
	for ceph-devel@vger.kernel.org; Wed, 27 Jun 2012 06:19:51 +0200
Received: from segment-124-30.sify.net ([segment-124-30.sify.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 06:19:50 +0200
Received: from ramu.freesystems by segment-124-30.sify.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 06:19:50 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

         I started ceph through /etc/init.d/ -a start,but it was not stop.I tried 
with /etc/init.d/ceph -a stop and /etc/init.d/ceph -v -a stop and 
service ceph -a stop also,there is no error logs showing.I tried with 
/etc/init.d/ceph -a killall it's working but I want stop single osd or mon
 it was not working.Please help me.

Thanks,
Ramu.

