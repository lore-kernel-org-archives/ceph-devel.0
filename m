From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: bonnie++ issue with Ceph
Date: Thu, 8 Jul 2010 13:40:09 +0000 (UTC)
Message-ID: <i14kfp$hn$3@dough.gmane.org>
References: <201007081449.38981.cray@unix-ag.uni-kl.de>
	<i14i3l$hn$2@dough.gmane.org> <201007081514.45970.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53499 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756819Ab0GHNkW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 09:40:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWrKv-0007Tx-CL
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 15:40:21 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 15:40:21 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 15:40:21 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 08 Jul 2010 15:14:45 +0200 schrieb Christian Baun:

> Hi Thomas,
> 
> I use ceph-kclient-0.20 with ceph-0.20
> 
> Should I try a newer version?

give ceph.git/unstable a try - it will work there.

... use also ceph-client-standalone.git/unstable-backport with it.



- Thomas

