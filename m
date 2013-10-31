From: Sage Weil <sage@inktank.com>
Subject: Re: coverity scan - a plea for help!
Date: Thu, 31 Oct 2013 16:30:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310311627020.5407@cobra.newdream.net>
References: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36834 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab3JaXaZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Oct 2013 19:30:25 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AEFFC8004F
	for <ceph-devel@vger.kernel.org>; Thu, 31 Oct 2013 16:30:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8A4918004F
	for <ceph-devel@vger.kernel.org>; Thu, 31 Oct 2013 16:30:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

When I send this out several months ago, Danny Al-Gaaf stepped up and 
submitted an amazing number of patches cleaning up the most concerning 
issues that Coverity had picked up.  His attention has been directed 
elsewhere more recently, but there are still a number of outstanding 
issues in Coverity's tracker that are reasonably quick and easy to resolve 
and will make our ability to identify newly introduced defects much 
simpler.

Coverity Scan makes it really easy to participate: just create an account 
and I can grant you access to the Ceph project.  If you're interested in 
contributing here (and it's an easy way to quickly start working with the 
Ceph code), let me know!

Thanks-
sage


On Thu, 9 May 2013, Sage Weil wrote:

> We were added to coverity's awesome scan program a while back, which gives 
> free access to their static analysis tool to open source projects.
> 
> Currently it identifies 421 issues.  We've already taken care of the ones 
> that are highest impact, but the usefulness of periodic scans is limited 
> until we can eliminate the noise from the remaining issues and easily see 
> when new problems come up.
> 
> If anybody is interested in helping out in the cleanup effort, let me know 
> and I'll share the login info.  This would provide significant value to 
> our overall quality efforts and is a pretty easy way to make a meaningful 
> contribution to the project without a huge investment in understanding the 
> code and architecture!
> 
> sage
> 
