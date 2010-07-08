From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: "clocks not synchronized" warning message
Date: Thu, 8 Jul 2010 15:44:07 +0000 (UTC)
Message-ID: <i14ro7$hn$8@dough.gmane.org>
References: <i14hq2$hn$1@dough.gmane.org>
	<1278598768.2253.18.camel@wido-laptop.pcextreme.nl>
	<i14nfj$hn$4@dough.gmane.org>
	<Pine.LNX.4.64.1007080750200.32514@cobra.newdream.net>
	<i14pea$hn$6@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53202 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545Ab0GHPoZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 11:44:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWtGw-00072Q-5F
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 17:44:22 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 17:44:22 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 17:44:22 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


>> 
>> How about .5 seconds?  We sync our machines to a local ntp server, so
>> the clocks get really close (sub-ms).  I forget that NTP isn't so
>> accurate over a WAN.
>> 
>> The issue is that the monitor leases and timeouts are something like 2
>> seconds (so that failures/unavailability) are detected quickly, so the
>> tolerable clock drift can't get too close to that.
>> 
>> sage
> 
> ok, if this is the problem, then I would also recommend running an ntp
> daemon (not ntpdate) on every node. A running ntpd will manage the
> timesource to be in sync.
> 
> If anyone likes to run an mds/mon on a VM I expect problems -
> virtualized clocksources are far less stable (my experience).
> 

started the ntpd on the nodes. now i'm able to run it with "mon lease 
wiggle room = 0.1".

as Wido is using ntpdate and he's successfull with 0.5 I would say 0.5 is 
possible a good default.  

- Thomas

