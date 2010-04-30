From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph-client: fix xattr bugs
Date: Fri, 30 Apr 2010 11:21:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
 <Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
 <l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35129 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250Ab0D3SSe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Apr 2010 14:18:34 -0400
In-Reply-To: <l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 30 Apr 2010, Henry C Chang wrote:
> Hi Sage,
> 
> Thanks for your reply.
> I don't have the test program that reproduces the bug actually.
> I detected it manually by entering xattr commands from the command prompt.

Do you remember which setfattr/whatever commands?

> In fact, I am trying to add "folder quota support" to ceph right now.
> My rough idea is as below:
> 
> (1) Store the quota limit in the xattr of the folder;
> (2) When the client requests a new max size for writing content to a file,
> MDS authorizes the request according to the quota and the rstat of the
> folder.

One thing to keep in mind is that because the recursive rsize info is 
lazily propagated up the file tree, this won't work perfectly.  If you set 
a limit of 1GB on /foo and are writing data in /foo/bar/baz, it won't stop 
you right at 1GB.  Similarly, if you hit the limit, and delete some stuff, 
it will take time before the MDS notices and lets you start writing again.

If that is acceptable, then in principle this is doable, although 
difficult.  The first step would probably be keeping track of how much 
"max_size - size" slop is currently outstanding in a recursive fashion so 
that the mds can limit itself.  For a single mds that's pretty doable.  
When you consider that the hierarchy can be partitioned across multiple 
nodes, it becomes more difficult (which is partly why rsize is lazily 
propagated).  This would definitely take some planning...

What is your use case?

sage



> 
> I detected the xattr bug when I was doing tests for (1). Everything goes
> well so far after it's fixed.
> I can write some test programs to test it more since I will write a program
> (tool) to set/get folder quota.
> 
> I would appreciate if you can give me some advices on implementing "folder
> quota".
> 
> Best Regards,
> Henry
> 
> 
> On Fri, Apr 30, 2010 at 12:39 AM, Sage Weil <sage@newdream.net> wrote:
> 
> > Hi Henry--
> >
> > On Thu, 29 Apr 2010, Henry C Chang wrote:
> > > 1. fill_inode() incorrectly frees the xattr blob in the end of the
> > >   function. It will cause segfault and then kernel will crash.
> >
> > I fixed this slightly differently, by clearing xattr_blob if/when it is
> > used.  See
> >
> >
> > http://ceph.newdream.net/git/?p=ceph-client.git;a=commitdiff;h=c89f9c6decdbe2427d4d510a949a2d87c5e340dc
> >
> > > 2. ceph_listxattr() should compare index_version and version by '>='.
> >
> >
> > http://ceph.newdream.net/git/?p=ceph-client.git;a=commitdiff;h=da6eb075f800b64af9e199ffbe9171752647fbaa
> >
> > Both are pushed to the unstable branch.  Do you mind testing?  Do you have
> > a simple test that reproduced the bug before?  If so we should add it to
> > the qa suite (which currently does nothing with xattrs).
> >
> > Thanks!
> > sage
> >
> >
> > >
> > > Signed-off-by: henry_c_chang <henry_c_chang@tcloudcomputing.com>
> > > ---
> > >  inode.c |    2 +-
> > >  xattr.c |    2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/inode.c b/inode.c
> > > index 261f3e6..bfe48ee 100644
> > > --- a/inode.c
> > > +++ b/inode.c
> > > @@ -742,7 +742,7 @@ no_change:
> > >        err = 0;
> > >
> > >  out:
> > > -       if (xattr_blob)
> > > +       if (err && xattr_blob)
> > >                ceph_buffer_put(xattr_blob);
> > >        return err;
> > >  }
> > > diff --git a/xattr.c b/xattr.c
> > > index 37d6ce6..8c4ef01 100644
> > > --- a/xattr.c
> > > +++ b/xattr.c
> > > @@ -573,7 +573,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char
> > > *names, size_t size)
> > >             ci->i_xattrs.version, ci->i_xattrs.index_version);
> > >
> > >        if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 1) &&
> > > -           (ci->i_xattrs.index_version > ci->i_xattrs.version)) {
> > > +           (ci->i_xattrs.index_version >= ci->i_xattrs.version)) {
> > >                goto list_xattr;
> > >        } else {
> > >                spin_unlock(&inode->i_lock);
> > > --
> > > 1.6.3.3
> > >
> >
> 
