From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 4/8] libceph: revoke mon_client messages on session restart
Date: Mon, 30 Jul 2012 19:09:18 -0500
Message-ID: <5017222E.50805@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com> <1343663971-3221-5-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50400 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab2GaAJT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 20:09:19 -0400
Received: by yenl2 with SMTP id l2so5512602yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 17:09:19 -0700 (PDT)
In-Reply-To: <1343663971-3221-5-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 10:59 AM, Sage Weil wrote:
> Revoke all mon_client messages when we shut down the old connection.
> This is mostly moot since we are re-using the same ceph_connection,
> but it is cleaner.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/mon_client.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index bfd21a8..105d533 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -118,6 +118,9 @@ static void __close_session(struct ceph_mon_client *monc)
>  {
>  	dout("__close_session closing mon%d\n", monc->cur_mon);
>  	ceph_msg_revoke(monc->m_auth);
> +	ceph_msg_revoke_incoming(monc->m_auth_reply);
> +	ceph_msg_revoke(monc->m_subscribe);
> +	ceph_msg_revoke_incoming(monc->m_subscribe_ack);
>  	ceph_con_close(&monc->con);
>  	monc->cur_mon = -1;
>  	monc->pending_auth = 0;
> @@ -685,6 +688,7 @@ static void __resend_generic_request(struct ceph_mon_client *monc)
>  	for (p = rb_first(&monc->generic_request_tree); p; p = rb_next(p)) {
>  		req = rb_entry(p, struct ceph_mon_generic_request, node);
>  		ceph_msg_revoke(req->request);
> +		ceph_msg_revoke_incoming(req->reply);
>  		ceph_con_send(&monc->con, ceph_msg_get(req->request));
>  	}
>  }
> 

