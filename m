From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/6] libceph: fix authorizer invalidation
Date: Mon, 25 Mar 2013 08:39:08 -0500
Message-ID: <5150537C.7040301@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com> <1363734486-26879-2-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:35297 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533Ab3CYNjH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 09:39:07 -0400
Received: by mail-ia0-f175.google.com with SMTP id y26so5404334iab.20
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 06:39:07 -0700 (PDT)
In-Reply-To: <1363734486-26879-2-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/19/2013 06:08 PM, Sage Weil wrote:
> We were invalidating the authorizer by removing the ticket handler
> entirely.  This was effective in inducing us to request a new authorizer,
> but in the meantime it mean that any authorizer we generated would get a
> new and initialized handler with secret_id=0, which would always be
> rejected by the server side with a confusing error message:
> 
>  auth: could not find secret_id=0
>  cephx: verify_authorizer could not get service secret for service osd secret_id=0
> 
> Instead, simply clear the validity field.  This will still induce the auth
> code to request a new secret, but will let us continue to use the old
> ticket in the meantime.  The messenger code will probably continue to fail,
> but the exponential backoff will kick in, and eventually the we will get a
> new (hopefully more valid) ticket from the mon and be able to continue.

This does seem like a smaller hammer way of invalidating
the authorizer, namely making its validity (time after
which it is no longer valid) be a time in the past.

I am not well versed in the bigger picture of this
mechanism, but this change looks good to me.

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/auth_x.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index a16bf14..bd8758d 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -630,7 +630,7 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
>  
>  	th = get_ticket_handler(ac, peer_type);
>  	if (!IS_ERR(th))
> -		remove_ticket_handler(ac, th);
> +		memset(&th->validity, 0, sizeof(th->validity));
>  }
>  
>  
> 

