From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] ceph: trivial comment fix
Date: Wed, 22 Jan 2014 13:23:39 -0500
Message-ID: <20140122182339.GD13704@fieldses.org>
References: <20140116224253.GB20521@fieldses.org>
 <alpine.DEB.2.00.1401161603250.16743@cobra.newdream.net>
 <20140117020119.GC20521@fieldses.org>
 <alpine.DEB.2.00.1401172026020.19111@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fieldses.org ([174.143.236.118]:38274 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbaAVSXq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jan 2014 13:23:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1401172026020.19111@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 17, 2014 at 08:33:48PM -0800, Sage Weil wrote:
> On Thu, 16 Jan 2014, J. Bruce Fields wrote:
> > On Thu, Jan 16, 2014 at 04:03:38PM -0800, Sage Weil wrote:
> > > On Thu, 16 Jan 2014, J. Bruce Fields wrote:
> > > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > > 
> > > > "disconnected" is too easily confused with "DCACHE_DISCONNECTED".  I
> > > > think "unhashed" is the more precise term here.
> > > 
> > > Good point.  Applied, thanks!
> > 
> > Thanks!  While I'm looking, there's another d_find_alias() caller in
> > build_inode_path.  What's that?  (Do the mds protocol messages actually
> > use full paths?)  And will this break if you get a DCACHE_DISCONNECTED
> > or an unhashed alias?
> 
> They build a path relative to the first non-snapped parent, which in most 
> cases is either no path at all (just an ino) or a single path segment.  
> The exception is if you are inside a snapshotted directory (e.g. 
> a/b/.snap/mysnap/c/d), in which case it can be deeper.  In any case, I 
> think the only problem is if you have a disconnected dentry from an old 
> nfs filename for an inode within a snapshot.

Right, so I guess there may be a problem you get a disconnected dentry
that's not yet connected all the way back up to the main dcache, in
which case the !IS_ROOT tests in the loops in ceph_mdsc_build_path() may
fail too soon.

--b.

> There may be some issues 
> there (nfs reexport + snaps isn't currently part of the test suite), but 
> in general I don't think there is any issue with disconnected dentries.
> 
> sage
> 
> 
> > 
> > --b.
> > 
> > > sage
> > > 
> > > 
> > > > 
> > > > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > > > ---
> > > >  fs/ceph/caps.c |    6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > Just ran across this while wondering what d_find_alias callers do....
> > > > 
> > > > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > > > index 3c0a4bd..697f9d7 100644
> > > > --- a/fs/ceph/caps.c
> > > > +++ b/fs/ceph/caps.c
> > > > @@ -2350,11 +2350,11 @@ static void invalidate_aliases(struct inode *inode)
> > > >  	d_prune_aliases(inode);
> > > >  	/*
> > > >  	 * For non-directory inode, d_find_alias() only returns
> > > > -	 * connected dentry. After calling d_invalidate(), the
> > > > -	 * dentry become disconnected.
> > > > +	 * hashed dentry. After calling d_invalidate(), the
> > > > +	 * dentry becomes unhashed.
> > > >  	 *
> > > >  	 * For directory inode, d_find_alias() can return
> > > > -	 * disconnected dentry. But directory inode should have
> > > > +	 * unhashed dentry. But directory inode should have
> > > >  	 * one alias at most.
> > > >  	 */
> > > >  	while ((dn = d_find_alias(inode))) {
> > > > -- 
> > > > 1.7.9.5
> > > > 
> > > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
