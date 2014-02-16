From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/3] ceph: make ceph_forget_all_cached_acls() static
 inline
Date: Sun, 16 Feb 2014 10:27:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402161027130.17892@cobra.newdream.net>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com> <1392355784-10422-2-git-send-email-lucienchao@gmail.com> <52FE0C45.4070708@ieee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41541 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbaBPS1Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Feb 2014 13:27:16 -0500
In-Reply-To: <52FE0C45.4070708@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org

Applied.

On Fri, 14 Feb 2014, Alex Elder wrote:

> On 02/13/2014 11:29 PM, Guangliang Zhao wrote:
> > Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> 
> Looks good.  Is there a reason we can't just call
> forget_all_cached_acls(inode) directly?  Or is it
> just so that we have our own complete private ACL
> interface?  (I have no problem with it, just asking.)
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > ---
> >  fs/ceph/acl.c   |    5 -----
> >  fs/ceph/super.h |    6 +++++-
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> > index 64fddbc..48af0b3 100644
> > --- a/fs/ceph/acl.c
> > +++ b/fs/ceph/acl.c
> > @@ -54,11 +54,6 @@ static inline struct posix_acl *ceph_get_cached_acl(struct inode *inode,
> >  	return acl;
> >  }
> >  
> > -void ceph_forget_all_cached_acls(struct inode *inode)
> > -{
> > -	forget_all_cached_acls(inode);
> > -}
> > -
> >  struct posix_acl *ceph_get_acl(struct inode *inode, int type)
> >  {
> >  	int size;
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index c299f7d..8851dc2 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/writeback.h>
> >  #include <linux/slab.h>
> > +#include <linux/posix_acl.h>
> >  
> >  #include <linux/ceph/libceph.h>
> >  
> > @@ -745,7 +746,10 @@ extern const struct xattr_handler *ceph_xattr_handlers[];
> >  struct posix_acl *ceph_get_acl(struct inode *, int);
> >  int ceph_init_acl(struct dentry *, struct inode *, struct inode *);
> >  int ceph_acl_chmod(struct dentry *, struct inode *);
> > -void ceph_forget_all_cached_acls(struct inode *inode);
> > +static inline void ceph_forget_all_cached_acls(struct inode *inode)
> > +{
> > +	forget_all_cached_acls(inode);
> > +}
> >  
> >  #else
> >  
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
