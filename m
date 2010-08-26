From: Sage Weil <sage@newdream.net>
Subject: Re: [patch] ceph: fix get_ticket_handler() error handling
Date: Thu, 26 Aug 2010 09:30:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008260930140.22216@cobra.newdream.net>
References: <20100826091238.GB20072@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40774 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab0HZQ3d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Aug 2010 12:29:33 -0400
In-Reply-To: <20100826091238.GB20072@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

Applied, thanks!
sage


On Thu, 26 Aug 2010, Dan Carpenter wrote:

> get_ticket_handler() returns a valid pointer or it returns
> ERR_PTR(-ENOMEM) if kzalloc() fails.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/fs/ceph/auth_x.c b/fs/ceph/auth_x.c
> index 582e0b2..a2d002c 100644
> --- a/fs/ceph/auth_x.c
> +++ b/fs/ceph/auth_x.c
> @@ -376,7 +376,7 @@ static void ceph_x_validate_tickets(struct ceph_auth_client *ac, int *pneed)
>  
>  		th = get_ticket_handler(ac, service);
>  
> -		if (!th) {
> +		if (IS_ERR(th)) {
>  			*pneed |= service;
>  			continue;
>  		}
> @@ -399,6 +399,9 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
>  	struct ceph_x_ticket_handler *th =
>  		get_ticket_handler(ac, CEPH_ENTITY_TYPE_AUTH);
>  
> +	if (IS_ERR(th))
> +		return PTR_ERR(th);
> +
>  	ceph_x_validate_tickets(ac, &need);
>  
>  	dout("build_request want %x have %x need %x\n",
> @@ -450,7 +453,6 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
>  			return -ERANGE;
>  		head->op = cpu_to_le16(CEPHX_GET_PRINCIPAL_SESSION_KEY);
>  
> -		BUG_ON(!th);
>  		ret = ceph_x_build_authorizer(ac, th, &xi->auth_authorizer);
>  		if (ret)
>  			return ret;
> @@ -505,7 +507,8 @@ static int ceph_x_handle_reply(struct ceph_auth_client *ac, int result,
>  
>  	case CEPHX_GET_PRINCIPAL_SESSION_KEY:
>  		th = get_ticket_handler(ac, CEPH_ENTITY_TYPE_AUTH);
> -		BUG_ON(!th);
> +		if (IS_ERR(th))
> +			return PTR_ERR(th);
>  		ret = ceph_x_proc_ticket_reply(ac, &th->session_key,
>  					       buf + sizeof(*head), end);
>  		break;
> @@ -563,8 +566,8 @@ static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
>  	void *end = p + sizeof(au->reply_buf);
>  
>  	th = get_ticket_handler(ac, au->service);
> -	if (!th)
> -		return -EIO;  /* hrm! */
> +	if (IS_ERR(th))
> +		return PTR_ERR(th);
>  	ret = ceph_x_decrypt(&th->session_key, &p, end, &reply, sizeof(reply));
>  	if (ret < 0)
>  		return ret;
> @@ -626,7 +629,7 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
>  	struct ceph_x_ticket_handler *th;
>  
>  	th = get_ticket_handler(ac, peer_type);
> -	if (th && !IS_ERR(th))
> +	if (!IS_ERR(th))
>  		remove_ticket_handler(ac, th);
>  }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
