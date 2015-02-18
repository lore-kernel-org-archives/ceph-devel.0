From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: kfree() in put_osd() shouldn't depend on
 authorizer
Date: Wed, 18 Feb 2015 07:18:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502180718400.22050@cobra.newdream.net>
References: <1424266039-40851-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50486 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbbBRPSw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 10:18:52 -0500
In-Reply-To: <1424266039-40851-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Wed, 18 Feb 2015, Ilya Dryomov wrote:
> a255651d4cad ("ceph: ensure auth ops are defined before use") made
> kfree() in put_osd() conditional on the authorizer.  A mechanical
> mistake most likely - fix it.
> 
> Cc: Alex Elder <elder@linaro.org>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>
> ---
>  net/ceph/osd_client.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index f693a2f8ac86..41a4abc7e98e 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1035,10 +1035,11 @@ static void put_osd(struct ceph_osd *osd)
>  {
>  	dout("put_osd %p %d -> %d\n", osd, atomic_read(&osd->o_ref),
>  	     atomic_read(&osd->o_ref) - 1);
> -	if (atomic_dec_and_test(&osd->o_ref) && osd->o_auth.authorizer) {
> +	if (atomic_dec_and_test(&osd->o_ref)) {
>  		struct ceph_auth_client *ac = osd->o_osdc->client->monc.auth;
>  
> -		ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
> +		if (osd->o_auth.authorizer)
> +			ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
>  		kfree(osd);
>  	}
>  }
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
