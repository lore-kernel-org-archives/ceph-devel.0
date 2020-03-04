From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fs/ceph/export: remove unused variable 'err'
Date: Wed, 04 Mar 2020 15:36:54 -0500
Message-ID: <f09ffef023cfb8740f6a9a289215e53a16bebb2d.camel@kernel.org>
References: <1583252499-16078-1-git-send-email-hqjagain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583252499-16078-1-git-send-email-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qiujun Huang <hqjagain@gmail.com>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 2020-03-04 at 00:21 +0800, Qiujun Huang wrote:
> fix gcc '-Wunused-but-set-variable' warning:
> fs/ceph/export.c: In function ‘__get_parent’:
> fs/ceph/export.c:294:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
>   int err;
> 
> and needn't use the return value of ceph_mdsc_create_request.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  fs/ceph/export.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index b6bfa94..b7bb41c 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -291,7 +291,6 @@ static struct dentry *__get_parent(struct super_block *sb,
>  	struct ceph_mds_request *req;
>  	struct inode *inode;
>  	int mask;
> -	int err;
>  
>  	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPPARENT,
>  				       USE_ANY_MDS);
> @@ -314,7 +313,7 @@ static struct dentry *__get_parent(struct super_block *sb,
>  	req->r_args.getattr.mask = cpu_to_le32(mask);
>  
>  	req->r_num_caps = 1;
> -	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	ceph_mdsc_do_request(mdsc, NULL, req);
>  	inode = req->r_target_inode;
>  	if (inode)
>  		ihold(inode);

I think we probably ought to just return ERR_PTR(err) in that case
instead of discarding it. It looks like today we'll end up returning
ENOENT when that errors out which doesn't seem right when there is a
different issue.

-- 
Jeff Layton <jlayton@kernel.org>
