From: Thomas Mueller <thomas@chaschperli.ch>
Subject: service ceph vs. /etc/init.d/ceph
Date: Thu, 8 Jul 2010 14:57:07 +0000 (UTC)
Message-ID: <i14p03$hn$5@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51962 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639Ab0GHO5R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 10:57:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWsXL-0001Im-MH
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 16:57:15 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 16:57:15 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 16:57:15 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi wido

i see you replacing "/etc/init.d/ceph" with  "service ceph" .

The service thing does not exist on debian. IMHO /etc/init.d/ceph working 
for all - so may we have it called /etc/init.d/ceph instead of "service 
ceph"?

Or at least on debian specific pages please do not change it.

- Thomas

