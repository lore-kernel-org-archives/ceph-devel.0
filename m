From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/3] libceph: WARN, don't BUG on unexpected connection
 states
Date: Thu, 27 Dec 2012 16:57:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212271655190.22449@cobra.newdream.net>
References: <50DCD544.8000602@inktank.com> <50DCD720.4070909@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab2L1A5H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 19:57:07 -0500
In-Reply-To: <50DCD720.4070909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

I agree that we should do BUG -> WARN on con->state everywhere.

But I don't think we should drop any of them, yet.  For Ugis's particular 
crash, it was fail_protocol()'s fault... see my other patch.  The rest of 
the time, a socket close should be caught at the top of con_work().

For any other cases where we see con->state changing when we don't expect 
it to, let's look at them on a case-by-case basis and address them in 
separate patches?

sage


On Thu, 27 Dec 2012, Alex Elder wrote:

> A number of assertions in the ceph messenger are implemented with
> BUG_ON(), killing the system if connection's state doesn't match
> what's expected.  At this point our state model is (evidently) not
> well understood enough for these assertions to trigger a BUG().
> Convert all BUG_ON(con->state...) calls to be WARN_ON(con->state...)
> so we learn about these issues without killing the machine.
> 
> We now recognize that a connection fault can occur due to a socket
> closure at any time, regardless of the state of the connection.  So
> there is really nothing we can assert about the state of the
> connection at that point so eliminate that assertion.
> 
> Reported-by: Ugis <ugis22@gmail.com>
> Tested-by: Ugis <ugis22@gmail.com>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 4d111fd..075b9fd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -561,7 +561,7 @@ void ceph_con_open(struct ceph_connection *con,
>  	mutex_lock(&con->mutex);
>  	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
> 
> -	BUG_ON(con->state != CON_STATE_CLOSED);
> +	WARN_ON(con->state != CON_STATE_CLOSED);
>  	con->state = CON_STATE_PREOPEN;
> 
>  	con->peer_name.type = (__u8) entity_type;
> @@ -1509,7 +1509,7 @@ static int process_banner(struct ceph_connection *con)
>  static void fail_protocol(struct ceph_connection *con)
>  {
>  	reset_connection(con);
> -	BUG_ON(con->state != CON_STATE_NEGOTIATING);
> +	WARN_ON(con->state != CON_STATE_NEGOTIATING);
>  	con->state = CON_STATE_CLOSED;
>  }
> 
> @@ -1635,7 +1635,7 @@ static int process_connect(struct ceph_connection
> *con)
>  			return -1;
>  		}
> 
> -		BUG_ON(con->state != CON_STATE_NEGOTIATING);
> +		WARN_ON(con->state != CON_STATE_NEGOTIATING);
>  		con->state = CON_STATE_OPEN;
> 
>  		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
> @@ -2132,7 +2132,6 @@ more:
>  		if (ret < 0)
>  			goto out;
> 
> -		BUG_ON(con->state != CON_STATE_CONNECTING);
>  		con->state = CON_STATE_NEGOTIATING;
> 
>  		/*
> @@ -2160,7 +2159,7 @@ more:
>  		goto more;
>  	}
> 
> -	BUG_ON(con->state != CON_STATE_OPEN);
> +	WARN_ON(con->state != CON_STATE_OPEN);
> 
>  	if (con->in_base_pos < 0) {
>  		/*
> @@ -2382,10 +2381,6 @@ static void ceph_fault(struct ceph_connection *con)
>  	dout("fault %p state %lu to peer %s\n",
>  	     con, con->state, ceph_pr_addr(&con->peer_addr.in_addr));
> 
> -	BUG_ON(con->state != CON_STATE_CONNECTING &&
> -	       con->state != CON_STATE_NEGOTIATING &&
> -	       con->state != CON_STATE_OPEN);
> -
>  	con_close_socket(con);
> 
>  	if (test_bit(CON_FLAG_LOSSYTX, &con->flags)) {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
