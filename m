From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: multi-mds crash: In function 'void
 MDCache::adjust_subtree_auth(CDir*, std::pair<int, int>, bool)
Date: Thu, 30 Sep 2010 20:00:15 +0000 (UTC)
Message-ID: <i82q8f$isi$1@dough.gmane.org>
References: <i82me6$4a8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54059 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756477Ab0I3UA0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Sep 2010 16:00:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1P1PIn-00045P-04
	for ceph-devel@vger.kernel.org; Thu, 30 Sep 2010 22:00:25 +0200
Received: from 46-127-100-83.dclient.hispeed.ch ([46.127.100.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 30 Sep 2010 22:00:24 +0200
Received: from thomas by 46-127-100-83.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 30 Sep 2010 22:00:24 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 30 Sep 2010 18:55:02 +0000 schrieb Thomas Mueller:

> 2010-09-30 20:50:37.350340 7f7ac0f83710 mds0.server  srcdn [dentry
> #1/pdj-fstest/fstest_dee6a1bf32b15e529c858789b95da80d/
fstest_0f57639c4e31382d35f7d80cbf5c01e6/
fstest_3ba1f332cdbc0043df8a732dca0de7bd
> [2,head] rep@2,-2.1 (dn lock) (dversion lock) v=89 inode=0x26560a0
> 0x71c3910]

hmm, seems it I/O was hung already with bonnie++ but i only crashed with
pdj-fstest.

- Thomas

