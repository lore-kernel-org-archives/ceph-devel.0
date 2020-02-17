From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: fix dout logs for null pointers
Date: Mon, 17 Feb 2020 07:25:53 -0500
Message-ID: <a619e7b18c81e927fdd0b08509d1ca9d4299cdf9.camel@kernel.org>
References: <20200217112806.30738-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBQMZ4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:25:56 -0500
In-Reply-To: <20200217112806.30738-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Mon, 2020-02-17 at 06:28 -0500, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> For example, if dentry and inode is NULL, the log will be:
> ceph:  lookup result=000000007a1ca695
> ceph:  submit_request on 0000000041d5070e for inode 000000007a1ca695
> 
> The will be confusing without checking the corresponding code carefully.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/dir.c        | 2 +-
>  fs/ceph/mds_client.c | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index ffeaff5bf211..245a262ec198 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -798,7 +798,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>  	err = ceph_handle_snapdir(req, dentry, err);
>  	dentry = ceph_finish_lookup(req, dentry, err);
>  	ceph_mdsc_put_request(req);  /* will dput(dentry) */
> -	dout("lookup result=%p\n", dentry);
> +	dout("lookup result=%d\n", err);
>  	return dentry;
>  }
>  

The existing error handling in this function is really hard to follow
(the way that "err" is passed to subsequent functions). It really took
me a minute to figure out whether this change would make sense for all
the cases. I think it does, but it might be nice to do a larger
reorganization of this code if you're interested in improving it.

> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b6aa357f7c61..e34f159d262b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2772,7 +2772,11 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
>  		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
>  				  CEPH_CAP_PIN);
>  
> -	dout("submit_request on %p for inode %p\n", req, dir);
> +	if (dir)
> +		dout("submit_request on %p for inode %p\n", req, dir);
> +	else
> +		dout("submit_request on %p\n", req);
> +
>  	mutex_lock(&mdsc->mutex);
>  	__register_request(mdsc, req, dir);
>  	__do_request(mdsc, req);


I'll merge into testing later today.
-- 
Jeff Layton <jlayton@kernel.org>
