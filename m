From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 03/33] libceph: dump pg_temp mappings to debugfs
Date: Thu, 27 Mar 2014 14:11:36 -0500
Message-ID: <533477E8.4040706@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-4-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33906 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239AbaC0TLP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:11:15 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so3966035iec.10
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:11:14 -0700 (PDT)
In-Reply-To: <1395944299-21970-4-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> Dump pg_temp mappings to /sys/kernel/debug/ceph/<client>/osdmap,
> one 'pg_temp <pgid> [<osd>, ..., <osd>]' per line, e.g:
> 
>     pg_temp 2.6 [2,3,4]
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

I didn't look at the broader context, but the new code looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/debugfs.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 112d98edb156..c45d235e774e 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -82,6 +82,17 @@ static int osdmap_show(struct seq_file *s, void *p)
>  			   ((map->osd_weight[i]*100) >> 16),
>  			   ceph_osdmap_state_str(sb, sizeof(sb), state));
>  	}
> +	for (n = rb_first(&map->pg_temp); n; n = rb_next(n)) {
> +		struct ceph_pg_mapping *pg =
> +			rb_entry(n, struct ceph_pg_mapping, node);
> +
> +		seq_printf(s, "pg_temp %llu.%x [", pg->pgid.pool,
> +			   pg->pgid.seed);
> +		for (i = 0; i < pg->len; i++)
> +			seq_printf(s, "%s%d", (i == 0 ? "" : ","),
> +				   pg->osds[i]);
> +		seq_printf(s, "]\n");
> +	}
>  
>  	return 0;
>  }
> 

