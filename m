From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 9/9] libceph: socket can close in any connection state
Date: Fri, 14 Dec 2012 21:18:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212142118180.23307@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA0A4C.8060503@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42332 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2LOFS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 00:18:26 -0500
In-Reply-To: <50CA0A4C.8060503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 13 Dec 2012, Alex Elder wrote:

> A connection's socket can close for any reason, independent of the
> state of the connection (and without irrespective of the connection
> mutex).  As a result, the connectino can be in pretty much any state
> at the time its socket is closed.
> 
> Handle those other cases at the top of con_work().  Pull this whole
> block of code into a separate function to reduce the clutter.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |   47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 1041114..4b04ccc 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2273,6 +2273,35 @@ static void queue_con(struct ceph_connection *con)
>  	(void) queue_con_delay(con, 0);
>  }
> 
> +static bool con_sock_closed(struct ceph_connection *con)
> +{
> +	if (!test_and_clear_bit(CON_FLAG_SOCK_CLOSED, &con->flags))
> +		return false;
> +
> +#define CASE(x)								\
> +	case CON_STATE_ ## x:						\
> +		con->error_msg = "socket closed (con state " #x ")";	\
> +		break;
> +
> +	switch (con->state) {
> +	CASE(CLOSED);
> +	CASE(PREOPEN);
> +	CASE(CONNECTING);
> +	CASE(NEGOTIATING);
> +	CASE(OPEN);
> +	CASE(STANDBY);
> +	default:
> +		pr_warning("%s con %p unrecognized state %lu\n",
> +			__func__, con, con->state);
> +		con->error_msg = "unrecognized con state";
> +		BUG();
> +		break;
> +	}
> +#undef CASE
> +
> +	return true;
> +}
> +
>  /*
>   * Do some work on a connection.  Drop a connection ref when we're done.
>   */
> @@ -2284,24 +2313,8 @@ static void con_work(struct work_struct *work)
> 
>  	mutex_lock(&con->mutex);
>  restart:
> -	if (test_and_clear_bit(CON_FLAG_SOCK_CLOSED, &con->flags)) {
> -		switch (con->state) {
> -		case CON_STATE_CONNECTING:
> -			con->error_msg = "connection failed";
> -			break;
> -		case CON_STATE_NEGOTIATING:
> -			con->error_msg = "negotiation failed";
> -			break;
> -		case CON_STATE_OPEN:
> -			con->error_msg = "socket closed";
> -			break;
> -		default:
> -			dout("unrecognized con state %d\n", (int)con->state);
> -			con->error_msg = "unrecognized con state";
> -			BUG();
> -		}
> +	if (con_sock_closed(con))
>  		goto fault;
> -	}
> 
>  	if (test_and_clear_bit(CON_FLAG_BACKOFF, &con->flags)) {
>  		dout("con_work %p backing off\n", con);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
