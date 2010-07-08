From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: "clocks not synchronized" warning message
Date: Thu, 8 Jul 2010 14:31:16 +0000 (UTC)
Message-ID: <i14nfj$hn$4@dough.gmane.org>
References: <i14hq2$hn$1@dough.gmane.org>
	<1278598768.2253.18.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59323 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab0GHOb2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 10:31:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWs8M-0005Pk-M5
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 16:31:26 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 16:31:26 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 16:31:26 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 08 Jul 2010 16:19:28 +0200 schrieb Wido den Hollander:

> Hi,
> 
> I'm experiencing the same. The default "mon lease wiggle room" is set t
> .001, which gives the messages in my setup.

this is what I just found too - in unstable the default is now 0.010.  
with 0.5 the message was still there. with 1.0 it was away.

I think 0.010 is still a bit small for a system not connected to a atomic 
clock? :)



> 
> Right now i've set the room to 0.5, which gets rid of the messages, but
> obviously this is imho not the way to go.
> 
> My nodes are running openntpd and a cron which runs ntpdate every hour.

openntpd and ntpdate? IMHO if you are running the daemon ntpdate can't run 
- at least with the debian ntp package.


- Thomas

