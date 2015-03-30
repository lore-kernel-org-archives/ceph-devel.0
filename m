From: Sage Weil <sage@newdream.net>
Subject: Re: ceph versions
Date: Mon, 30 Mar 2015 13:01:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503301130050.31431@cobra.newdream.net>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33510 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbbC3UBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 16:01:54 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4BDB48133F
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2015 13:01:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 259C78133F
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2015 13:01:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Resurrecting this thread since we need to make a decision soon.  The 
opinions broke down like so:

 A - me
 B - john
 C - alex
 D - loic (and drop release names), yehuda, ilya
 openstack - dmsimard

So, most people seem to like D (below):

On Thu, 26 Feb 2015, Sage Weil wrote:
> -- Option D -- "labeled"
> 
> X.Y-{dev,rc,release}Z
> 
>  - Increment Y on each major named release
>  - Increment X if it's a major major named release (bigger change 
> than usual)
>  - Use dev, rc, or release prefix to clearly label what type of release 
> this is
>  - Increment Z for stable updates
> 
>  1.0-dev1 first infernalis dev release
>  1.0-dev2 another dev release
>  ...
>  1.0-rc1 first rc
>  1.0-rc2 next rc
>  1.0-release1 final release
>  1.0-release2 stable update
>  1.0-release3 stable update
>  1.1-dev1 first cut for j-release
>  1.1-dev2 ...
>  ...
>  1.1-rc1
>  1.1-release1 stable
>  1.1-release2 stable
>  1.1-release3 stable

This initialy made me a bit sad because it wasn't my favorite.  My 
aesthetic issues aside, though, I think more explicit dev vs release 
distinction is important and useful.  I think the main issue is the 
strings in the version which will cause pain for some distros.

Would this make sense instead?

 x.0.z - development releases
 x.1.z - release candidate(s)
 x.2.z - release and bugfix updates

John preferred B (even/odd) because it encodes the important info in the 
x.y portion of the version; I think the above does that too, and a bit 
more succinctly.

What do you think?

If that works for people, the follow-up question is what initial X value 
we should choose.  We could go with 1 (and live with the baggage 
associated with what "1.0" is supposed to mean), or with 9 (J is the 9th 
letter).  And if we do that, should we make the hammer release 8.2.0 or 
stick with 0.94?

sage
