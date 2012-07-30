From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 8/9] libceph: protect ceph_con_open() with mutex
Date: Mon, 30 Jul 2012 14:06:41 -0500
Message-ID: <5016DB41.6070504@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com> <1342831308-18815-9-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54791 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2G3TGm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 15:06:42 -0400
Received: by yhmm54 with SMTP id m54so5206653yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 12:06:41 -0700 (PDT)
In-Reply-To: <1342831308-18815-9-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/20/2012 07:41 PM, Sage Weil wrote:
> Take the con mutex while we are initiating a ceph open.  This is necessary
> because the may have previously been in use and then closed, which could
> result in a racing workqueue running con_work().
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Well there you go, another place where a state bit is
changed without holding the mutex.

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index efa369f..65964c2 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -537,6 +537,7 @@ void ceph_con_open(struct ceph_connection *con,
>  		   __u8 entity_type, __u64 entity_num,
>  		   struct ceph_entity_addr *addr)
>  {
> +	mutex_lock(&con->mutex);
>  	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
>  	set_bit(OPENING, &con->state);
>  	WARN_ON(!test_and_clear_bit(CLOSED, &con->state));
> @@ -546,6 +547,7 @@ void ceph_con_open(struct ceph_connection *con,
>  
>  	memcpy(&con->peer_addr, addr, sizeof(*addr));
>  	con->delay = 0;      /* reset backoff memory */
> +	mutex_unlock(&con->mutex);
>  	queue_con(con);
>  }
>  EXPORT_SYMBOL(ceph_con_open);
> 

