From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-client.git master
Date: Mon, 30 Jan 2012 13:45:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201301343310.23054@cobra.newdream.net>
References: <Pine.LNX.4.64.1201290858380.12891@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41366 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2A3Vpt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 16:45:49 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DC299BC7EC
	for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 13:45:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A9B42BC7EC
	for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 13:45:48 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201290858380.12891@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Okay, Alex and I chatted and here is the new plan for ceph-client.git:

 master    -- tested, reviewed, "stable."  won't be rebased without warning.
 testing   -- integration branch.  used by nightly qa runs.  rebased often.

and 

 for-linus -- for Linus.

That is all! :)
sage



> I pulled Chris's btrfs for-linus branch into ceph-client.git master for 
> the benefit of our qa runs (which use the same kernel on the client and 
> server side).  This makes the master even more of a mess than it already 
> was.
> 
> Alex, what do you think?  Right now the branches are roughly:
> 
>  for-next  -- tested and reviewed, for next window
>  master    -- lightly tested.  this is what qa runs against.
>  for-linus -- for linus to pull now.. either for -rc or current window.
> 
> We could make master the reviewed+tested branch, and do a 'testing' 
> branch for the free-for-all, so that it's clearer to people that it's 
> untested, likely to be rebased, etc.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
