From: Thomas Mueller <thomas@chaschperli.ch>
Subject: compiler warnings on centos5
Date: Thu, 5 Aug 2010 09:49:48 +0000 (UTC)
Message-ID: <i3e1fs$mv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54813 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755711Ab0HEJuG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Aug 2010 05:50:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Ogx5M-0000jh-HR
	for ceph-devel@vger.kernel.org; Thu, 05 Aug 2010 11:50:00 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 11:50:00 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 11:50:00 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

altough my tests are running ok on centos5  there a lots of compiler 
warnings:

http://chaschperli.ch/testing/viewBuildError.php?type=1&buildid=149

I do not seem them on debian.

this is with ceph.git/unstable.

- Thomas

