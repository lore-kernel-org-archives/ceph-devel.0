From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 01/33] libceph: refer to osdmap directly in osdmap_show()
Date: Thu, 27 Mar 2014 14:09:50 -0500
Message-ID: <5334777E.8060805@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44555 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045AbaC0TJ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:09:28 -0400
Received: by mail-ig0-f177.google.com with SMTP id ur14so1999499igb.16
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:09:28 -0700 (PDT)
In-Reply-To: <1395944299-21970-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> To make it more readable and save screen space.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/debugfs.c |   26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 258a382e75ed..d225842c7b41 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -53,34 +53,36 @@ static int osdmap_show(struct seq_file *s, void *p)
>  {
>  	int i;
>  	struct ceph_client *client = s->private;
> +	struct ceph_osdmap *map = client->osdc.osdmap;
>  	struct rb_node *n;
>  
> -	if (client->osdc.osdmap == NULL)
> +	if (map == NULL)
>  		return 0;
> -	seq_printf(s, "epoch %d\n", client->osdc.osdmap->epoch);
> +
> +	seq_printf(s, "epoch %d\n", map->epoch);
>  	seq_printf(s, "flags%s%s\n",
> -		   (client->osdc.osdmap->flags & CEPH_OSDMAP_NEARFULL) ?
> -		   " NEARFULL" : "",
> -		   (client->osdc.osdmap->flags & CEPH_OSDMAP_FULL) ?
> -		   " FULL" : "");
> -	for (n = rb_first(&client->osdc.osdmap->pg_pools); n; n = rb_next(n)) {
> +		   (map->flags & CEPH_OSDMAP_NEARFULL) ?  " NEARFULL" : "",
> +		   (map->flags & CEPH_OSDMAP_FULL) ?  " FULL" : "");
> +
> +	for (n = rb_first(&map->pg_pools); n; n = rb_next(n)) {
>  		struct ceph_pg_pool_info *pool =
>  			rb_entry(n, struct ceph_pg_pool_info, node);
> +
>  		seq_printf(s, "pg_pool %llu pg_num %d / %d\n",
>  			   (unsigned long long)pool->id, pool->pg_num,
>  			   pool->pg_num_mask);
>  	}
> -	for (i = 0; i < client->osdc.osdmap->max_osd; i++) {
> -		struct ceph_entity_addr *addr =
> -			&client->osdc.osdmap->osd_addr[i];
> -		int state = client->osdc.osdmap->osd_state[i];
> +	for (i = 0; i < map->max_osd; i++) {
> +		struct ceph_entity_addr *addr = &map->osd_addr[i];
> +		int state = map->osd_state[i];
>  		char sb[64];
>  
>  		seq_printf(s, "\tosd%d\t%s\t%3d%%\t(%s)\n",
>  			   i, ceph_pr_addr(&addr->in_addr),
> -			   ((client->osdc.osdmap->osd_weight[i]*100) >> 16),
> +			   ((map->osd_weight[i]*100) >> 16),
>  			   ceph_osdmap_state_str(sb, sizeof(sb), state));
>  	}
> +
>  	return 0;
>  }
>  
> 

