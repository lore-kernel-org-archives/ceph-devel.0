From: Sage Weil <sage@newdream.net>
Subject: Re: Open bugs - jewel
Date: Wed, 6 Apr 2016 16:51:35 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604051017150.19675@cpach.fuggernut.com>
References: <CAMMFjmEcRDXLxRJYRPvtxdpTAJ6-6_Nydr1B6D5zrq4V6a7e0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56953 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbcDFUvn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 16:51:43 -0400
In-Reply-To: <CAMMFjmEcRDXLxRJYRPvtxdpTAJ6-6_Nydr1B6D5zrq4V6a7e0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

On Mon, 4 Apr 2016, Yuri Weinstein wrote:
> We have a custom query [1] in the tracker that lists all open bugs
> across projects for the jewel release.
> 
> It should help as a single reference point for remaining issues in this release.
> 
> If you don't see an issue(s) on this list that should be prioritized
> and fixed by the development leads - please make sure to assign
> "Release:" field.  Also please assign "ceph-qa-suite:" field as it
> helps finding a set of issues against our QA suites and makes it
> easier to re-test fixes.
> 
> Suggestions and questions are welcome!
> 
> [1] - "Open bugs - jewel" http://tracker.ceph.com/issues?query_id=92

[Sorry, keep forgetting I haven't replied to this yet!]

We talked about this in the Monday call and the thinking was that simply 
setting the priority to urgent or immediate will be sufficient to track 
the blocking bugs for the jewel release.  The concern is that if we use 
the version fields explicitly it'll be a lot of effort to maintain and 
keep accurate, limiting it's usefulness, and we are (or should be) already 
looking at the overall 'bug queue' query already (which covers all 
versions, by priority).

sage
