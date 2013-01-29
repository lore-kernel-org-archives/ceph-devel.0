From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [ceph] locking fun with d_materialise_unique()
Date: Tue, 29 Jan 2013 08:00:37 +0000
Message-ID: <20130129080036.GI4503@ZenIV.linux.org.uk>
References: <20130129045213.GH4503@ZenIV.linux.org.uk>
 <alpine.DEB.2.00.1301282115060.16431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50916 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab3A2IAi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 03:00:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301282115060.16431@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org

On Mon, Jan 28, 2013 at 09:20:34PM -0800, Sage Weil wrote:

> Yep, that is indeed a problem.  I think we just need to do the r_aborted 
> and/or r_locked_dir check in the else if condition...
> 
> > I'm not sure if we are guaranteed that ceph_readdir_prepopulate() won't
> > get to its splice_dentry() and d_delete() calls in similar situations -
> > I hadn't checked that one yet.  If it isn't guaranteed, we have a problem
> > there as well.
> 
> ...and the condition guarding readdir_prepopulate().  :)

> I think you're reading it correctly.  The main thing to keep in mind here 
> is that we *do* need to call fill_inode() for the inode metadata on these 
> requests to keep the mds and client state in sync.  The dentry state is 
> safe to ignore.

You mean the parts under
        if (rinfo->head->is_dentry) {
and
        if (rinfo->head->is_target) {
in there?  Because there's fill_inode() called from readdir_prepopulate()
and it's a lot more problematic than those two...

> It would be great to have the dir i_mutex rules summarized somewhere, even 
> if it is just a copy of the below.  It took a fair bit of trial and error 
> to infer what was going on when writing this code.  :)

Directory ->i_mutex rules are in part documented - "what VFS guarantees
to hold" side is in Documentation/filesystems/directory-locking.  It's
the other side ("what locks are expected to be held by callers of dcache.c
functions") that is badly missing...

> Ping me when you've pushed that branch and I'll take a look...

To gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git
   01a88fa..4056362  master -> master

with tentative ceph patch in the very end.  Should be on git.kernel.org
shortly...
