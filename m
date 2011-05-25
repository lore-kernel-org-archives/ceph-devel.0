From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 09:16:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov> <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
 <20110525110118.GA6872@systemlinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48773 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab1EYQPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 12:15:00 -0400
In-Reply-To: <20110525110118.GA6872@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 May 2011, Andre Noll wrote:
> On Wed, Oct 27, 22:06, Sage Weil wrote:
> 
> > It turns out Henry's problem was actually cause by a bad fix on my part, 
> > d91f2438 in ceph-client.git.  (Unfortunately that made it into 2.6.36!)  
> > Reverting that commit fixed things for him.
> 
> FWIW, I've been seeing this with all versions I tried lately,
> including 0.28. Maybe the bug has been reintroduced or we have a
> similar bug elsewhere.
> 
> It's trivial to reproduce: Executing "ls -l" on one client while
> another client is writing causes the ls command to hang indefinitely.

This was recently fixed in the master branch, commit
ee7fa813ef29890557f0b03bd3950d422484215d.  It hasn't made it into any  
releases yet.  I'll cherry-pick it into stable for 0.28.2.

Please let me know if you continue to see this problem with that fix in 
place.

Thanks!
sage
