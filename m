From: Sage Weil <sage@inktank.com>
Subject: Re: 0.48 imminent
Date: Wed, 20 Jun 2012 15:58:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206201556560.14284@cobra.newdream.net>
References: <Pine.LNX.4.64.1206180951570.11790@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55799 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab2FTW6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 18:58:45 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4518ABC806
	for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 15:58:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E06D0BCAF5
	for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 15:58:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206180951570.11790@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Quick update:

We're still working through some issues, so 0.48 will likely land next 
week.  In the meantime, I'm pushing out an 0.47.3 (later tonight) that 
disables the fiemap behavior by default.

sage


On Mon, 18 Jun 2012, Sage Weil wrote:
> v0.48 is essentially ready, but we'd like to test it for a few more days 
> before release.  If you are interested in helping out, it's the 'next' 
> branch of ceph.git.
> 
> A few notes:
> 
>  - There is a disk-format change in this release.  The first time you 
>    start ceph-osd it will do a slowish conversion, and you won't be able 
>    to downgrade.
> 
>  - This will form the basis of our first named 'stable' release.  If you 
>    care what we name it, go vote at
> 
> 	http://bit.ly/LROUnL
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
