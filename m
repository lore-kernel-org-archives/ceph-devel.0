From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: Call con->ops->put(con) if cancel_delayed_work(&con->work)
 worked.
Date: Sun, 23 Jun 2013 20:30:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306232029480.20076@cobra.newdream.net>
References: <201306240921544358210@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306240921544358210@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: majianpeng <majianpeng@gmail.com>
Cc: davem <davem@davemloft.net>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, 24 Jun 2013, majianpeng wrote:
> Because in func queue_con_delay, it will call con->ops->get(con).
> So if we cancel the work successfully,we must call con->ops->put(con).
> Otherwise some resource can't free like 'struct ceph_mds_session'.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>

Looks good, applied to the testing branch.

Thanks!
sage

> ---
>  net/ceph/messenger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index eb0a46a..8207b37 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -661,7 +661,8 @@ void ceph_con_close(struct ceph_connection *con)
>  
>  	reset_connection(con);
>  	con->peer_global_seq = 0;
> -	cancel_delayed_work(&con->work);
> +	if (cancel_delayed_work(&con->work))
> +		con->ops->put(con);
>  	con_close_socket(con);
>  	mutex_unlock(&con->mutex);
>  }
> -- 
> 1.8.1.2
> 
