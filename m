From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/5] ceph: Propagate dentry down to inode_change_ok()
Date: Mon, 26 Sep 2016 12:25:58 +0200
Message-ID: <20160926102558.GB7733@quack2.suse.cz>
References: <1474299059-14806-1-git-send-email-jack@suse.cz>
 <1474299059-14806-3-git-send-email-jack@suse.cz>
 <1474311422.5754.39.camel@redhat.com>
 <20160922085001.GG2834@quack2.suse.cz>
 <1474564848.11088.9.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474564848.11088.9.camel@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-security-module@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu 22-09-16 13:20:48, Jeff Layton wrote:
> On Thu, 2016-09-22 at 10:50 +0200, Jan Kara wrote:
> > On Mon 19-09-16 14:57:02, Jeff Layton wrote:
> > > 
> > > On Mon, 2016-09-19 at 17:30 +0200, Jan Kara wrote:
> > > > 
> > > > To avoid clearing of capabilities or security related extended
> > > > attributes too early, inode_change_ok() will need to take dentry instead
> > > > of inode. ceph_setattr() has the dentry easily available but
> > > > __ceph_setattr() is also called from ceph_set_acl() where dentry is not
> > > > easily available. Luckily that call path does not need inode_change_ok()
> > > > to be called anyway. So reorganize functions a bit so that
> > > > inode_change_ok() is called only from paths where dentry is available.
> > > > 
> > > > > 
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/ceph/acl.c   |  5 +++++
> > > >  fs/ceph/inode.c | 19 +++++++++++--------
> > > >  2 files changed, 16 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> > > > index 013151d50069..a2cedfde75eb 100644
> > > > --- a/fs/ceph/acl.c
> > > > +++ b/fs/ceph/acl.c
> > > > @@ -127,6 +127,11 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> > > > > 
> > > > >  			goto out_free;
> > > > >  	}
> > > >  
> > > > > 
> > > > > +	if (ceph_snap(inode) != CEPH_NOSNAP) {
> > > > > +		ret = -EROFS;
> > > > > +		goto out_free;
> > > > > +	}
> > > > +
> > > 
> > > So to make sure I understand: What's the expected behavior when someone
> > > changes the ACL in such a way that the mode gets changed? Should
> > > security_inode_killpriv be getting called in that case? If so, where
> > > does that happen, as I don't see notify_change being called in this
> > > codepath?
> > 
> > No. security_inode_killpriv() is supposed to be called when either contents
> > of the file changes (truncate, write) or when owner of the file changes. It
> > is not called for permission changes.
> > 
> > ...
> 
> Huh, ok...
> 
> I would have thought that changing the mode of the file should remove
> capabilities though. Consider:
> 
> Suppose we have a binary with extra file capabilities that is only
> executable by group owner. Attacker is able to change the permissions
> such that it's executable by world, and now anyone can get that
> capability since it wasn't revoked. IOW, I wonder if we may be trying
> to follow suit a little too closely with how the setuid bit works.
> 
> When you call chmod(), you have to reinstate the setuid bit anyway if
> you want to keep it so not revoking it is ok there. Capabilities are
> stored separately though, so you don't need to make the same conscious
> decision to keep them there. Maybe the kernel should be revoking them
> when the mode changes?

So this is certainly an orthogonal issue and I don't want to complicate
this patch set with it. But yeah, your arguments make some sense -
inadvertedly exposing an excutable with additional capabilities may be an
issue. However we behave like this for a long time so I'm not sure we have
the liberty of changing the behavior. Anyway, I've added
linux-security-module to CC if they have anything to say to this.

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
