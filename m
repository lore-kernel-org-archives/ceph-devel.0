From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: fix xattr search while getxattr
Date: Thu, 13 Jan 2011 15:58:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101131557480.30478@cobra.newdream.net>
References: <201101140107.02627.sakib@meta.ua>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44492 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1AMXwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jan 2011 18:52:22 -0500
In-Reply-To: <201101140107.02627.sakib@meta.ua>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sergiy Kibrik <sakib@meta.ua>
Cc: ceph-devel@vger.kernel.org

Hey,

Thanks for the bug report!  I applied a slightly different fix (need to 
keep the sort lexicographic).  Pushed to master branch of ceph-client.git.

sage

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 6e12a6b..8c9eba6 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -219,6 +219,7 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
        struct rb_node **p;
        struct rb_node *parent = NULL;
        struct ceph_inode_xattr *xattr = NULL;
+       int name_len = strlen(name);
        int c;
 
        p = &ci->i_xattrs.index.rb_node;
@@ -226,6 +227,8 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
                parent = *p;
                xattr = rb_entry(parent, struct ceph_inode_xattr, node);
                c = strncmp(name, xattr->name, xattr->name_len);
+               if (c == 0 && name_len > xattr->name_len)
+                       c = 1;
                if (c < 0)
                        p = &(*p)->rb_left;
                else if (c > 0)



On Fri, 14 Jan 2011, Sergiy Kibrik wrote:

> Reproducible: always
> How to reproduce:
>  $ touch file
>  $ setfattr -n user.bare -v bare file
>  $ setfattr -n user.bar -v bar
>  $ getfattr -d file
> 
>  user.bar="bar"
>  user.bare="bar"
> 
> This is because one xattr name is a sub-string of another,
> so search picks up first matching name -- a shorter one.
> Patch fixes search routine to do full-length string comparison.
> 
> Signed-off-by: Sergiy Kibrik <sakib@meta.ua>
> ---
>  fs/ceph/xattr.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 6e12a6b..3d1d1d5 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -219,13 +219,15 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
>  	struct rb_node **p;
>  	struct rb_node *parent = NULL;
>  	struct ceph_inode_xattr *xattr = NULL;
> -	int c;
> +	int c, name_len = strlen(name);
>  
>  	p = &ci->i_xattrs.index.rb_node;
>  	while (*p) {
>  		parent = *p;
>  		xattr = rb_entry(parent, struct ceph_inode_xattr, node);
> -		c = strncmp(name, xattr->name, xattr->name_len);
> +		c = name_len - xattr->name_len;
> +		if (!c)
> +			c = strncmp(name, xattr->name, xattr->name_len);
>  		if (c < 0)
>  			p = &(*p)->rb_left;
>  		else if (c > 0)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
