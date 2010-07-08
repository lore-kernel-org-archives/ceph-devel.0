From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: bonnie++ issue with Ceph
Date: Thu, 8 Jul 2010 12:59:33 +0000 (UTC)
Message-ID: <i14i3l$hn$2@dough.gmane.org>
References: <201007081449.38981.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49783 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab0GHM7o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 08:59:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWqhb-00044L-87
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 14:59:43 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 14:59:43 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 14:59:43 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 08 Jul 2010 14:49:38 +0200 schrieb Christian Baun:

> Hi,
> When I try to test the performance of a Ceph installation with bonnie++,
> I get this error message:
> 
> Bonnie: drastic I/O error (rmdir): Directory not empty Cleaning up test
> directory after error.
> 
> Is this a known problem?

what version are you using? fuse oder kernel client?

there solved issues in the unstable tree. my bonnie++ tests run fine. 

- Thomas

