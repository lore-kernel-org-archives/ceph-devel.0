From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph] locking fun with d_materialise_unique()
Date: Mon, 28 Jan 2013 21:20:34 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301282115060.16431@cobra.newdream.net>
References: <20130129045213.GH4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3A2FUf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 00:20:35 -0500
In-Reply-To: <20130129045213.GH4503@ZenIV.linux.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Al,

On Tue, 29 Jan 2013, Al Viro wrote:
> 	There's a fun potential problem with CEPH_MDS_OP_LOOKUPSNAP handling
> in ceph_fill_trace().  Consider the following scenario:
> 
> Process calls stat(2).  Lookup locks parent, allocates dentry and calls
> ->lookup().  Request is created and sent over the wire.  Then we sit and
> wait for completion.  Just as the reply has arrived, process gets SIGKILL.
> OK, we get to
>                 /*
>                  * ensure we aren't running concurrently with
>                  * ceph_fill_trace or ceph_readdir_prepopulate, which
>                  * rely on locks (dir mutex) held by our caller.
>                  */
>                 mutex_lock(&req->r_fill_mutex);
>                 req->r_err = err;
>                 req->r_aborted = true;
>                 mutex_unlock(&req->r_fill_mutex);
> and we got there before handle_reply() grabbed ->r_fill_mutex.  Then we return
> to ceph_lookup(), drop the reference to request and bugger off.  Parent is
> unlocked by caller.
> 
> In the meanwhile, there's another thread sitting in handle_reply().  It
> got ->r_fill_mutex and called ceph_fill_trace().  Had that been something
> like rename request, ceph_fill_trace() would've checked req->r_aborted and
> that would've been it.  However, we hit this:
>         } else if (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
>                    req->r_op == CEPH_MDS_OP_MKSNAP) {
>                 struct dentry *dn = req->r_dentry;
> and proceed to
>                 dout(" linking snapped dir %p to dn %p\n", in, dn);
>                 dn = splice_dentry(dn, in, NULL, true);
> which does
>         realdn = d_materialise_unique(dn, in);
> and we are in trouble - d_materialise_unique() assumes that ->i_mutex on parent
> is held, which isn't guaranteed anymore.  Not that d_delete() done a couple
> of lines earlier was any better...

Yep, that is indeed a problem.  I think we just need to do the r_aborted 
and/or r_locked_dir check in the else if condition...

> I'm not sure if we are guaranteed that ceph_readdir_prepopulate() won't
> get to its splice_dentry() and d_delete() calls in similar situations -
> I hadn't checked that one yet.  If it isn't guaranteed, we have a problem
> there as well.

...and the condition guarding readdir_prepopulate().  :)

> I might very well be missing something - that code is seriously convoluted,
> and race wouldn't be easy to hit, so I don't have anything resembling
> a candidate reproducer ;-/  IOW, this is just from RTFS and I'd really
> appreciate comments from folks familiar with ceph.

I think you're reading it correctly.  The main thing to keep in mind here 
is that we *do* need to call fill_inode() for the inode metadata on these 
requests to keep the mds and client state in sync.  The dentry state is 
safe to ignore.

It would be great to have the dir i_mutex rules summarized somewhere, even 
if it is just a copy of the below.  It took a fair bit of trial and error 
to infer what was going on when writing this code.  :)

Ping me when you've pushed that branch and I'll take a look...

Thanks!
sage





> 
> VFS side of requirements is fairly simple:
> 	* d_splice_alias(d, _), d_add_ci(d, _), d_add(d, _),
> d_materialise_unique(d, _), d_delete(d), d_move(_, d) should be called
> only with ->i_mutex held on the parent of d.
> 	* d_move(d, _), d_add_unique(d, _), d_instantiate_unique(d, _),
> d_instantiate(d, _) should be called only with d being parentless (i.e.
> d->d_parent == d, aka. IS_ROOT(d)) or with ->i_mutex held on the parent of d.
> 	* with the exception of "prepopulate dentry tree at ->get_sb() time"
> kind of situations, d_alloc(d, _) and d_alloc_name(d, _) should be called
> only with d->d_inode->i_mutex held (and it won't be too hard to get rid of
> those exceptions, actually).
> 	* lookup_one_len(_, d, _) should only be called with ->i_mutex held
> on d->d_inode
> 	* d_move(d1, d2) in case when d1 and d2 have different parents
> should only be called with ->s_vfs_rename_mutex held on d1->d_sb (== d2->d_sb).
> 
> We are guaranteed that ->i_mutex is held on (inode of) parent of d in
>         ->lookup(_, d, _)
>         ->atomic_open(_, d, _, _, _, _)
>         ->mkdir(_, d, _)
>         ->symlink(_, d, _)
>         ->create(_, d, _, _)
>         ->mknod(_, d, _, _)
>         ->link(_, _, d)
>         ->unlink(_, d)
>         ->rmdir(_, d)
>         ->rename(_, d, _, _)
>         ->rename(_, _, _, d)
> Note that this is *not* guaranteed for another argument of ->link() - the
> inode we are linking has ->i_mutex held, but nothing of that kind is promised
> for its parent directory.
> We also are guaranteed that ->i_mutex is held on the inode of opened
> directory passed to ->readdir() and on victims of ->unlink(), ->rmdir() and
> overwriting ->rename().
> 
> FWIW, I went through that stuff this weekend and we are fairly close to having
> those requirements satisfied - I'll push a branch with the accumulated fixes
> in a few and after that we should be down to very few remaining violations and
> dubious places (ceph issues above being one of those).  And yes, this stuff
> really need to be in Documentation/filesystems somewhere, along with the
> full description of locking rules for ->d_parent and ->d_name accesses.  I'm
> trying to put that together right now...
> 
> 
