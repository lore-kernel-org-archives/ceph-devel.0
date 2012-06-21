From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 11/12] libceph: make ceph_con_get() (etc.) private
Date: Thu, 21 Jun 2012 12:44:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206211244220.23422@cobra.newdream.net>
References: <4FE32C84.2050408@inktank.com> <4FE32E35.3000807@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355Ab2FUTp4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 15:45:56 -0400
In-Reply-To: <4FE32E35.3000807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

These should actually go away entirely; pushed a couple patches that do 
that, and remove the now-unused con->nref member.

sage

On Thu, 21 Jun 2012, Alex Elder wrote:

> The functions ceph_con_get() and ceph_con_put() are both only ever
> used in "net/ceph/messenger.c", so change them to have static scope.
> Move their definition up in the source file so they're both defined
> before their first use.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  include/linux/ceph/messenger.h |    2 -
>  net/ceph/messenger.c           |   48
> ++++++++++++++++++++---------------------
>  2 files changed, 24 insertions(+), 26 deletions(-)
> 
> Index: b/include/linux/ceph/messenger.h
> ===================================================================
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -245,8 +245,6 @@ extern void ceph_msg_revoke(struct ceph_
>  extern void ceph_msg_revoke_incoming(struct ceph_msg *msg);
> 
>  extern void ceph_con_keepalive(struct ceph_connection *con);
> -extern struct ceph_connection *ceph_con_get(struct ceph_connection *con);
> -extern void ceph_con_put(struct ceph_connection *con);
> 
>  extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
>  				     bool can_fail);
> Index: b/net/ceph/messenger.c
> ===================================================================
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -408,6 +408,30 @@ static int con_close_socket(struct ceph_
>  }
> 
>  /*
> + * generic get/put
> + */
> +static struct ceph_connection *ceph_con_get(struct ceph_connection *con)
> +{
> +	int nref = __atomic_add_unless(&con->nref, 1, 0);
> +
> +	dout("con_get %p nref = %d -> %d\n", con, nref, nref + 1);
> +
> +	return nref ? con : NULL;
> +}
> +
> +static void ceph_con_put(struct ceph_connection *con)
> +{
> +	int nref = atomic_dec_return(&con->nref);
> +
> +	BUG_ON(nref < 0);
> +	if (nref == 0) {
> +		BUG_ON(con->sock);
> +		kfree(con);
> +	}
> +	dout("con_put %p nref = %d -> %d\n", con, nref + 1, nref);
> +}
> +
> +/*
>   * Reset a connection.  Discard all incoming and outgoing messages
>   * and clear *_seq state.
>   */
> @@ -504,30 +528,6 @@ bool ceph_con_opened(struct ceph_connect
>  }
> 
>  /*
> - * generic get/put
> - */
> -struct ceph_connection *ceph_con_get(struct ceph_connection *con)
> -{
> -	int nref = __atomic_add_unless(&con->nref, 1, 0);
> -
> -	dout("con_get %p nref = %d -> %d\n", con, nref, nref + 1);
> -
> -	return nref ? con : NULL;
> -}
> -
> -void ceph_con_put(struct ceph_connection *con)
> -{
> -	int nref = atomic_dec_return(&con->nref);
> -
> -	BUG_ON(nref < 0);
> -	if (nref == 0) {
> -		BUG_ON(con->sock);
> -		kfree(con);
> -	}
> -	dout("con_put %p nref = %d -> %d\n", con, nref + 1, nref);
> -}
> -
> -/*
>   * initialize a new connection.
>   */
>  void ceph_con_init(struct ceph_connection *con, void *private,
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
