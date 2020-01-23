From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ceph: perform asynchronous unlink if we have
 sufficient caps
Date: Thu, 23 Jan 2020 20:29:27 +0300
Message-ID: <20200123172927.GD1870@kadam>
References: <20200123153031.o53tzem7bhedyubg@kili.mountain>
 <7ccd37a37f2f700bc648cafcd87784e85c784a31.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:46754 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgAWR3k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jan 2020 12:29:40 -0500
Content-Disposition: inline
In-Reply-To: <7ccd37a37f2f700bc648cafcd87784e85c784a31.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:45:31AM -0500, Jeff Layton wrote:
> On Thu, 2020-01-23 at 18:30 +0300, Dan Carpenter wrote:
> > Hello Jeff Layton,
> > 
> > The patch d6566c62c529: "ceph: perform asynchronous unlink if we have
> > sufficient caps" from Apr 2, 2019, leads to the following static
> > checker warning:
> > 
> > 	fs/ceph/dir.c:1059 get_caps_for_async_unlink()
> > 	error: uninitialized symbol 'got'.
> > 
> > fs/ceph/dir.c
> >   1051  static bool get_caps_for_async_unlink(struct inode *dir, struct dentry *dentry)
> >   1052  {
> >   1053          struct ceph_inode_info *ci = ceph_inode(dir);
> >   1054          struct ceph_dentry_info *di;
> >   1055          int ret, want, got;
> >   1056  
> >   1057          want = CEPH_CAP_FILE_EXCL | CEPH_CAP_DIR_UNLINK;
> >   1058          ret = ceph_try_get_caps(dir, 0, want, true, &got);
> >   1059          dout("Fx on %p ret=%d got=%d\n", dir, ret, got);
> >                                                            ^^^
> > Uninitialized on error.
> > 
> >   1060          if (ret != 1 || got != want)
> >   1061                  return false;
> >   1062  
> >   1063          spin_lock(&dentry->d_lock);
> >   1064          di = ceph_dentry(dentry);
> > 
> 
> Hi Dan,
> 
> This looks like a false positive to me?
> 
> On error, ret != 1, and got shouldn't matter in that case. If
> ceph_try_get_caps does return 1 then "got" will be filled out.


It's complaining about the printk before the error handling.

regards,
dan carpenter
