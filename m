From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 10:52:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105251050030.29945@cobra.newdream.net>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov> <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
 <20110525110118.GA6872@systemlinux.org> <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
 <20110525173338.GI20417@systemlinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1EYRvg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 13:51:36 -0400
In-Reply-To: <20110525173338.GI20417@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 May 2011, Andre Noll wrote:
> On Wed, May 25, 09:16, Sage Weil wrote:
> > > It's trivial to reproduce: Executing "ls -l" on one client while
> > > another client is writing causes the ls command to hang indefinitely.
> > 
> > This was recently fixed in the master branch, commit
> > ee7fa813ef29890557f0b03bd3950d422484215d.  It hasn't made it into any  
> > releases yet.  I'll cherry-pick it into stable for 0.28.2.
> > 
> > Please let me know if you continue to see this problem with that fix in 
> > place.
> 
> Nope. I'm now running the ceph master branch (fe955881) on all nodes
> but the problem remains. Even after stopping the writer, the "ls -l"
> hangs. Linux kernel version is plain 2.6.38.7 everywhere and the ceph
> setup is fairly simple: 6 cosds, one cmon and one cmds.

I created a new bug (http://tracker.newdream.net/issues/1110) for this. 
Can you generate an mds log for this and attach it to the bug?

	debug mds = 20
	debug ms = 1

in the [mds] section and restart, or if the cluster is already up just

	ceph mds tell 0 injectargs '--debug-mds 20 --debug-ms 1'

and then reproduce the problem.  Should be at /var/log/ceph/mds.a.log or 
similar.

Thanks!
sage
