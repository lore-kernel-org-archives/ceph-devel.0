From: Sage Weil <sage@newdream.net>
Subject: Re: cephfs survey results
Date: Tue, 4 Nov 2014 01:02:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411040057280.15135@cobra.newdream.net>
References: <alpine.DEB.2.00.1411030649070.15135@cobra.newdream.net> <CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48689 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaKDJCV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 04:02:21 -0500
In-Reply-To: <CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

On Tue, 4 Nov 2014, Blair Bethwaite wrote:
> On 4 November 2014 01:50, Sage Weil <sage@newdream.net> wrote:
> > In the Ceph session at the OpenStack summit someone asked what the CephFS
> > survey results looked like.
> 
> Thanks Sage, that was me!
> 
> >  Here's the link:
> >
> >         https://www.surveymonkey.com/results/SM-L5JV7WXL/
> >
> > In short, people want
> >
> > fsck
> > multimds
> > snapshots
> > quotas
> 
> TBH I'm a bit surprised by a couple of these and hope maybe you guys
> will apply a certain amount of filtering on this...
> 
> fsck and quotas were there for me, but multimds and snapshots are what
> I'd consider "icing" features - they're nice to have but not on the
> critical path to using cephfs instead of e.g. nfs in a production
> setting. I'd have thought stuff like small file performance and
> gateway support was much more relevant to uptake and
> positive/pain-free UX. Interested to hear others rationale here.

Yeah, I agree, and am taking the results with a grain of salt.  I 
think the results are heavily influenced by the order they were 
originally listed (I whish surveymonkey would randomize is for each 
person or something).

fsck is a clear #1.  Everybody wants multimds, but I think very few 
actually need it at this point.  We'll be merging a soft quota patch 
shortly, and things like performance (adding the inline data support to 
the kernel client, for instance) will probably compete with getting 
snapshots working (as part of a larger subvolume infrastructure).  That's 
my guess at least; for now, we're really focused on fsck and hard 
usability edges and haven't set priorities beyond that.

We're definitely interested in hearing feedback on this strategy, and on 
peoples' experiences with giant so far...

sage
