From: "Marc Roos" <M.Roos@f1-outsourcing.eu>
Subject: RE: [ceph-users] cephfs snap mkdir strange timestamp
Date: Wed, 11 Mar 2020 11:36:56 +0100
Message-ID: <17511.6749874846$1583925277@news.gmane.org>
References: <20200311103142.GA6863@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out.roosit.eu ([212.26.193.44]:42570 "EHLO out.roosit.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLOb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:14:31 -0400
In-Reply-To: <20200311103142.GA6863@suse.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton <jlayton@kernel.org>, lhenriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.io>


Sorry I am not really developer nor now details about POSIX/fs's. But if 
I may ask, why are you getting this time from the parent?



-----Original Message-----
Sent: 11 March 2020 11:32
To: Jeff Layton
Cc: Marc Roos; ceph-users; ceph-devel@vger.kernel.org
Subject: Re: [ceph-users] cephfs snap mkdir strange timestamp

On Tue, Mar 10, 2020 at 01:39:29PM -0400, Jeff Layton wrote:
...
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > ---
> >  fs/ceph/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c index 
> > d01710a16a4a..f4e78ade0871 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -82,6 +82,8 @@ struct inode *ceph_get_snapdir(struct inode 
*parent)
> >  	inode->i_mode = parent->i_mode;
> >  	inode->i_uid = parent->i_uid;
> >  	inode->i_gid = parent->i_gid;
> > +	inode->i_mtime = parent->i_mtime;
> > +	inode->i_ctime = parent->i_ctime;
> >  	inode->i_op = &ceph_snapdir_iops;
> >  	inode->i_fop = &ceph_snapdir_fops;
> >  	ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
> 
> What about the atime, and the ci->i_btime ?

Yeah, probably makes sense too, although the fuse client doesn't seem to 
touch atime (it does change btime, I missed that).  I'll send v2 in a 
bit.

Cheers,
--
Luis
