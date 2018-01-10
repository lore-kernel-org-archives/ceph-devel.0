From: Sage Weil <sage@newdream.net>
Subject: Re: Luminous - replace old target-weight tree from osdmap with mgr
 balancer
Date: Wed, 10 Jan 2018 21:56:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801102151470.8186@piezo.novalocal>
References: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag> <alpine.DEB.2.11.1801102123260.8186@piezo.novalocal> <e638d77d-104f-a224-579b-a960fab90732@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:48855 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeAJV44 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 16:56:56 -0500
In-Reply-To: <e638d77d-104f-a224-579b-a960fab90732@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
> Am 10.01.2018 um 22:23 schrieb Sage Weil:
> > On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
> >> k,
> >>
> >> in the past we used the python crush optimize tool to reweight the osd
> >> usage - it inserted a 2nd tree with $hostname-target-weight as hostnames.
> > 
> > Can you attach a 'ceph osd crush tree' (or partial output) so I can see 
> > what you mean?
> 
> Sure - attached.

Got it

> >> Now the quesions are:
> >> 1.) can we remove the tree? How?
> >> 2.) Can we do this now or only after all clients are running Luminous?
> >> 3.) is it enought to enable the mgr balancer module?

First,

 ceph osd crush weight-set create-compat

then for each osd,
 ceph osd crush weight-set reweight-compat <osd> <optimized-weight>
 ceph osd crush reweight <osd> <target-weight>

That won't move any data but will keep your current optimized weights in 
the compat weight-set where they belong.

Then you can remove the *-target-weight buckets.  For each osd,

 ceph osd crush rm <osd> <ancestor>-target-weight

and then for each remaining bucket

 ceph osd crush rm <foo>-target-weight

Finally, turn on the balancer (or test it to see what it it wants to do 
with the optimize command.)

HTH!
sage
