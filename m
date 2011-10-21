From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: mds: handle xattrs on inode creation
Date: Fri, 21 Oct 2011 13:15:48 -0700 (PDT)
Message-ID: <1750263364.47140.1319228148613.JavaMail.root@mail-01.cse.ucsc.edu>
References: <Pine.LNX.4.64.1110211243370.20118@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:59523 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab1JUUPt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2011 16:15:49 -0400
In-Reply-To: <Pine.LNX.4.64.1110211243370.20118@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
>
> The mode for the newly created object is being passed to the mds for
> each
> request as part of the args struct/union. And it looks like it's being
> used on the MDS for everything except symlink (which always gets 0777
> +
> the type bits). For example, for mkdir, it's
> 
> unsigned mode = req->head.args.mkdir.mode;
> mode &= ~S_IFMT;
> mode |= S_IFDIR;

Since S_IFDIR (for example) is added by the MDS and the ACL is
computed before the initial MDS request is made (and the final
mode is available), the ACL code ends up looking like:

if (req->op == CEPH_MDS_OP_MKDIR) { ...

  rather than

if (S_ISDIR(mode)) { ...

which, I suppose isn't a big deal. Should we go with the this,
or is there a potential to fully compute the mode arguments
on the client to allow reuse of the nice S_ISDIR (etc...) macros?


> and on the client there is
> 
> req->r_args.mkdir.mode = cpu_to_le32(mode);
> 
> in ceph_mkdir() in dir.c.

Thanks, this is the part I originally was wondering about. Twas
right under my nose.

-Noah
