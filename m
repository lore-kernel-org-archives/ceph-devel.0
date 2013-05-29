From: Alex Elder <elder@inktank.com>
Subject: Re: [patch] ceph: tidy ceph_mdsmap_decode() a little
Date: Wed, 29 May 2013 06:45:33 -0500
Message-ID: <51A5EA5D.6010408@inktank.com>
References: <20130529062213.GF23932@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130529062213.GF23932@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On 05/29/2013 01:22 AM, Dan Carpenter wrote:
> I introduced a new temporary variable "info" instead of
> "m->m_info[mds]".  Also I reversed the if condition and pulled
> everything in one indent level.

Looks good.  I will apply this for you.

Reviewed-by: Alex Elder <elder@inktank.com>

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This goes on top of Emil Goode's patch.
> 
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index d4d3897..132b64e 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -92,6 +92,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
>  		u32 num_export_targets;
>  		void *pexport_targets = NULL;
>  		struct ceph_timespec laggy_since;
> +		struct ceph_mds_info *info;
>  
>  		ceph_decode_need(p, end, sizeof(u64)*2 + 1 + sizeof(u32), bad);
>  		global_id = ceph_decode_64(p);

. . .
