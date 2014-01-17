From: Sage Weil <sage@inktank.com>
Subject: Re: rados io hints
Date: Fri, 17 Jan 2014 11:16:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401171115060.6273@cobra.newdream.net>
References: <alpine.DEB.2.00.1401171022030.6273@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51802 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbaAQTQB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 14:16:01 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4A61D80446
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 11:16:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1C83E80446
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 11:16:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401171022030.6273@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, 17 Jan 2014, Sage Weil wrote:
> I think we need to add rados operations that provide hints to rados about 
> what the expected object sizes, alignment, and cacheability is.  In 
> particularly, I see two main wins:
> 
>  - knowing that rbd images have a 4m size, librbd can pass a hint that 
> will let the osd do the xfs allocation size ioctl on new files so that 
> they are allocated in 1m or 4m chunks.  We've seen cases where users with 
> rbd workloads have very high levels of fragmentation in xfs and this would 
> mitigate that and probably have a pretty nice performance benefit.
> 
>  - If the rbd (or other client) cache is enabled, we can pass a hint that 
> indicates that the OSD shouldn't keep the object pages around in cache.  
> This would just translate into an fadvise DONTNEED or similar.
> 
> I think the challenge is to keep this as generic as possible from the 
> client's perspetive, but make sure that there is enough information to 
> translate it into a good set of low-level hints to the underlying backend 
> (like alignment size and fadvise).  For example, intuitively the 1m 
> allocation unit sounds about right to me, but rbd would probably 
> communicate to rados that the objects are expected to be 4m each (or 
> whatever the striping strategy is).  I'm thinking the "we shouldn't do an 
> allocation unit more than 1m" logic should live in the FileStore, tunable 
> via a config option?

BTW, my initial thought is this should just be new rados operations, and 
the client should set the FAILOK flag so that older osds will ignore the 
fact that they don't understand the op.

s


