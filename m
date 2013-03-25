From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/6] libceph: clear messenger auth_retry flag when we
 authenticate
Date: Mon, 25 Mar 2013 08:32:06 -0500
Message-ID: <515051D6.3020206@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:43639 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960Ab3CYNcJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 09:32:09 -0400
Received: by mail-ia0-f175.google.com with SMTP id y26so5382249iab.6
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 06:32:08 -0700 (PDT)
In-Reply-To: <1363734486-26879-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/19/2013 06:08 PM, Sage Weil wrote:
> We maintain a counter of failed auth attempts to allow us to retry once
> before failing.  However, if the second attempt succeeds, the flag isn't
> cleared, which makes us think auth failed again later when the connection
> resets for other reasons (like a socket error).
> 
> This is one part of the sorry sequence of events in bug
> 
> 	http://tracker.ceph.com/issues/4282
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks good.  Question/suggestion below.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 997dacc..19af956 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1988,7 +1988,6 @@ static int process_connect(struct ceph_connection *con)
>  			con->error_msg = "connect authorization failure";
>  			return -1;
>  		}
> -		con->auth_retry = 1;

This dates back to when this code was originally added.
Not technically a bug but it's good to get rid of this.

Do we ever envision allowing more than a single retry?
If so this could truly be a flag (possibly renamed)
rather than a count.

>  		con_out_kvec_reset(con);
>  		ret = prepare_write_connect(con);
>  		if (ret < 0)
> @@ -2073,7 +2072,7 @@ static int process_connect(struct ceph_connection *con)
>  
>  		WARN_ON(con->state != CON_STATE_NEGOTIATING);
>  		con->state = CON_STATE_OPEN;
> -
> +		con->auth_retry = 0;    /* we authenticated; clear flag */
>  		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
>  		con->connect_seq++;
>  		con->peer_features = server_feat;
> 

