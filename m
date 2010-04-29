From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph-client: fix xattr bugs
Date: Thu, 29 Apr 2010 09:39:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48390 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758657Ab0D3Rtf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Apr 2010 13:49:35 -0400
In-Reply-To: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry--

On Thu, 29 Apr 2010, Henry C Chang wrote:
> 1. fill_inode() incorrectly frees the xattr blob in the end of the
>   function. It will cause segfault and then kernel will crash.

I fixed this slightly differently, by clearing xattr_blob if/when it is 
used.  See 

http://ceph.newdream.net/git/?p=ceph-client.git;a=commitdiff;h=c89f9c6decdbe2427d4d510a949a2d87c5e340dc

> 2. ceph_listxattr() should compare index_version and version by '>='.

http://ceph.newdream.net/git/?p=ceph-client.git;a=commitdiff;h=da6eb075f800b64af9e199ffbe9171752647fbaa

Both are pushed to the unstable branch.  Do you mind testing?  Do you have 
a simple test that reproduced the bug before?  If so we should add it to 
the qa suite (which currently does nothing with xattrs).

Thanks!
sage


> 
> Signed-off-by: henry_c_chang <henry_c_chang@tcloudcomputing.com>
> ---
>  inode.c |    2 +-
>  xattr.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/inode.c b/inode.c
> index 261f3e6..bfe48ee 100644
> --- a/inode.c
> +++ b/inode.c
> @@ -742,7 +742,7 @@ no_change:
>        err = 0;
> 
>  out:
> -       if (xattr_blob)
> +       if (err && xattr_blob)
>                ceph_buffer_put(xattr_blob);
>        return err;
>  }
> diff --git a/xattr.c b/xattr.c
> index 37d6ce6..8c4ef01 100644
> --- a/xattr.c
> +++ b/xattr.c
> @@ -573,7 +573,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char
> *names, size_t size)
>             ci->i_xattrs.version, ci->i_xattrs.index_version);
> 
>        if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 1) &&
> -           (ci->i_xattrs.index_version > ci->i_xattrs.version)) {
> +           (ci->i_xattrs.index_version >= ci->i_xattrs.version)) {
>                goto list_xattr;
>        } else {
>                spin_unlock(&inode->i_lock);
> --
> 1.6.3.3
> 
