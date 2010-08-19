From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: cmds crash on snaptest-2 (ceph.git/unstable)
Date: Thu, 19 Aug 2010 09:35:04 +0000 (UTC)
Message-ID: <i4its8$icb$1@dough.gmane.org>
References: <i4gvlu$6h8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45739 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab0HSJfT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Aug 2010 05:35:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Om1Wl-00032s-9W
	for ceph-devel@vger.kernel.org; Thu, 19 Aug 2010 11:35:15 +0200
Received: from cust.dyn.95-152-105-180.swisscomdata.ch ([95.152.105.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Aug 2010 11:35:15 +0200
Received: from thomas by cust.dyn.95-152-105-180.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 19 Aug 2010 11:35:15 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> setup: 1x mds, 1x mon, 1x osd , all on the same computer, debian squeeze
> 
> the ceph.git/unstable cmds crashes on snaptest-2 while deleting
> snapshots with rmdir.
> 
> Revision now: 6d0ccd9c7e56dc909a0598b480705298f31fc097 Revision last
> known good: 2921e1350689627d74869b8a593c170ad5515b54
> 

it's fixed. 

thanks.

- Thomas

