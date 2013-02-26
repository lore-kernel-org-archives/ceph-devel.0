From: Sage Weil <sage@inktank.com>
Subject: Re: maintanance on osd host
Date: Tue, 26 Feb 2013 12:02:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302261201220.4819@cobra.newdream.net>
References: <512CCD19.7010509@profihost.ag> <alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net> <727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag> <alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net> <512D10AA.2020906@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab3BZUCu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 15:02:50 -0500
In-Reply-To: <512D10AA.2020906@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 26 Feb 2013, Stefan Priebe wrote:
> Hi Sage,
> 
> Am 26.02.2013 18:24, schrieb Sage Weil:
> > On Tue, 26 Feb 2013, Stefan Priebe - Profihost AG wrote:
> > > But that redults in a 1-3s hickup for all KVM vms. This is not what I
> > > want.
> > 
> > You can do
> > 
> >   kill $pid
> >   ceph osd down $osdid
> > 
> > (or even reverse the order, if the sequence is quick enough) to avoid
> > waiting for the failure detection delay.  But if the OSDs are going down,
> > then the peering has to happen one way or another.
> 
> But exaclty this results in starting backfill immediatly. My idea was to first
> mark the osd down so the mon knows about this fact. So no I/O is stalled. And
> then reboot the whole host but exactly this does not work like expected as
> backfilling is starting immediatly after setting the osd to down ;-(

Backfilling should not happen on down, unless you have reconfigured 'mon 
osd down out interval = 0' or something along those lines.  Setting the 
'noout' flag will also prevent the osds from marking out.

As for limiting the IO stall: you could also do 'ceph osd set noup', 
then mark them down, then kill the daemon, and you won't have to worry 
about racing with the daemon marking itself back up (as it normally does).

sage
