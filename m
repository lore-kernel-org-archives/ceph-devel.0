From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: service ceph vs. /etc/init.d/ceph
Date: Thu, 8 Jul 2010 15:27:13 +0000 (UTC)
Message-ID: <i14qoh$hn$7@dough.gmane.org>
References: <i14p03$hn$5@dough.gmane.org>
	<1278602038.2253.24.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49431 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab0GHP1Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 11:27:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWt0T-0000dW-Py
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 17:27:21 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 17:27:21 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 17:27:21 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 08 Jul 2010 17:13:58 +0200 schrieb Wido den Hollander:

> Hi Thomas,
> 
> About Debian, your right, the service command is not installed by
> default.
> 
> RHEL, CentOS and Ubuntu all support the "service" command, which makes
> the Wiki usefull for those three distributions.
> 
> I'm not sure what Debian's plan is with the service command, they also
> might install it.
> 
> As far as i know the service command is a part of the Linux Standard
> Base (LSB), so using that would be a good idea.
> 
> I'll change back the Debian specific page.
> 

hmm.. ok you're right. after lenny (5.0) it's in sysvinit-utils which is 
installed an every machine.


- Thomas

