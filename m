From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/8] libceph: verify state after retaking con lock after
 dispatch
Date: Mon, 30 Jul 2012 19:11:07 -0500
Message-ID: <5017229B.60805@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com> <1343663971-3221-6-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47379 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2GaALI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 20:11:08 -0400
Received: by yhmm54 with SMTP id m54so5517415yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 17:11:08 -0700 (PDT)
In-Reply-To: <1343663971-3221-6-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 10:59 AM, Sage Weil wrote:
> We drop the con mutex when delivering a message.  When we retake the
> lock, we need to verify we are still in the OPEN state before
> preparing to read the next tag, or else we risk stepping on a
> connection that has been closed.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks good.  And good to move the prepare_read_tag() out too.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index a6a0c7a..feb5a2a 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2003,7 +2003,6 @@ static void process_message(struct ceph_connection *con)
>  	con->ops->dispatch(con, msg);
>  
>  	mutex_lock(&con->mutex);
> -	prepare_read_tag(con);
>  }
>  
>  
> @@ -2213,6 +2212,8 @@ more:
>  		if (con->in_tag == CEPH_MSGR_TAG_READY)
>  			goto more;
>  		process_message(con);
> +		if (con->state == CON_STATE_OPEN)
> +			prepare_read_tag(con);
>  		goto more;
>  	}
>  	if (con->in_tag == CEPH_MSGR_TAG_ACK) {
> 

