From: Sage Weil <sage@newdream.net>
Subject: Re: v0.42 released
Date: Tue, 21 Feb 2012 13:12:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202211303090.20783@cobra.newdream.net>
References: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
 <102297594.gHJqPtTriy@pc10>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58446 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2BUVMe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 16:12:34 -0500
In-Reply-To: <102297594.gHJqPtTriy@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 21 Feb 2012, Guido Winkelmann wrote:
> Am Montag, 20. Februar 2012, 10:01:55 schrieben Sie:
> > v0.42 is ready!  This has mostly been a stabilization release, with a few
> > critical bugs fixed.  There is also an across-the-board change in data
> > structure encoding that is not backwards-compatible, but is designed to
> > allow future changes to be (both forwards- and backwards-).
> 
> Okay, what does that mean for updating from 0.41 to 0.42?
> 
> With data structure encodings, do you mean on-disk or on-wire? Am I at 
> risk of losing all my data?

Both.  You won't lose any data (new code can real old structures), but it 
means that once you move to v0.42 you can't go back to v0.41.  That 
happens periodically (and unpredictably) in the past.  The whole point of 
this change it to allow downgrades and better interoperation between 
versions (so that old code can read new structures).

> Do I have to bring down the entire cluster and restart it, or can I 
> restart it piecemeal to avoid downtimes?

In this case, you can do a sloppy upgrade and nothing will break.  v0.41 
daemons won't talk to v0.42 daemons.

> Can clients that still use 0.41 libs keep running?

Yes.  The only incompatible change in the client protocol is for rados 
pool listing (e.g., rados -p data ls -).  I would upgrade them when 
you get a chance, though.

sage
