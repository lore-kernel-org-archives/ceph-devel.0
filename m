From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
 forever
Date: Thu, 17 Jun 2010 11:36:58 +0000 (UTC)
Message-ID: <hvd1cq$5tm$3@dough.gmane.org>
References: <hvaqvm$fdp$1@dough.gmane.org>
	<Pine.LNX.4.64.1006161151420.22082@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36499 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519Ab0FQLhI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jun 2010 07:37:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPDP9-0003BA-AM
	for ceph-devel@vger.kernel.org; Thu, 17 Jun 2010 13:37:07 +0200
Received: from cust.dyn.95-152-101-48.swisscomdata.ch ([95.152.101.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 13:37:07 +0200
Received: from thomas by cust.dyn.95-152-101-48.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 13:37:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> I'm hesitant to add a blanket umount timeout, as that could prevent
> proper writeout of cached data/metadata in some cases.  So I think the
> goal should be that if a normal umount hangs for some reason, you should
> be able to intervene to add the 'force' if things don't go well.

the option to force the umount if the regular umount hangs would be really 
cool. 

- Thomas

