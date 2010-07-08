From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: "clocks not synchronized" warning message
Date: Thu, 8 Jul 2010 15:04:42 +0000 (UTC)
Message-ID: <i14pea$hn$6@dough.gmane.org>
References: <i14hq2$hn$1@dough.gmane.org>
	<1278598768.2253.18.camel@wido-laptop.pcextreme.nl>
	<i14nfj$hn$4@dough.gmane.org>
	<Pine.LNX.4.64.1007080750200.32514@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57697 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475Ab0GHPEx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 11:04:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWseg-0007Rl-M3
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 17:04:50 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 17:04:50 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 17:04:50 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 08 Jul 2010 07:53:00 -0700 schrieb Sage Weil:

> On Thu, 8 Jul 2010, Thomas Mueller wrote:
> 
>> Am Thu, 08 Jul 2010 16:19:28 +0200 schrieb Wido den Hollander:
>> 
>> > Hi,
>> > 
>> > I'm experiencing the same. The default "mon lease wiggle room" is set
>> > t .001, which gives the messages in my setup.
>> 
>> this is what I just found too - in unstable the default is now 0.010.
>> with 0.5 the message was still there. with 1.0 it was away.
>> 
>> I think 0.010 is still a bit small for a system not connected to a
>> atomic clock? :)
> 
> How about .5 seconds?  We sync our machines to a local ntp server, so
> the clocks get really close (sub-ms).  I forget that NTP isn't so
> accurate over a WAN.
> 
> The issue is that the monitor leases and timeouts are something like 2
> seconds (so that failures/unavailability) are detected quickly, so the
> tolerable clock drift can't get too close to that.
> 
> sage

ok, if this is the problem, then I would also recommend running an ntp 
daemon (not ntpdate) on every node. A running ntpd will manage the 
timesource to be in sync. 

If anyone likes to run an mds/mon on a VM I expect problems - virtualized 
clocksources are far less stable (my experience).

- Thomas 

