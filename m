From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH] libceph: kfree() in put_osd() shouldn't depend on authorizer
Date: Wed, 18 Feb 2015 09:47:51 -0600
Message-ID: <54E4B427.9080002@linaro.org>
References: <1424266039-40851-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42785 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbBRPrx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 10:47:53 -0500
Received: by iecrp18 with SMTP id rp18so2152853iec.9
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 07:47:52 -0800 (PST)
In-Reply-To: <1424266039-40851-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 02/18/2015 07:27 AM, Ilya Dryomov wrote:
> a255651d4cad ("ceph: ensure auth ops are defined before use") made
> kfree() in put_osd() conditional on the authorizer.  A mechanical
> mistake most likely - fix it.

You are generous in suggesting it's a mechanical mistake.
But it is a mistake nevertheless.  The fix looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Cc: Alex Elder <elder@linaro.org>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
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
> 

