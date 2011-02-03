From: Sage Weil <sage@newdream.net>
Subject: Re: Fixing NFS
Date: Thu, 3 Feb 2011 09:29:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56660 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab1BCR2o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 12:28:44 -0500
In-Reply-To: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 3 Feb 2011, Brian Chrisman wrote:
> I've looked into the export.c code in the kernel client.
> It looks like the primary issue may be incompleteness, as for
> non-connected filehandles, the dentry lookup does not query the mds
> but instead returns stalefh if it's not in the cache.
> For connected filehandles, ceph_mdsc_* methods are called to lookup dentries.
> 
> I understand there's not a lot of interest in re-exporting a ceph fs over NFS.
> But if I were to go ahead and investigate the APIs and find how to
> make that query for non-connected filehandles, would I be running into
> any obvious roadblocks? (I'd consider a "roadblock" something like:
> "there's no interface to make that lookup" or "you'll get
> non-deterministic results")

There are a couple of levels of difficulty.  The main problem is that the 
only truly stable information in the NFS fh is the inode number, and 
Ceph's architecture simply doesn't support lookup-by-ino.  (It uses an 
extra table to support it for hard-linked files, under the assumption that 
these are relatively rare in the real world.)  Using purely the ino, if we 
miss in the exporting client's icache, we can then try all MDSs.  If those 
all miss too, we're out of luck.

To improve things somewhat, the fh includes as many ancestor inos as 
possible (and the connecting dentry hashes).  That let's us try to look up 
parents too, which are more likely to be cached.  That's what the 
LOOKUPHASH stuff is all about (although I confess I can't remember exactly 
what state that code is in, and it's not well tested).  

Also, the situation for directories is a bit better: the directory object 
on disk has ancestor backpointers, so given a _directory_ inode we can, 
with some effort, always find it.  (This isn't implemented, but is 
doable.)

Which leaves us with a final problem: what if the fh is generated for 
/foo/bar, but bar is renamed to /baz/bar, bar drops out of all caches, and 
the client tries to use the fh.  We're still stuck with ESTALE in that 
case.  The only real solution there is to include a backpointer on the 
file's data object.  This is doable, but comes at a cost.  We could make 
it optional, and/or mitigate it somewhat (backpointer is only created once 
a file is renamed, or something like that).

I'm not really sure to what lengths a server is supposed to go to avoid 
ESTALE.  I seem to remember that NFSv4 has a different class of fh's that 
are allowed to expire.  I'm not sure how that helps, though; it seems 
likeif a client has a file open that is renamed by another node and then 
idle for long enough and then tries to read it'll still be screwed, 
regardless of what the server does/does not promise the client.

sage
