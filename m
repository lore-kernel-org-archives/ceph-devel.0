From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 30/33] libceph: add support for primary_temp mappings
Date: Thu, 27 Mar 2014 15:51:41 -0500
Message-ID: <53348F5D.4050306@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-31-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:55063 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbaC0UvT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:51:19 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so9690igc.8
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:51:19 -0700 (PDT)
In-Reply-To: <1395944299-21970-31-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Change apply_temp() to override primary in the same way pg_temp
> overrides osd set.  primary_temp overrides pg_temp primary too.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 7193b012ee02..ed52b47d0ddb 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1590,7 +1590,7 @@ static int raw_to_up_osds(struct ceph_osdmap *osdmap,
>  }
>  
>  /*
> - * Given up set, apply pg_temp mapping.
> + * Given up set, apply pg_temp and primary_temp mappings.
>   *
>   * Return acting set length.  *primary is set to acting primary osd id,
>   * or -1 if acting set is empty.
> @@ -1637,6 +1637,11 @@ static int apply_temps(struct ceph_osdmap *osdmap,
>  		temp_primary = *primary;
>  	}
>  
> +	/* primary_temp? */
> +	pg = __lookup_pg_mapping(&osdmap->primary_temp, pgid);
> +	if (pg)
> +		temp_primary = pg->primary_temp.osd;
> +
>  	*primary = temp_primary;
>  	return temp_len;
>  }
> 

