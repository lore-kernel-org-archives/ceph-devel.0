From: Sage Weil <sage@newdream.net>
Subject: Re: mds: handle xattrs on inode creation
Date: Fri, 21 Oct 2011 14:31:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110211428371.20118@cobra.newdream.net>
References: <1750263364.47140.1319228148613.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36379 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab1JUVbZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2011 17:31:25 -0400
In-Reply-To: <1750263364.47140.1319228148613.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, 21 Oct 2011, Noah Watkins wrote:
> ----- Original Message -----
> > From: "Sage Weil" <sage@newdream.net>
> >
> > The mode for the newly created object is being passed to the mds for
> > each
> > request as part of the args struct/union. And it looks like it's being
> > used on the MDS for everything except symlink (which always gets 0777
> > +
> > the type bits). For example, for mkdir, it's
> > 
> > unsigned mode = req->head.args.mkdir.mode;
> > mode &= ~S_IFMT;
> > mode |= S_IFDIR;
> 
> Since S_IFDIR (for example) is added by the MDS and the ACL is
> computed before the initial MDS request is made (and the final
> mode is available), the ACL code ends up looking like:

I would characterize it as "the MDS ensures the file type bits of the mode 
are correct."  

> if (req->op == CEPH_MDS_OP_MKDIR) { ...
> 
>   rather than
> 
> if (S_ISDIR(mode)) { ...
> 
> which, I suppose isn't a big deal. Should we go with the this,
> or is there a potential to fully compute the mode arguments
> on the client to allow reuse of the nice S_ISDIR (etc...) macros?

Yeah, just compute the whole thing on the client.  

The MDS does fundamentally different things for different op types, and 
sometimes creation is implicit etc., so don't worry about that part.  :)
In the end, they all funnel into prepare_new_inode() with a correct mode, 
so that's where the "magic" of setting those initial xattrs happens.

sage

