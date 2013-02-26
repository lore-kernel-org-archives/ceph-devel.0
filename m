From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: fix a osd request memory leak
Date: Tue, 26 Feb 2013 10:12:15 -0800
Message-ID: <512CFAFF.9030401@inktank.com>
References: <512BE76B.5040104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54231 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab3BZSMn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 13:12:43 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so2600396pab.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 10:12:43 -0800 (PST)
In-Reply-To: <512BE76B.5040104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/25/2013 02:36 PM, Alex Elder wrote:
> If an invalid layout is provided to ceph_osdc_new_request(), its
> call to calc_layout() might return an error.  At that point in the
> function we've already allocated an osd request structure, so we
> need to free it (drop a reference) in the event such an error
> occurs.
>
> The only other value calc_layout() will return is 0, so make that
> explicit in the successful case.
>
> This resolves:
>      http://tracker.ceph.com/issues/4240
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 39629b6..5daced2 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -109,7 +109,7 @@ static int calc_layout(struct ceph_vino vino,
>   	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
>   	req->r_oid_len = strlen(req->r_oid);
>
> -	return r;
> +	return 0;
>   }
>
>   /*
> @@ -437,8 +437,10 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>
>   	/* calculate max write size */
>   	r = calc_layout(vino, layout, off, plen, req, ops);
> -	if (r < 0)
> +	if (r < 0) {
> +		ceph_osdc_put_request(req);
>   		return ERR_PTR(r);
> +	}
>   	req->r_file_layout = *layout;  /* keep a copy */
>
>   	/* in case it differs from natural (file) alignment that
>

