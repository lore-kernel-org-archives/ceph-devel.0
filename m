From: Alex Elder <elder@dreamhost.com>
Subject: Re: __d_find_alias() problem
Date: Thu, 22 Dec 2011 10:35:38 -0600
Message-ID: <1324571738.3957.77.camel@doink>
References: <1324568779.3957.73.camel@doink>
	 <Pine.LNX.4.64.1112220754490.3284@cobra.newdream.net>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43524 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab1LVQfk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 11:35:40 -0500
In-Reply-To: <Pine.LNX.4.64.1112220754490.3284@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, 2011-12-22 at 08:11 -0800, Sage Weil wrote:
> On Thu, 22 Dec 2011, Alex Elder wrote:
> > I'll send all this to ceph-devel later, I just wanted
> [added cc]
> 
> > to document it while it's fresh and send it to *someone*
> > and you made this change so I'm sending it to you.  The
> > change in question is:
> > 
> >     be655596b3de5873f994ddbe205751a5ffb4de39
> >     ceph: use i_ceph_lock instead of i_lock
> > 
> > First, after updating my ceph tree and rebuilding I found
> > that every time I completed a mount in my UML environment
> > it would immediately crash the UML.
> > 
> > This led to me learning how to attach a debugger to
> > the UML (good) and this morning I was able to capture
> > this situation in gdb.
> > 
> > The problem is in ceph_dir_set_complete(), which is
> > blindly dereferencing the return value of
> > __d_find_any_alias(inode), and that function is
> > returning NULL because the inode's i_dentry list
> > is empty.
> > 
> > So that's problem 1.
> 
> Yeah, looks like I broke that with 
> 9f6f8f50663e6cf42cca64f1f5ee0ca438c33c46.  Just moving the dentry->d_sb 
> inside the if should do it!  Strange that this didn't trigger on sepia... 
> :/

I have a patch that fixes this one and I have confirmed I
can now get my UML filesystem mounted with it applied.

> > In looking at this I find that __d_find_any_alias()
> > is duplicated in ceph, to (almost) match the Linux
> > implementation which is not exported.  But unlike
> > the Linux version, the ceph version does NOT grab
> > a reference to the found alias.  I consider this a
> > bug, because a function with an identical name should
> > perform identically to the original, otherwise it
> > should be named something different.
> > 
> > That's problem 2.
> > Furthermore, I looked at the locking that's done for
> > the Linux version of __d_find_any_alias, and that
> > truly does require taking the Linux inode lock--the
> > (new) ceph inode i_ceph_lock is not sufficient.  Note
> > that __d_find_any_alias() really only operates on the
> > Linux inode and does nothing with the ceph inode, so
> > it may be that simply changing the locking used *in
> > this case* back to using the Linux inode lock is
> > enough to fix the problem.  But I'm not familiar
> > enough at this point to know the locking context
> > where these calls are made, so can't be sure doing
> > this would cause problems (like lock inversions).
> > 
> > There are three places this __d_find_any_alias()
> > is called:  ceph_dir_{set,clear,test}_complete().
> > Those are straightforward, but the calls to *those*
> > functions are mostly embedded in long strings of
> > logical conditions so it's going to take a little
> > work to unwind this.
> > 
> > So that's problem 3, which is the biggest one.
> 
> I think the __d_find_any_alias() needs to take the i_lock and a reference 
> to make it fully safe.  i_lock is ordered inside i_ceph_lock, now, so that 
> should be safe in all of the call chains.  Better yet, we should just 
> export the VFS version and use that.

I'll put together a patch that both adds the reference,
and fixes callers so they release it properly.

> What do you think?  A simple fix is best so we can get it into 3.2 (which 
> is about a week away?).

What I described is simplest.  I don't want to suggest
a VFS change at this point.

> > Potential problem 4 is that this suggests the
> > mechanical switch to using i_ceph_lock is a little
> > suspect and might need a closer look.
> 
> Yeah.  Well, this is one of the few cases where i_lock where we muddle 
> with the dcache internal structure.  The others should pretty much all be 
> in dir.c, and maybe inode.c's splice_dentry() and friends.  The dcache 
> readdir is by far the most suspect of all of those, but also probably the 
> lowest priority at the moment.  Maybe your visit in January would be a 
> good time to go over it in detail?

Sure.  Or I could review the committed patch.  For now
I'll get something togehter for the 3.2 release.

					-Alex

