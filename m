From: Sage Weil <sage@newdream.net>
Subject: Re: weight VS crush weight when doing osd reweight
Date: Tue, 21 Oct 2014 06:24:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410210621060.10837@cobra.newdream.net>
References: <D06AAD30.3328%leidong@yahoo-inc.com> <alpine.DEB.2.00.1410200756130.10837@cobra.newdream.net> <D06BE1E6.33C1%leidong@yahoo-inc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57686 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbaJUNYf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 09:24:35 -0400
In-Reply-To: <D06BE1E6.33C1%leidong@yahoo-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lei Dong <leidong@yahoo-inc.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 21 Oct 2014, Lei Dong wrote:
> Thanks Sage!
> So you mean:
> 
> 1. Choose step will not be affected by OSD weight(but only CRUSH weight).

Yes, if the choose type is not 'osd'.

> 2. Chooseleaf step will be affected by both the two weights. But with a
> big variation in CRUSH weight and small OSD number, CRUSH works
> inefficiently to make the distribution even although we can adjust OSD
> weight.
> 
> Right?

Right.

As a simple example, let's say we're picking 2 replicas and the weights 
are [1, 2, 1].  It's pretty obvious that the only two choices are a,b and 
b,c, but CRUSH will have a very hard time with this because it is doing an 
independent selection for each position.  Things get harder as the number 
of replicas increases..

sage


> 
> LeiDong
> 
> On 10/20/14, 11:03 PM, "Sage Weil" <sage@newdream.net> wrote:
> 
> >On Mon, 20 Oct 2014, Lei Dong wrote:
> >> Hi sage:
> >> 
> >> As you said at https://github.com/ceph/ceph/pull/2199, adjusting weight
> >>or
> >> crush weight should be both effective at any case. We?ve encounter a
> >>situation
> >> in which it seems adjusting weight is far less effective than adjusting
> >> crush weight. 
> >> 
> >> We use 6 racks with host number {9, 5, 9, 4, 9, 4} and 11 osds at each
> >>host.
> >> We created a crush rule for ec pool to survive rack failure:
> >> 
> >> ruleset ecrule {
> >>         ?
> >>         min_size 11
> >>         max_size 11
> >>         step set_chooseleaf_tries 50
> >> step take default
> >> step choose firstn 4 type rack // we want the distribution to be {3, 3,
> >>3,
> >> 2} for k=8 m=3
> >> step chooseleaf indep 3 type host
> >>       step emit
> >> }
> >> 
> >> After creation of the pool, we run osd reweight-by-pg many times, the
> >>best
> >> result it can reach is
> >> Average PGs/OSD (expected): 225.28
> >> Max PGs/OSD: 307
> >> Min PGs/OSD: 164
> >> 
> >> Then we run our own tool to reweight(same strategy with reweight-by-pg,
> >>just
> >> adjust crush weight instead of weight),  the best result is:
> >> Average PGs/OSD (expected): 225.28
> >> Max PGs/OSD: 241
> >> Min PGs/OSD: 207
> >> Which is much better than the previous one.
> >> 
> >> According to my understanding, due to uneven host numbers across rack,
> >>  for ?step choose firstn 4 type rack?:
> >>  1. If we adjust osd weight,  this step is almost unaffected and
> >>     will dispatch almost even pg number for each rack. Thus the host in
> >>the
> >>     rack which have less host will take more pgs, no matter how we
> >>adjust
> >>     weight. 
> >>  2. If we adjust osd crush weight, this step is affected and will try to
> >>     dispatch more pg to the rack which has higher crush weight value,
> >>thus
> >>     the result can be even.
> >> Am I right about this?
> >
> >I think so, yes.  I am a bit surprised that this is a problem, though.
> >We 
> >will still be distributing PGs based on the relative CRUSH weights, and I
> >would not expect that the expected variation will lead to very much skew
> >between racks.
> >
> >It may be that CRUSH is, at baseline, having trouble respecting your
> >weights.  You might try creating a single straw bucket with 6 OSDs and
> >those weights (9, 5, 9, 4, 9, 4) and see if it is able to achieve a
> >correct distribution.  When there is a lot of variation in weights and
> >the 
> >total number of items are small it can be hard for it to get to the right
> >result.  (We were just looking into a similar problem on another cluster
> >on Friday.)
> >
> >For a more typical chooseleaf the osd weight will have the intended
> >behavior, but when the initial step is a regular choose only the CRUSH
> >weights affect the decision.  My guess is that your process of skewing
> >the 
> >CRUSH weights pretty dramatically which is able to compensate for the
> >difficulty/improbability of randomly choosing racks with the right
> >frequency...
> >
> >sage
> >
> >> We then do a further test with 6 racks and 9 hosts in each rack. In this
> >> situation, adjusting weight or adjusting crush weight has almost the
> >>same
> >> effect.
> >>
> >> So, weight and crush weight do impact the result of CRUSH in a different
> >> way? 
> 
> 
