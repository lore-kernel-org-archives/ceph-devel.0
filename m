From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Sat, 3 Mar 2012 16:14:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
References: <orboos1qyu.fsf@livre.localdomain> <Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
 <ork43bbbbb.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56321 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab2CDAOO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Mar 2012 19:14:14 -0500
In-Reply-To: <ork43bbbbb.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Hi Alexandre,

On Sat, 25 Feb 2012, Alexandre Oliva wrote:
> On Feb 23, 2012, Sage Weil <sage@newdream.net> wrote:
> 
> > On Tue, 21 Feb 2012, Alexandre Oliva wrote:
> >> This was supposed to fix bug 1946, and likely bug 1849 too, but it looks
> >> like something's still missing for a complete fix.  fuse-unmounting
> >> between touching a dir and creating a snapshot seems to help get correct
> >> snapshot timestamp,
> 
> > Hmm, that sounds like ceph-fuse isn't sending the write flushsnap cap 
> > message.  I forget.. have you tried the same with the kernel client?
> 
> Not recently enough that I'd remember exactly what I did.
> 
> However, I don't see how ceph-fuse could be the problem, given today's
> experiments.  Here's what I just did (all with fuse):
> 
> create snapshot
> check timestamps -> baseline
> unmount
> mount again
> check timestamps -> same
> restart mds
> check timestamps -> same
> unmount
> mount again
> check timestamps -> same
> moved a tree into dir
> check timestamps -> dir changed and snapshot unchanged, as expected
> unmount
> mount again
> check timestamps -> same
> restart mds
> check timestamps -> snapshot changed to dir's; its size too!
> 
> After each umount, I checked that ceph-fuse was no longer running (it
> sometimes remains running for a while after umount completes)

It looks like the problem is that CInode::first isn't being journaled.  
Normally, that's fine because it matches the referring dentry.. but for 
multiversion inodes (like snapped directories), it won't match.  On replay 
we end up with bad value of 2, and it re-cows and clobbers the original 
old value.

I pushed wip-1946 with a fix.  Want to give it a go?  I wasn't able to 
directly reproduce the behavior you're seeing, but I did see it doing a 
bad cow_old_inode() and observed that this patch fixes that part.

sage

