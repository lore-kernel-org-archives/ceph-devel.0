From: Sage Weil <sage@newdream.net>
Subject: Re: [Bug Report] Running git-clone on ceph get "File exists" errors
Date: Fri, 21 May 2010 08:57:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005210851180.11676@cobra.newdream.net>
References: <AANLkTilWmjbZ6OQYbf2L_RvCguqx6EflOMkGtxbrr4RO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41841 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab0EUPyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 May 2010 11:54:15 -0400
In-Reply-To: <AANLkTilWmjbZ6OQYbf2L_RvCguqx6EflOMkGtxbrr4RO@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 21 May 2010, Henry C Chang wrote:
> These errors are similar to the issue mentioned in
> http://ceph.newdream.net/git/?p=ceph-client-standalone.git;a=commit;h=f131f56ea2a09edc5de227975ef7b57ba1592880.
> But, it does not work for my case.
> 
> So, I traced the client and mds logs. It looks like
> ceph_mdsc_do_request() does not handle ERESTARTSYS properly.
> The logs show that the file creation request had been sent to MDS, and
> MDS did complete the request.
> However, before the reply has been received, the request on the client
> side was aborted due to some interrupt.
> VFS got the ERESTARTSYS error and tried to create the file again.
> Since MDS has already created the file, "File exists" errors were returned.
> 
> Then, I replaced "wait_for_completion_interruptible" with
> "wait_for_completion" in ceph_mdsc_do_request().
> The above errors were gone, but I don't feel it is a right way to fix
> it. Any ideas?

Hmm.  The problem is that ideally we want to be able to control-c an 
operation if the mds is slow or hung.  However, hitting control-c triggers 
an ERESTARTSYS, same as a bunch of other signals that come up.

If there is a way for the client to tell that it is retrying the _same_ 
vfs op and somehow match that up with the pending request, then we could 
do that, but I'm skeptical that would work (or be very pretty).  It may be 
we need to drop the ability to control-c on a slow/hung operation.  :/

There is probably a way to tell which signal is pending when we get 
ERESTARTSYS?  I wonder what NFS does in this case?

I created http://tracker.newdream.net/issues/141

sage
