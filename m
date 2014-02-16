From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/3] ceph: make ceph ACL for symlink inheritable
Date: Sun, 16 Feb 2014 10:27:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402161027190.17892@cobra.newdream.net>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com> <1392355784-10422-4-git-send-email-lucienchao@gmail.com> <52FE14C2.7030805@ieee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41558 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbaBPS1u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Feb 2014 13:27:50 -0500
In-Reply-To: <52FE14C2.7030805@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org

This one is subsumed by Zheng's updated patch.

All of this is now in the testing branch.  Assuming all goes well I'll 
send it to Linus in the next day or two.

Thanks!
sage

On Fri, 14 Feb 2014, Alex Elder wrote:

> On 02/13/2014 11:29 PM, Guangliang Zhao wrote:
> > Default ACL couldn't be inherited by the symlink in the
> > parent directory. This resolve it.
> 
> This looks good to me, and it seems to be consistent
> with what other file systems do.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> > ---
> >  fs/ceph/dir.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 619616d..2650570 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -735,6 +735,10 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> >  	if (!err && !req->r_reply_info.head->is_dentry)
> >  		err = ceph_handle_notrace_create(dir, dentry);
> >  	ceph_mdsc_put_request(req);
> > +
> > +	if (!err)
> > +		err = ceph_init_acl(dentry, dentry->d_inode, dir);
> > +
> >  	if (err)
> >  		d_drop(dentry);
> >  	return err;
> > 
> 
> 
