From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 4/9] libceph: fix mutex coverage for ceph_con_close
Date: Mon, 30 Jul 2012 13:43:29 -0500
Message-ID: <5016D5D1.7060108@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com> <1342831308-18815-5-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34982 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab2G3Sna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 14:43:30 -0400
Received: by ghrr11 with SMTP id r11so5194733ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 11:43:29 -0700 (PDT)
In-Reply-To: <1342831308-18815-5-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/20/2012 07:41 PM, Sage Weil wrote:
> Hold the mutex while twiddling all of the state bits to avoid possible
> races.  While we're here, make not of why we cannot close the socket
> directly.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks OK to me.  A quick scan seems to show that the
state and flag bits are *almost* always set while the
mutex is held.  The one counterexample I found was for
the STANDBY state bit in clear_standby() (but I really
didn't look very closely).

Anyway, I think this looks fine--it makes things safer
even if there could be another imperfection somewhere.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 7105908..e24310e 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -503,6 +503,7 @@ static void reset_connection(struct ceph_connection *con)
>   */
>  void ceph_con_close(struct ceph_connection *con)
>  {
> +	mutex_lock(&con->mutex);
>  	dout("con_close %p peer %s\n", con,
>  	     ceph_pr_addr(&con->peer_addr.in_addr));
>  	clear_bit(NEGOTIATING, &con->state);
> @@ -515,11 +516,16 @@ void ceph_con_close(struct ceph_connection *con)
>  	clear_bit(KEEPALIVE_PENDING, &con->flags);
>  	clear_bit(WRITE_PENDING, &con->flags);
>  
> -	mutex_lock(&con->mutex);
>  	reset_connection(con);
>  	con->peer_global_seq = 0;
>  	cancel_delayed_work(&con->work);
>  	mutex_unlock(&con->mutex);
> +
> +	/*
> +	 * We cannot close the socket directly from here because the
> +	 * work threads use it without holding the mutex.  Instead, let
> +	 * con_work() do it.
> +	 */
>  	queue_con(con);
>  }
>  EXPORT_SYMBOL(ceph_con_close);
> 

