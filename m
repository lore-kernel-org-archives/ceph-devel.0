From: Sage Weil <sage@newdream.net>
Subject: mds: handle xattrs on inode creation
Date: Fri, 21 Oct 2011 12:49:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110211243370.20118@cobra.newdream.net>
References: <81963025.47045.1319225636851.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34356 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1JUTtY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2011 15:49:24 -0400
In-Reply-To: <81963025.47045.1319225636851.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

[adding ceph-devel CC]

On Fri, 21 Oct 2011, Noah Watkins wrote:
> Hi Sage,
> 
> This commit works fine, but I stumbled upon an additional complication 
> when building up the rest of the ACL code.
> 
> The ACL initialization semantics can alter the i_mode entry of the new 
> inode. However, since i_mode is filled in from the MDS request reply it 
> seems as though there is a potential conflict in semantics between what 
> the MDS computes, and what the ACL code may want to compute (I suppose 
> strict POSIX).
> 
> The r_fmode field of ceph_mds_request seems to be informing the MDS of 
> modes, but at least for ceph_mkdir, doesn't appear to be used at all. 
> Should the r_fmode be fully computed by the clients?

The r_fmode is actually a client-side thing use for initializing the 
struct file.  (It's also not a unix permissions mode, but from the 
CEPH_FILE_MODE_* namespace.)

The mode for the newly created object is being passed to the mds for each 
request as part of the args struct/union.  And it looks like it's being 
used on the MDS for everything except symlink (which always gets 0777 + 
the type bits).  For example, for mkdir, it's

  unsigned mode = req->head.args.mkdir.mode;
  mode &= ~S_IFMT;
  mode |= S_IFDIR;

and on the client there is

	req->r_args.mkdir.mode = cpu_to_le32(mode);

in ceph_mkdir() in dir.c.

sage


> 
> -Noah
> 
> ----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: jayhawk@soe.ucsc.edu
> Sent: Tuesday, October 18, 2011 1:50:08 PM
> Subject: [ceph-commit] [NewDreamNetwork/ceph] d2d214: mds: handle xattrs on inode creation (fwd)
> 
> Just need to attach the new xattr(s) in the msg payload.  This will be 
> similar to what setxattr does with r_pages and r_num_pages, except the 
> page content will be
> 
> <u32> number of xattrs
> (
> 	<u32> xattr name length
> 	xattr name
> 	<u32> xattr value length
> 	xattr value
> ) * N
> 
> 
> ---------- Forwarded message ----------
> Date: Tue, 18 Oct 2011 13:39:13 -0700
> From: noreply@github.com
> To: ceph-commit@ceph.newdream.net
> Subject: [ceph-commit] [NewDreamNetwork/ceph] d2d214: mds: handle xattrs on
>     inode creation
> 
>   Branch: refs/heads/wip-create-xattr
>   Home:   https://github.com/NewDreamNetwork/ceph
> 
>   Commit: d2d2149d364ee5b5fe078a964e2c1089c2153cd1
>       https://github.com/NewDreamNetwork/ceph/commit/d2d2149d364ee5b5fe078a964e2c1089c2153cd1
>   Author: Sage Weil <sage@newdream.net>
>   Date:   2011-10-18 (Tue, 18 Oct 2011)
> 
>   Changed paths:
>     M src/mds/Server.cc
> 
>   Log Message:
>   -----------
>   mds: handle xattrs on inode creation
> 
> Allow mknod, mkdir, symlink, create to provide xattrs for the new
> inode.  This will be used by the kclient to set ACLs on new inodes
> based on the parent directory.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> 
> 
> _______________________________________________
> Ceph-commit mailing list
> Ceph-commit@lists.ceph.newdream.net
> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream.net
> 
> 
