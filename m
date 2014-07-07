From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 14/14] libceph: drop osd ref when canceling con work
Date: Mon, 07 Jul 2014 17:38:37 -0500
Message-ID: <53BB216D.2010207@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-15-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34301 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbaGGWig (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 18:38:36 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so14081igd.2
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 15:38:36 -0700 (PDT)
In-Reply-To: <1403716607-13535-15-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> queue_con() bumps osd ref count.  We should do the reverse when
> canceling con work.

Kind of unrelated to the rest of the series, but it looks
good.  Good to have a same-level-of-abstraction function
for it as well.

Reviewed-by: Alex Elder <elder@linaro.org>
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/messenger.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 8bffa5b90fef..e51cad0db580 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -174,6 +174,7 @@ static struct lock_class_key socket_class;
>  #define SKIP_BUF_SIZE	1024
>  
>  static void queue_con(struct ceph_connection *con);
> +static void cancel_con(struct ceph_connection *con);
>  static void con_work(struct work_struct *);
>  static void con_fault(struct ceph_connection *con);
>  
> @@ -680,7 +681,7 @@ void ceph_con_close(struct ceph_connection *con)
>  
>  	reset_connection(con);
>  	con->peer_global_seq = 0;
> -	cancel_delayed_work(&con->work);
> +	cancel_con(con);
>  	con_close_socket(con);
>  	mutex_unlock(&con->mutex);
>  }
> @@ -2667,19 +2668,16 @@ static int queue_con_delay(struct ceph_connection *con, unsigned long delay)
>  {
>  	if (!con->ops->get(con)) {
>  		dout("%s %p ref count 0\n", __func__, con);
> -
>  		return -ENOENT;
>  	}
>  
>  	if (!queue_delayed_work(ceph_msgr_wq, &con->work, delay)) {
>  		dout("%s %p - already queued\n", __func__, con);
>  		con->ops->put(con);
> -
>  		return -EBUSY;
>  	}
>  
>  	dout("%s %p %lu\n", __func__, con, delay);
> -
>  	return 0;
>  }
>  
> @@ -2688,6 +2686,14 @@ static void queue_con(struct ceph_connection *con)
>  	(void) queue_con_delay(con, 0);
>  }
>  
> +static void cancel_con(struct ceph_connection *con)
> +{
> +	if (cancel_delayed_work(&con->work)) {
> +		dout("%s %p\n", __func__, con);
> +		con->ops->put(con);
> +	}
> +}
> +
>  static bool con_sock_closed(struct ceph_connection *con)
>  {
>  	if (!con_flag_test_and_clear(con, CON_FLAG_SOCK_CLOSED))
> 

