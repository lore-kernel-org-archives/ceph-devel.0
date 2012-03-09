From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Fri, 9 Mar 2012 08:37:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203090835060.11669@cobra.newdream.net>
References: <orboos1qyu.fsf@livre.localdomain> <Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
 <ork43bbbbb.fsf@livre.localdomain> <Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
 <orfwdif76z.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33439 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab2CIQhm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 11:37:42 -0500
In-Reply-To: <orfwdif76z.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Fri, 9 Mar 2012, Alexandre Oliva wrote:
> On Mar  3, 2012, Sage Weil <sage@newdream.net> wrote:
> 
> > It looks like the problem is that CInode::first isn't being journaled.  
> > Normally, that's fine because it matches the referring dentry.. but for 
> > multiversion inodes (like snapped directories), it won't match.  On replay 
> > we end up with bad value of 2, and it re-cows and clobbers the original 
> > old value.
> 
> > I pushed wip-1946 with a fix.  Want to give it a go?
> 
> Sorry about the delay, I spent the week facing disk full problems that
> followed a major crushmap rearrangement and cluster_snaps that I'd
> rather not remove before the rearrangement was complete.  Fun! :-)
> 
> I gave it a go, and I'm afraid it doesn't look like it fixed the
> problem.  bb85a7270 (wip-1946^) is the one patch I tested with, because
> the subsequent patch in wip-1946 failed the assertion during recovery,
> while replaying AFAICT a directory move.  in->first was 2 (the bad value
> you mention above?).

You didn't by chance keep the log?

Anyway, a defensive fix would be to replace that patch's

-   	in->first = p->dnfirst;
+	assert(in->first == p->dnfirst ||
+	       (in->is_multiversion() && in->first > p->dnfirst));

with

        if (!in->is_multiversion())
          in->first = p->dnfirst;

> Observed behavior was still the same: remove old snapshot, touch dir
> with old timestamp, remount, re-create snapshot, remount, check
> timestamps in snapshot dir, all fine, restart mds, all fine, touch dir,
> remount, all fine, restart mds again, snapshot timestamp changes to
> match.

Sorry I don't have more time to mess with this.  FWIW I'd want to test any 
fix by running it through the snap workunits (particularly snaptest-2.sh).  
Those are probably a good smoke test for testing any changes in this area 
if it's tedious to reproduce your bug.

sage
