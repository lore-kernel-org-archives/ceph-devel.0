From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 2/5] ceph: Propagate dentry down to inode_change_ok()
Date: Thu, 22 Sep 2016 13:20:48 -0400
Message-ID: <1474564848.11088.9.camel@redhat.com>
References: <1474299059-14806-1-git-send-email-jack@suse.cz>
         <1474299059-14806-3-git-send-email-jack@suse.cz>
         <1474311422.5754.39.camel@redhat.com>
         <20160922085001.GG2834@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35762 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbcIVRUw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 13:20:52 -0400
Received: by mail-yw0-f177.google.com with SMTP id u82so95715591ywc.2
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 10:20:51 -0700 (PDT)
In-Reply-To: <20160922085001.GG2834@quack2.suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>

On Thu, 2016-09-22 at 10:50 +0200, Jan Kara wrote:
> On Mon 19-09-16 14:57:02, Jeff Layton wrote:
> > 
> > On Mon, 2016-09-19 at 17:30 +0200, Jan Kara wrote:
> > > 
> > > To avoid clearing of capabilities or security related extended
> > > attributes too early, inode_change_ok() will need to take dentry instead
> > > of inode. ceph_setattr() has the dentry easily available but
> > > __ceph_setattr() is also called from ceph_set_acl() where dentry is not
> > > easily available. Luckily that call path does not need inode_change_ok()
> > > to be called anyway. So reorganize functions a bit so that
> > > inode_change_ok() is called only from paths where dentry is available.
> > > 
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ceph/acl.c   |  5 +++++
> > >  fs/ceph/inode.c | 19 +++++++++++--------
> > >  2 files changed, 16 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> > > index 013151d50069..a2cedfde75eb 100644
> > > --- a/fs/ceph/acl.c
> > > +++ b/fs/ceph/acl.c
> > > @@ -127,6 +127,11 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> > > > 
> > > >  			goto out_free;
> > > >  	}
> > >  
> > > > 
> > > > +	if (ceph_snap(inode) != CEPH_NOSNAP) {
> > > > +		ret = -EROFS;
> > > > +		goto out_free;
> > > > +	}
> > > +
> > 
> > So to make sure I understand: What's the expected behavior when someone
> > changes the ACL in such a way that the mode gets changed? Should
> > security_inode_killpriv be getting called in that case? If so, where
> > does that happen, as I don't see notify_change being called in this
> > codepath?
> 
> No. security_inode_killpriv() is supposed to be called when either contents
> of the file changes (truncate, write) or when owner of the file changes. It
> is not called for permission changes.
> 
> ...

Huh, ok...

I would have thought that changing the mode of the file should remove
capabilities though. Consider:

Suppose we have a binary with extra file capabilities that is only
executable by group owner. Attacker is able to change the permissions
such that it's executable by world, and now anyone can get that
capability since it wasn't revoked. IOW, I wonder if we may be trying
to follow suit a little too closely with how the setuid bit works.

When you call chmod(), you have to reinstate the setuid bit anyway if
you want to keep it so not revoking it is ok there. Capabilities are
stored separately though, so you don't need to make the same conscious
decision to keep them there. Maybe the kernel should be revoking them
when the mode changes?

> > 
> > Looks reasonable though:
> > 
> > Acked-by: Jeff Layton <jlayton@redhat.com>
> 
> Thanks for review!
> 
> 								Honza

-- 
Jeff Layton <jlayton@redhat.com>
