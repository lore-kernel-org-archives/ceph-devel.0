From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/3] libceph: reset BACKOFF if unable to re-queue
Date: Tue, 9 Oct 2012 14:33:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210091433270.11453@cobra.newdream.net>
References: <507497AC.5030609@inktank.com> <5074980C.6090104@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59379 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2JIVdf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:33:35 -0400
In-Reply-To: <5074980C.6090104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Tue, 9 Oct 2012, Alex Elder wrote:

> If ceph_fault() is unable to queue work after a delay, it sets the
> BACKOFF connection flag so con_work() will attempt to do so.
> 
> In con_work(), when BACKOFF is set, if queue_delayed_work() doesn't
> result in newly-queued work, it simply ignores this condition and
> proceeds as if no backoff delay were desired.  There are two
> problems with this--one of which is a bug.
> 
> The first problem is simply that the intended behavior is to back
> off, and if we aren't able queue the work item to run after a delay
> we're not doing that.
> 
> The only reason queue_delayed_work() won't queue work is if the
> provided work item is already queued.  In the messenger, this
> means that con_work() is already scheduled to be run again.  So
> if we simply set the BACKOFF flag again when this occurs, we know
> the next con_work() call will again attempt to hold off activity
> on the connection until after the delay.
> 
> The second problem--the bug--is a leak of a reference count.  If
> queue_delayed_work() returns 0 in con_work(), con->ops->put() drops
> the connection reference held on entry to con_work().  However,
> processing is (was) allowed to continue, and at the end of the
> function a second con->ops->put() is called.
> 
> This patch fixes both problems.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f9f65fe..ece06bc 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2300,10 +2300,11 @@ restart:
>  			mutex_unlock(&con->mutex);
>  			return;
>  		} else {
> -			con->ops->put(con);
>  			dout("con_work %p FAILED to back off %lu\n", con,
>  			     con->delay);
> +			set_bit(CON_FLAG_BACKOFF, &con->flags);
>  		}
> +		goto done;
>  	}
> 
>  	if (con->state == CON_STATE_STANDBY) {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
