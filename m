From: Sage Weil <sage@inktank.com>
Subject: Re: Osd placement rule questions
Date: Wed, 4 Jul 2012 20:57:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207042055350.6931@cobra.newdream.net>
References: <4FF50DD2.6030507@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48731 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab2GED5K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 23:57:10 -0400
In-Reply-To: <4FF50DD2.6030507@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: ceph-devel@vger.kernel.org

On Thu, 5 Jul 2012, Mark Kirkwood wrote:
> Hi,
> 
> I am experimenting with ceph (rbd only for now), and have a few questions
> about what is possible via placement rules.
> 
> For example I am looking at a setup with a local datacenter (datacenter0) and
> a remote one (datacenter1). I'm using a placement rule:
> 
> rule rbd {
>         ruleset 2
>         type replicated
>         min_size 1
>         max_size 10
>         step take datacenter0
>         step chooseleaf firstn -1 type host
>         step emit
>         step take datacenter1
>         step chooseleaf firstn 1 type host
>         step emit
> }
> 
> and I have the rdb pool set to size 3.
> 
> So I *think* I am saying I want 2 replicas in datacenter0 and one in
> datacenter1 [1].

That's right!

> The questions I have are:
> 
> 1/ I would like to be able to have a way to say something like: Make 2 copies
> at datacenter0, 1 at datacenter1 - wait for the ones at datacenter0 to be
> written but not the ones at datacenter1 (so asynchronous for the latter). Is
> this possible, or planned?

It is not possible yet, but planned for the future.

> 2/ Also I would like to be able to say make my number of copies 3, but if I
> lose datacenter0 (where 2 copies are), don't try to have 3 copies at
> datacenter1 (so run degraded in that case). Is that possible?

That is what you get now.  Doing the opposite (2 copies in DC1, 1 in DC2, 
but if DC2 is down 3 in DC1) is not currently possible with the crush 
rules.

sage
