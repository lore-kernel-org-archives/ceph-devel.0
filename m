From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 13/13] libceph: set CLOSED state bit in con_init
Date: Thu, 31 May 2012 21:32:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205312132170.2166@cobra.newdream.net>
References: <4FC673FC.3060004@inktank.com> <4FC6767C.8080207@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46278 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab2FAEc2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 00:32:28 -0400
In-Reply-To: <4FC6767C.8080207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Wed, 30 May 2012, Alex Elder wrote:

> Once a connection is fully initialized, it is really in a CLOSED
> state, so make that explicit by setting the bit in its state field.
> 
> It is possible for a connection in NEGOTIATING state to get a
> failure, leading to ceph_fault() and ultimately ceph_con_close().
> Clear that bits if it is set in that case, to reflect that the
> connection truly is closed and is no longer participating in a
> connect sequence.
> 
> Issue a warning if ceph_con_open() is called on a connection that
> is not in CLOSED state.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index cdf8299..85bfe12 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -452,10 +452,13 @@ void ceph_con_close(struct ceph_connection *con)
>  	dout("con_close %p peer %s\n", con,
>  	     ceph_pr_addr(&con->peer_addr.in_addr));
>  	set_bit(CLOSED, &con->state);  /* in case there's queued work */
> +	clear_bit(NEGOTIATING, &con->state);
>  	clear_bit(STANDBY, &con->state);  /* avoid connect_seq bump */
> +
>  	clear_bit(LOSSYTX, &con->flags);  /* so we retry next connect */
>  	clear_bit(KEEPALIVE_PENDING, &con->flags);
>  	clear_bit(WRITE_PENDING, &con->flags);
> +
>  	mutex_lock(&con->mutex);
>  	reset_connection(con);
>  	con->peer_global_seq = 0;
> @@ -472,7 +475,8 @@ void ceph_con_open(struct ceph_connection *con, struct
> ceph_entity_addr *addr)
>  {
>  	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
>  	set_bit(OPENING, &con->state);
> -	clear_bit(CLOSED, &con->state);
> +	WARN_ON(!test_and_clear_bit(CLOSED, &con->state));
> +
>  	memcpy(&con->peer_addr, addr, sizeof(*addr));
>  	con->delay = 0;      /* reset backoff memory */
>  	queue_con(con);
> @@ -534,6 +538,8 @@ void ceph_con_init(struct ceph_connection *con, void
> *private,
>  	INIT_LIST_HEAD(&con->out_queue);
>  	INIT_LIST_HEAD(&con->out_sent);
>  	INIT_DELAYED_WORK(&con->work, con_work);
> +
> +	set_bit(CLOSED, &con->state);
>  }
>  EXPORT_SYMBOL(ceph_con_init);
> 
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
