From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 09/12] libceph: distinguish two phases of connect sequence
Date: Thu, 21 Jun 2012 11:44:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206211141460.23422@cobra.newdream.net>
References: <4FE32C84.2050408@inktank.com> <4FE32E28.8030006@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34755 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164Ab2FUSoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 14:44:46 -0400
In-Reply-To: <4FE32E28.8030006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

I get the feeling that all of these lists of clear/set_bit calls would go 
away if we

- verify we are under the mutex at each of these sites
- replace con->state with an enum

Is there a reason you stopped short of doing that (besides time)?

sage


On Thu, 21 Jun 2012, Alex Elder wrote:

> Currently a ceph connection enters a "CONNECTING" state when it
> begins the process of (re-)connecting with its peer.  Once the two
> ends have successfully exchanged their banner and addresses, an
> additional NEGOTIATING bit is set in the ceph connection's state to
> indicate the connection information exhange has begun.  The
> CONNECTING bit/state continues to be set during this phase.
> 
> Rather than have the CONNECTING state continue while the NEGOTIATING
> bit is set, interpret these two phases as distinct states.  In other
> words, when NEGOTIATING is set, clear CONNECTING.  That way only
> one of them will be active at a time.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |   48
> ++++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> 
> Index: b/net/ceph/messenger.c
> ===================================================================
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1583,7 +1583,6 @@ static int process_connect(struct ceph_c
>  			return -1;
>  		}
>  		clear_bit(NEGOTIATING, &con->state);
> -		clear_bit(CONNECTING, &con->state);
>  		set_bit(CONNECTED, &con->state);
>  		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
>  		con->connect_seq++;
> @@ -2025,7 +2024,8 @@ more_kvec:
>  	}
> 
>  do_next:
> -	if (!test_bit(CONNECTING, &con->state)) {
> +	if (!test_bit(CONNECTING, &con->state) &&
> +			!test_bit(NEGOTIATING, &con->state)) {
>  		/* is anything else pending? */
>  		if (!list_empty(&con->out_queue)) {
>  			prepare_write_message(con);
> @@ -2082,25 +2082,29 @@ more:
>  	}
> 
>  	if (test_bit(CONNECTING, &con->state)) {
> -		if (!test_bit(NEGOTIATING, &con->state)) {
> -			dout("try_read connecting\n");
> -			ret = read_partial_banner(con);
> -			if (ret <= 0)
> -				goto out;
> -			ret = process_banner(con);
> -			if (ret < 0)
> -				goto out;
> +		dout("try_read connecting\n");
> +		ret = read_partial_banner(con);
> +		if (ret <= 0)
> +			goto out;
> +		ret = process_banner(con);
> +		if (ret < 0)
> +			goto out;
> 
> -			/* Banner is good, exchange connection info */
> -			ret = prepare_write_connect(con);
> -			if (ret < 0)
> -				goto out;
> -			prepare_read_connect(con);
> -			set_bit(NEGOTIATING, &con->state);
> +		clear_bit(CONNECTING, &con->state);
> +		set_bit(NEGOTIATING, &con->state);
> 
> -			/* Send connection info before awaiting response */
> +		/* Banner is good, exchange connection info */
> +		ret = prepare_write_connect(con);
> +		if (ret < 0)
>  			goto out;
> -		}
> +		prepare_read_connect(con);
> +
> +		/* Send connection info before awaiting response */
> +		goto out;
> +	}
> +
> +	if (test_bit(NEGOTIATING, &con->state)) {
> +		dout("try_read negotiating\n");
>  		ret = read_partial_connect(con);
>  		if (ret <= 0)
>  			goto out;
> @@ -2222,12 +2226,12 @@ restart:
>  	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
>  		if (test_and_clear_bit(CONNECTED, &con->state))
>  			con->error_msg = "socket closed";
> -		else if (test_and_clear_bit(CONNECTING, &con->state)) {
> -			clear_bit(NEGOTIATING, &con->state);
> +		else if (test_and_clear_bit(NEGOTIATING, &con->state))
> +			con->error_msg = "negotiation failed";
> +		else if (test_and_clear_bit(CONNECTING, &con->state))
>  			con->error_msg = "connection failed";
> -		} else {
> +		else
>  			con->error_msg = "unrecognized con state";
> -		}
>  		goto fault;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
