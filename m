From: Sage Weil <sage@inktank.com>
Subject: Re: cuttlefish punch list
Date: Mon, 29 Apr 2013 21:05:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304292104500.644@cobra.newdream.net>
References: <alpine.DEB.2.00.1304290837260.644@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41581 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3D3EF7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 00:05:59 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DCFA280049
	for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 21:05:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DAB0480049
	for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 21:05:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304290837260.644@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Mon, 29 Apr 2013, Sage Weil wrote:
> There are two big items I'm concerned about:
> 
> #4815, and the other large monitor store problems with syncing and failure 
> to get quorum.  We need to confirm
>  - why the sync is failing and we're hitting that assert, and
>  - why the store.db's are growing so huge

This appears to be a bad interaction between the mon workload and levedb's 
compaction heuristics.  We've worked around it in wip-mon-compact; anyone 
who has seen large mon stores and/or a failure to sync, please try this 
branch!

> #4853: This is triggered by one of the upgrade tests and looks like it 
> could be a regression from the client request replay fix last week.

Fixed.

> A few other things:
> 
>  - the rgw upgrade tests are failing because the s3tests, readwrite, and 
>    swift tasks can't be rung twice in a row.

Running now.

>  - ceph release build needs to include raring.
>  - ceph-deploy build needs to include raring too.

Tomorrow.

Thanks everyone!  We're close!
sage
