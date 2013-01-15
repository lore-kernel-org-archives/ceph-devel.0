From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST] libceph: reformat __reset_osd()
Date: Tue, 15 Jan 2013 15:10:49 -0800
Message-ID: <50F5E1F9.2080405@inktank.com>
References: <50E5D5E3.1080306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:40679 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab3AOXL7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 18:11:59 -0500
Received: by mail-pb0-f47.google.com with SMTP id wz17so335450pbc.34
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 15:11:58 -0800 (PST)
In-Reply-To: <50E5D5E3.1080306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 11:02 AM, Alex Elder wrote:
> Reformat __reset_osd() into three distinct blocks of code
> handling the three return cases.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Looks good. With one small duplication removed,
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   net/ceph/osd_client.c |   33 +++++++++++++++++++--------------
>   1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index eb9a444..5f9f65a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -739,31 +739,36 @@ static void remove_old_osds(struct ceph_osd_client
> *osdc)
>    */
>   static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
>   {
> -	struct ceph_osd_request *req;
> -	int ret = 0;
> +	struct ceph_entity_addr *peer_addr;
>
>   	dout("__reset_osd %p osd%d\n", osd, osd->o_osd);
>   	if (list_empty(&osd->o_requests) &&
>   	    list_empty(&osd->o_linger_requests)) {
>   		__remove_osd(osdc, osd);
> -		ret = -ENODEV;
> -	} else if (memcmp(&osdc->osdmap->osd_addr[osd->o_osd],
> -			  &osd->o_con.peer_addr,
> -			  sizeof(osd->o_con.peer_addr)) == 0 &&
> -		   !ceph_con_opened(&osd->o_con)) {
> +
> +		return -ENODEV;
> +	}
> +
> +	peer_addr = &osdc->osdmap->osd_addr[osd->o_osd];
> +	if (!memcmp(peer_addr, &osd->o_con.peer_addr, sizeof (*peer_addr)) &&
> +			!ceph_con_opened(&osd->o_con)) {
> +		struct ceph_osd_request *req;
> +
>   		dout(" osd addr hasn't changed and connection never opened,"
>   		     " letting msgr retry");
>   		/* touch each r_stamp for handle_timeout()'s benfit */
>   		list_for_each_entry(req, &osd->o_requests, r_osd_item)
>   			req->r_stamp = jiffies;
> -		ret = -EAGAIN;
> -	} else {
> -		ceph_con_close(&osd->o_con);
> -		ceph_con_open(&osd->o_con, CEPH_ENTITY_TYPE_OSD, osd->o_osd,
> -			      &osdc->osdmap->osd_addr[osd->o_osd]);
> -		osd->o_incarnation++;
> +
> +		return -EAGAIN;
>   	}
> -	return ret;
> +
> +	ceph_con_close(&osd->o_con);
> +	ceph_con_open(&osd->o_con, CEPH_ENTITY_TYPE_OSD, osd->o_osd,
> +		      &osdc->osdmap->osd_addr[osd->o_osd]);

This is peer_addr again.

> +	osd->o_incarnation++;
> +
> +	return 0;
>   }
>
>   static void __insert_osd(struct ceph_osd_client *osdc, struct ceph_osd
> *new)
>

