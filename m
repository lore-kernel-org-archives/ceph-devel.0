From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3] fs:ceph: Remove unused variables in
 ceph_mdsmap_decode()
Date: Thu, 23 Jul 2020 06:39:49 -0400
Message-ID: <c6a65d700a64d6af48203b4c37072ca09d29210b.camel@kernel.org>
References: <20200723022552.45775-1-jiayang5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWKjv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:39:51 -0400
In-Reply-To: <20200723022552.45775-1-jiayang5@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jia Yang <jiayang5@huawei.com>, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org

On Thu, 2020-07-23 at 10:25 +0800, Jia Yang wrote:
> Fix build warnings:
> 
> fs/ceph/mdsmap.c: In function ‘ceph_mdsmap_decode’:
> fs/ceph/mdsmap.c:192:7: warning:
> variable ‘info_cv’ set but not used [-Wunused-but-set-variable]
> fs/ceph/mdsmap.c:177:7: warning:
> variable ‘state_seq’ set but not used [-Wunused-but-set-variable]
> fs/ceph/mdsmap.c:123:15: warning:
> variable ‘mdsmap_cv’ set but not used [-Wunused-but-set-variable]
> 
> Note that p is increased in ceph_decode_*.
> 
> Signed-off-by: Jia Yang <jiayang5@huawei.com>
> ---
>  fs/ceph/mdsmap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 889627817e52..e4aba6c6d3b5 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -120,7 +120,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  	const void *start = *p;
>  	int i, j, n;
>  	int err;
> -	u8 mdsmap_v, mdsmap_cv;
> +	u8 mdsmap_v;
>  	u16 mdsmap_ev;
>  
>  	m = kzalloc(sizeof(*m), GFP_NOFS);
> @@ -129,7 +129,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  
>  	ceph_decode_need(p, end, 1 + 1, bad);
>  	mdsmap_v = ceph_decode_8(p);
> -	mdsmap_cv = ceph_decode_8(p);
> +	*p += sizeof(u8);			/* mdsmap_cv */
>  	if (mdsmap_v >= 4) {
>  	       u32 mdsmap_len;
>  	       ceph_decode_32_safe(p, end, mdsmap_len, bad);
> @@ -174,7 +174,6 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  		u64 global_id;
>  		u32 namelen;
>  		s32 mds, inc, state;
> -		u64 state_seq;
>  		u8 info_v;
>  		void *info_end = NULL;
>  		struct ceph_entity_addr addr;
> @@ -189,9 +188,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  		info_v= ceph_decode_8(p);
>  		if (info_v >= 4) {
>  			u32 info_len;
> -			u8 info_cv;
>  			ceph_decode_need(p, end, 1 + sizeof(u32), bad);
> -			info_cv = ceph_decode_8(p);
> +			*p += sizeof(u8);	/* info_cv */
>  			info_len = ceph_decode_32(p);
>  			info_end = *p + info_len;
>  			if (info_end > end)
> @@ -210,7 +208,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  		mds = ceph_decode_32(p);
>  		inc = ceph_decode_32(p);
>  		state = ceph_decode_32(p);
> -		state_seq = ceph_decode_64(p);
> +		*p += sizeof(u64);		/* state_seq */
>  		err = ceph_decode_entity_addr(p, end, &addr);
>  		if (err)
>  			goto corrupt;

Thanks, Jia. Merged into testing branch.
-- 
Jeff Layton <jlayton@kernel.org>
