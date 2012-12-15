From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: report connection fault with warning
Date: Fri, 14 Dec 2012 21:09:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212142109330.23307@cobra.newdream.net>
References: <50CBE0BF.4060204@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42260 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2LOFJz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 00:09:55 -0500
In-Reply-To: <50CBE0BF.4060204@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Fri, 14 Dec 2012, Alex Elder wrote:

> When a connection's socket disconnects, or if there's a protocol
> error of some kind on the connection, a fault is signaled and
> the connection is reset (closed and reopened, basically).  We
> currently get an error message on the log whenever this occurs.
> 
> A ceph connection will attempt to reestablish a socket connection
> repeatedly if a fault occurs.  This means that these error messages
> will get repeatedly added to the log, which is undesirable.
> 
> Change the error message to be a warning, so they don't get
> logged by default.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 4b04ccc..4d111fd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2377,7 +2377,7 @@ fault:
>  static void ceph_fault(struct ceph_connection *con)
>  	__releases(con->mutex)
>  {
> -	pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
> +	pr_warning("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
>  	       ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg);
>  	dout("fault %p state %lu to peer %s\n",
>  	     con, con->state, ceph_pr_addr(&con->peer_addr.in_addr));
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
