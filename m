From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/3] libceph: define common queue_con_delay()
Date: Tue, 9 Oct 2012 14:37:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210091437470.11453@cobra.newdream.net>
References: <507497AC.5030609@inktank.com> <50749821.9090907@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946Ab2JIVh4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:37:56 -0400
In-Reply-To: <50749821.9090907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Tue, 9 Oct 2012, Alex Elder wrote:

> This patch defines a single function, queue_con_delay() to call
> queue_delayed_work() for a connection.  It basically generalizes
> what was previously queue_con() by adding the delay argument.
> queue_con() is now a simple helper that passes 0 for its delay.
> queue_con_delay() returns 0 if it queued work or an errno if it
> did not for some reason.
> 
> If con_work() finds the BACKOFF flag set for a connection, it now
> calls queue_con_delay() to handle arranging to start again after a
> delay.
> 
> 
> Note about connection reference counts:  con_work() only ever gets
> called as a work item function.  At the time that work is scheduled,
> a reference to the connection is acquired, and the corresponding
> con_work() call is then responsible for dropping that reference
> before it returns.
> 
> Previously, the backoff handling inside con_work() silently handed
> off its reference to delayed work it scheduled.  Now that
> queue_con_delay() is used, a new reference is acquired for the
> newly-scheduled work, and the original reference is dropped by the
> con->ops->put() call at the end of the function.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |   38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 9170c20..77cc8b1 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2244,22 +2244,33 @@ bad_tag:
> 
> 
>  /*
> - * Atomically queue work on a connection.  Bump @con reference to
> - * avoid races with connection teardown.
> + * Atomically queue work on a connection after the specified delay.
> + * Bump @con reference to avoid races with connection teardown.
> + * Returns 0 if work was queued, or an error code otherwise.
>   */
> -static void queue_con(struct ceph_connection *con)
> +static int queue_con_delay(struct ceph_connection *con, unsigned long delay)
>  {
>  	if (!con->ops->get(con)) {
> -		dout("queue_con %p ref count 0\n", con);
> -		return;
> +		dout("%s %p ref count 0\n", __func__, con);
> +
> +		return -ENOENT;
>  	}
> 
> -	if (!queue_delayed_work(ceph_msgr_wq, &con->work, 0)) {
> -		dout("queue_con %p - already queued\n", con);
> +	if (!queue_delayed_work(ceph_msgr_wq, &con->work, delay)) {
> +		dout("%s %p - already queued\n", __func__, con);
>  		con->ops->put(con);
> -	} else {
> -		dout("queue_con %p\n", con);
> +
> +		return -EBUSY;
>  	}
> +
> +	dout("%s %p %lu\n", __func__, con, delay);
> +
> +	return 0;
> +}
> +
> +static void queue_con(struct ceph_connection *con)
> +{
> +	(void) queue_con_delay(con, 0);
>  }
> 
>  /*
> @@ -2294,14 +2305,11 @@ restart:
> 
>  	if (test_and_clear_bit(CON_FLAG_BACKOFF, &con->flags)) {
>  		dout("con_work %p backing off\n", con);
> -		if (queue_delayed_work(ceph_msgr_wq, &con->work,
> -				       round_jiffies_relative(con->delay))) {
> -			dout("con_work %p backoff %lu\n", con, con->delay);
> -			mutex_unlock(&con->mutex);
> -			return;
> -		} else {
> +		ret = queue_con_delay(con,
> round_jiffies_relative(con->delay));
> +		if (ret) {
>  			dout("con_work %p FAILED to back off %lu\n", con,
>  			     con->delay);
> +			BUG_ON(ret == -ENOENT);
>  			set_bit(CON_FLAG_BACKOFF, &con->flags);
>  		}
>  		goto done;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
