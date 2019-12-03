From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
Date: Tue, 03 Dec 2019 13:55:04 -0500
Message-ID: <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
         <20191203051945.9440-4-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203051945.9440-4-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, arnd@arndb.de, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On Mon, 2019-12-02 at 21:19 -0800, Deepa Dinamani wrote:
> Since ceph always uses ns granularity, skip the
> truncation which is a no-op.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: jlayton@kernel.org
> Cc: ceph-devel@vger.kernel.org
> ---
>  fs/ceph/mds_client.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 068b029cf073..88687ed65cff 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2069,7 +2069,6 @@ struct ceph_mds_request *
>  ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>  {
>  	struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
> -	struct timespec64 ts;
>  
>  	if (!req)
>  		return ERR_PTR(-ENOMEM);
> @@ -2088,8 +2087,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>  	init_completion(&req->r_safe_completion);
>  	INIT_LIST_HEAD(&req->r_unsafe_item);
>  
> -	ktime_get_coarse_real_ts64(&ts);
> -	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
> +	ktime_get_coarse_real_ts64(&req->r_stamp);
>  
>  	req->r_op = op;
>  	req->r_direct_mode = mode;

Thanks Deepa. We'll plan to take this one in via the ceph tree.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>
