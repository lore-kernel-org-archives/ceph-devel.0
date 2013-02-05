From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph] locking fun with d_materialise_unique()
Date: Tue, 5 Feb 2013 13:59:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302051324430.27331@cobra.newdream.net>
References: <20130129045213.GH4503@ZenIV.linux.org.uk> <alpine.DEB.2.00.1301282115060.16431@cobra.newdream.net> <20130129080036.GI4503@ZenIV.linux.org.uk> <alpine.DEB.2.00.1301291301260.6657@cobra.newdream.net> <20130130144214.GJ4503@ZenIV.linux.org.uk>
 <20130201011416.GO4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20130201011416.GO4503@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Al-

I've returned and recovered from LCA and have no more excuse for keeping 
my brain turned off:

On Fri, 1 Feb 2013, Al Viro wrote:
> On Wed, Jan 30, 2013 at 02:42:14PM +0000, Al Viro wrote:
> > On Tue, Jan 29, 2013 at 01:03:23PM -0800, Sage Weil wrote:
> > 
> > > We should drop teh mds_client.c hunk from your patch, and then do 
> > > something like the below.  I'll put it in the ceph tree so we can do some 
> > > basic testing.  Unfortunately, the abort case is a bit annoying to 
> > > trigger.. we'll need to write a new test for it.
> > 
> > hunk dropped, the rest folded into your patch, resulting branch pushed...
> 
> BTW, moderately related issue - ceph_get_dentry_parent_inode() uses
> look fishy.  In ceph_rename() it seems to be pointless.  We do have
> the directory inode of parent of old_dentry - it's old_dir, so it's just
> a fancy way to spell igrab(old_directory).  And as far as I can tell, *all*

Yeah, that's an easy fix.

> other callers are racy.
> 	* link("a/foo", "b/bar") can happen in parallel with
> rename("a/foo", "c/splat").  link(2) holds ->i_mutex on a/foo (so it can't race
> with unlink) and on b/; rename(2) holds it on a/, c/ and c/splat (if the last
> one exists).  It also holds ->s_vfs_rename_sem, so cross-directory renames
> are serialized.  For normal filesystems that's enough and there ->link()
> couldn't care less about a/; ceph_link() wants the inode of a/ for some
> reason.  If it *really* needs the parent of a/foo for the operation, the
> current code is SOL - the directory we grab can cease being that parent
> just as it's getting returned to ceph_link()

And I think this use is totally unnecessary.

> 	* ->d_revalidate() can happen in parallel with rename().  You
> don't seem to be using the parent inode much in there, so that should
> be reasonably easy to deal with.

This is the tricky one.  We're looking at the parent because some of the 
directory inode state is effectively a lease over the validity of the 
directory's dentries.  In the general case, this is more efficient than a 
lot of per-dentry state in the client/server protocol.

Probably what we *should* be doing is linking to the parent from the 
child's ceph_dentry_info under the MDS session mutex, so that it is 
properly aligned with the state being passed from the server.  I 
considered this originally but was annoyed about essentially duplicating 
d_parent.  But... the locking being what it is, that is probably the only 
way to make the d_revalidate completely safe.  It'll be a bigger patch to 
change that behavior, though.

> 	* ceph_open() can race with rename(); ->atomic_open() is
> called with parent locked, but ->open() isn't.  AFAICS, open() with
> O_TRUNC could step into that code...
> 	* ceph_setattr() *definitely* can race with rename(); we have
> the object itself locked, but not its parent (and I'm really surprised
> by the need to know that parent for such operation).
> 	* CEPH_IOC_SET_LAYOUT vs. rename() - no idea what that ioctl is
> about, but opened files can be moved around, TYVM, even when they are
> in the middle of ioctl(2).
> 	* ->setxattr() and ->removexattr() - again, can happen in parallel
> with rename(), and again I really wonder why do we need the parent directory
> for such operations.

These are only there so that an fsync(dirfd) will wait for the file 
creation or other metadata to commit.  I suspect I am (heavily) 
over-reading what POSIX says here... and should be concerned only with the 
namespace modifications (link, unlink, rename, O_CREAT).

Assuming that's the case,

	git://github.com/ceph/ceph-client.git #wip-dentries

has a set of patches that fix this up.  (Well, except for d_revalidate, 
which is a bigger change; opened #4023 in the ceph bug tracker.)

Thanks!
sage
