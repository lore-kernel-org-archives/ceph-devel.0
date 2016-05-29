From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/5] xfs: Propagate dentry down to inode_change_ok()
Date: Mon, 30 May 2016 08:36:41 +1000
Message-ID: <20160529223641.GJ26977@dastard>
References: <1464279600-13009-1-git-send-email-jack@suse.cz>
 <1464279600-13009-2-git-send-email-jack@suse.cz>
 <20160526215304.GO21200@dastard>
 <20160527161233.GE21780@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:30152 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932373AbcE2Wgp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 May 2016 18:36:45 -0400
Content-Disposition: inline
In-Reply-To: <20160527161233.GE21780@quack2.suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, xfs@oss.sgi.com

On Fri, May 27, 2016 at 06:12:33PM +0200, Jan Kara wrote:
> On Fri 27-05-16 07:53:04, Dave Chinner wrote:
> > On Thu, May 26, 2016 at 06:19:56PM +0200, Jan Kara wrote:
> > > To avoid clearing of capabilities or security related extended
> > > attributes too early, inode_change_ok() will need to take dentry instead
> > > of inode. Propagate dentry down to functions calling inode_change_ok().
> > > This is rather straightforward except for xfs_set_mode() function which
> > > does not have dentry easily available. Luckily that function does not
> > > call inode_change_ok() anyway so we just have to do a little dance with
> > > function prototypes.
> > 
> > The idea behind the change is good, but I think the little dance
> > could be improved as it makes the layering of the code seem weirdly
> > unbalanced to me. e.g.
> > 
> > xfs_vn_setattr()
> >   xfs_vn_setattr_size()		<<<< inode_change_ok() here
> > 
> > xfs_vn_setattr()
> >   xfs_vn_setattr_nonsize()	<<<< inode_change_ok() here
> >     xfs_setattr_nonsize()
> > 
> > xfs_vn_setattr()
> >   xfs_vn_setattr_size()
> >     xfs_vn_setattr_nonsize()	<<<< inode_change_ok() here
> >       xfs_setattr_nonsize()
> > 
> > And to be more confusing, the externally callable functions for the
> > rest of the XFS code are now xfs_vn_setattr_size() and
> > xfs_setattr_nonsize() which now have different calling context
> > limitations.
> > 
> > I think adding a little symmetric make sense. i.e:
> > 
> > xfs_vn_change_ok(dentry, iattr)
> > {
> > +	if (mp->m_flags & XFS_MOUNT_RDONLY)
> > +		return -EROFS;
> > +
> > +	if (XFS_FORCED_SHUTDOWN(mp))
> > +		return -EIO;
> > +
> > +	error = inode_change_ok(inode, iattr);
> > +	if (error)
> > +		return error;
> > +
> > }
> > 
> > xfs_vn_setattr_size(d, i)
> > {
> > 	xfs_vn_change_ok(d, i)
> > 	xfs_setattr_size(ip, i)
> > }
> > 
> > xfs_vn_setattr_nonsize(d, i)
> > {
> > 	xfs_vn_change_ok(d, i)
> > 	xfs_setattr_nonsize(ip, i)
> > }
> > 
> > xfs_vn_setattr(d, i)
> > {
> > 	xfs_vn_change_ok(d, i)
> > 	<rest of xfs_vn_setattr unchanged>
> > }
> > 
> > And remove the inode_change_ok() code from xfs_setattr_size and
> > xfs_setattr_nonsize() completely.  You've already done this with
> > xfs_vn_setattr_nonsize() - it just needs to be made symmetric to
> > keep a clean layering between VFS interfaces and internal XFS
> > interfaces...
> 
> Ok, something like attached patch?

Yup, looks much better to me!

Acked-by: Dave Chinner <dchinner@redhat.com>

-Dave.
-- 
Dave Chinner
david@fromorbit.com
