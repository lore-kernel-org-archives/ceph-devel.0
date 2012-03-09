From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Fri, 09 Mar 2012 06:35:16 -0300
Message-ID: <orfwdif76z.fsf@livre.localdomain>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
	<ork43bbbbb.fsf@livre.localdomain>
	<Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:51999 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751014Ab2CIJfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 04:35:30 -0500
In-Reply-To: <Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net> (Sage
	Weil's message of "Sat, 3 Mar 2012 16:14:12 -0800 (PST)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mar  3, 2012, Sage Weil <sage@newdream.net> wrote:

> It looks like the problem is that CInode::first isn't being journaled.  
> Normally, that's fine because it matches the referring dentry.. but for 
> multiversion inodes (like snapped directories), it won't match.  On replay 
> we end up with bad value of 2, and it re-cows and clobbers the original 
> old value.

> I pushed wip-1946 with a fix.  Want to give it a go?

Sorry about the delay, I spent the week facing disk full problems that
followed a major crushmap rearrangement and cluster_snaps that I'd
rather not remove before the rearrangement was complete.  Fun! :-)

I gave it a go, and I'm afraid it doesn't look like it fixed the
problem.  bb85a7270 (wip-1946^) is the one patch I tested with, because
the subsequent patch in wip-1946 failed the assertion during recovery,
while replaying AFAICT a directory move.  in->first was 2 (the bad value
you mention above?).

Observed behavior was still the same: remove old snapshot, touch dir
with old timestamp, remount, re-create snapshot, remount, check
timestamps in snapshot dir, all fine, restart mds, all fine, touch dir,
remount, all fine, restart mds again, snapshot timestamp changes to
match.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
