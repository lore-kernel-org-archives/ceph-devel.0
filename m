From: Sage Weil <sage@newdream.net>
Subject: Re: Will the number of objects that have ever existed be infinite?
Date: Sun, 24 May 2015 08:47:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505240840090.6462@cobra.newdream.net>
References: <CAPS90kgipTtHpamtsT6C3ZBugn4djmDW7jXrveEf9FjKY1yoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40855 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbEXPry (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 May 2015 11:47:54 -0400
In-Reply-To: <CAPS90kgipTtHpamtsT6C3ZBugn4djmDW7jXrveEf9FjKY1yoUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?wO7F5sLX?= <lpl6338236@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Li!

On Sat, 23 May 2015, ??? wrote:
> Hello!
> 
> I'm a GSoC student this year and my job is to introduce Missing Rate
> Curve (or reuse distance exactly) of objects into OSD. Now I'm trying
> to find a proper algorithm to implement but there is a problem: Should
> I take the number of objects tracked in an OSD as infinite or
> constant?
> 
> The point is that there is an algorithm that use hash to sample only
> constant number of references to do the analysis and is proved to be
> accurate, which makes it possible to do online MRC construction. That
> accuracy is supported by the fact that the memory addresses is
> bounded, while objects can be deleted and created again and again in
> Ceph. Is is reasonable to think that an OSD only serves bounded number
> of objects in its life time (or the time period that we want to
> compute MRC)?

I don't remember how the object count affects the MRC, but I suspect we 
will want to use a strategy similar to what the HitSets do:

 - a new HitSet is generated on a periodic basis
 - each time a new one is started, we size it based on the previous 
iteration: we can compare the number of HitSet (bloom filter) insertions 
we've done with the resulting filter density.

I think we'll want to build periodic MRCs anyway since the workload will 
shift over time.  Ceph explicitly tracks the number of objects within each 
PG (see pg_stats_t).

Does that help?

sage
