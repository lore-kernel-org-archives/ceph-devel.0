From: Sage Weil <sage@newdream.net>
Subject: Re: bufferlist allocation optimization ideas
Date: Tue, 11 Aug 2015 13:10:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508111307540.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40756 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbbHKUKd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 16:10:33 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E3AD08048C
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 13:10:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BDC368048C
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 13:10:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I went ahead and implemented both of these pieces.  See

	https://github.com/ceph/ceph/pull/5534

My benchmark numbers are highly suspect, but the approximate takeaway 
is that it's 2x faster for the simple microbenchmarks and does 1/3rd the 
allocations.  But there is some weird interaction with the allocator going 
on for 16k allocations that I saw, so it needs some more careful 
benchmarking.

The other interesting thing is that either of these pieces in isolation 
seems to have a pretty decent benefit, but when combined the benefits are 
fully additive.

It seems to be reasonably stable, though!

sage
