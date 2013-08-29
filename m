From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH] libceph: use pg_num_mask instead of pgp_num_mask for
 pg.seed calc
Date: Thu, 29 Aug 2013 09:24:05 -0500
Message-ID: <521F5985.8040909@linaro.org>
References: <1377735546-8732-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1377735546-8732-1-git-send-email-sage@inktank.com>
Sender: stable-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 08/28/2013 07:19 PM, Sage Weil wrote:
> Fix a typo that used the wrong bitmask for the pg.seed calculation.  This
> is normally unnoticed because in most cases pg_num == pgp_num.  It is, however,
> a bug that is easily corrected.

Looks good to me.  The other two uses of pgp_num_mask are coupled with
pgp_num (not pg_num) in a ceph_stable_mod() call.

Reviewed-by: Alex Elder <elder@linaro.org>

> CC: stable@vger.kernel.org
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/osdmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 603ddd9..dbd9a47 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1129,7 +1129,7 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
>  
>  	/* pg_temp? */
>  	pgid.seed = ceph_stable_mod(pgid.seed, pool->pg_num,
> -				    pool->pgp_num_mask);
> +				    pool->pg_num_mask);
>  	pg = __lookup_pg_mapping(&osdmap->pg_temp, pgid);
>  	if (pg) {
>  		*num = pg->len;
> 
