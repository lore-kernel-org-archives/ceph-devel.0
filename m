From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Sat, 16 Feb 2013 09:05:21 +1100
Message-ID: <20130215220521.GA29999@onthe.net.au>
References: <20130215032939.GA25578@onthe.net.au>
 <alpine.DEB.2.00.1302142051250.19927@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:54449 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab3BOWFY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Feb 2013 17:05:24 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302142051250.19927@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

G'day Sage,

On Thu, Feb 14, 2013 at 08:57:11PM -0800, Sage Weil wrote:
> On Fri, 15 Feb 2013, Chris Dunlop wrote:
>> In an otherwise seemingly healthy cluster (ceph 0.56.2), what might cause the
>> mons to lose touch with the osds?
> 
> Can you enable 'debug ms = 1' on the mons and leave them that way, in the 
> hopes that this happens again?  It will give us more information to go on.

Debug turned on.

>> Perhaps the mon lost osd.1 because it was too slow, but that hadn't happened in
>> any of the many previous "slow requests" intances, and the timing doesn't look
>> quite right: the mon complains it hasn't heard from osd.0 since 20:11:19, but
>> the osd.0 log shows nothing problems at all, then the mon complains about not
>> having heard from osd.1 since 20:11:21, whereas the first indication of trouble
>> on osd.1 was the request from 20:26:20 not being processed in a timely fashion.
> 
> My guess is the above was a side-effect of osd.0 being marked out.   On 
> 0.56.2 there is some strange peering workqueue laggyness that could 
> potentially contribute as well.  I recommend moving to 0.56.3.

Upgraded to 0.56.3.

>> Trying to manually set the osds in (e.g. ceph osd in 0) didn't help, nor did
>> restarting the osds ('service ceph restart osd' on each osd host).
>> 
>> The immediate issue was resolved by restarting ceph completely on one of the
>> mon/osd hosts (service ceph restart). Possibly a restart of just the mon would
>> have been sufficient.
> 
> Did you notice that the osds you restarted didn't immediately mark 
> themselves in?  Again, it could be explained by the peering wq issue, 
> especially if there are pools in your cluster that are not getting any IO.

Sorry, no. I was kicking myself later for losing the 'ceph -s' output 
when I killed that terminal session but in the heat of the moment...

I can't see anything about osd marking themselves in from the logs from the
time (with no debugging), but I'm on my ipad at the moment so I could easily
have missed it. Should that info be in the logs somewhere?

There's certainly unused pools: we're only using the rbd pool and so the
default data and metadata pools are unused.

Thanks for your attention!

Cheers,

Chris
