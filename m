From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: [PATCH 1/2] add dkms support
Date: Wed, 28 Jul 2010 17:46:28 +0000 (UTC)
Message-ID: <i2pqdk$8l1$1@dough.gmane.org>
References: <Pine.LNX.4.64.1007280957090.4541@cobra.newdream.net>
	<Pine.LNX.4.64.1007280959400.4541@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41896 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755960Ab0G1Rqk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Jul 2010 13:46:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OeAiD-0005GP-D3
	for ceph-devel@vger.kernel.org; Wed, 28 Jul 2010 19:46:37 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jul 2010 19:46:37 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jul 2010 19:46:37 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 28 Jul 2010 10:02:19 -0700 schrieb Sage Weil:

> BTW, the Debian kernel guys would rather include the ceph module in the
> main kernel package than include a dkms package directly in Debian. 
> That means maintaining a backport branch specifically for 2.6.32 (the
> squeeze kernel).
> 
> (We should still have this dkms package available on the ceph site, of
> course!)

would be cool if they included it in squeeze kernel. but i'm bit 
surprised. squeeze freeze is expected late august (http://
lists.debian.org/debian-devel-announce/2010/06/msg00002.html) and debian 
folks normaly don't bump versions and only do bugfixing after a release. 

so I would expect that squeeze has to include a stable ceph.ko and stable 
server side too. And as the freeze seems to be approaching fast this 
would be a tough schedule.

what leads me to my other question: when will ceph be considered 
"stable"? :)

- Thomas 

