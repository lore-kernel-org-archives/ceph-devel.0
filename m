From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 7/8] libceph: change ceph_con_in_msg_alloc convention
 to be less weird
Date: Mon, 30 Jul 2012 19:25:41 -0500
Message-ID: <50172605.1090100@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com> <1343663971-3221-8-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39976 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab2GaAZm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 20:25:42 -0400
Received: by yhmm54 with SMTP id m54so5525801yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 17:25:41 -0700 (PDT)
In-Reply-To: <1343663971-3221-8-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 10:59 AM, Sage Weil wrote:
> This function's calling convention is very limiting.  In particular,
> we can't return any error other than ENOMEM (and only implicitly),
> which is a problem (see next patch).
> 
> Instead, return an normal 0 or error code, and make the skip a pointer
> output parameter.  Drop the useless in_hdr argument (we have the con
> pointer).
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

I think this is a good change.  I have a few minor nits below
but it looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |   56 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index c3b628c..5177af0 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c

. . .

> @@ -2715,43 +2714,50 @@ static int ceph_alloc_middle(struct ceph_connection *con, struct ceph_msg *msg)
>   * connection, and save the result in con->in_msg.  Uses the
>   * connection's private alloc_msg op if available.
>   *
> - * Returns true if the message should be skipped, false otherwise.
> - * If true is returned (skip message), con->in_msg will be NULL.
> - * If false is returned, con->in_msg will contain a pointer to the
> - * newly-allocated message, or NULL in case of memory exhaustion.
> + * Returns 0 on success, or a negative error code.
> + *
> + * On success, *skip may be set to 1:
> + *  - the next message should be skipped and ignored.
> + *  - con->in_msg == NULL.

I'm pretty sure you mean that con->in_msg will be null if *skip
is 1, but it isn't crystal clear the way it's written here.

> + * or *skip may be 0:
> + *  - con->in_msg is non-zero.

Use "non-null" since it's a pointer, or "a valid message pointer".

> + * On error (ENOMEM, EAGAIN, ...),
> + *  - con->in_msg == NULL
>   */
> -static bool ceph_con_in_msg_alloc(struct ceph_connection *con,
> -				struct ceph_msg_header *hdr)
> +static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
>  {

Getting rid of the hdr argument here was a good idea anyway, since
only &con->in_hdr is ever used.

> +	struct ceph_msg_header *hdr = &con->in_hdr;
>  	int type = le16_to_cpu(hdr->type);
>  	int front_len = le32_to_cpu(hdr->front_len);
>  	int middle_len = le32_to_cpu(hdr->middle_len);
> -	int ret;
> +	int ret = 0;
>  
>  	BUG_ON(con->in_msg != NULL);
>  
>  	if (con->ops->alloc_msg) {
> -		int skip = 0;
> -
>  		mutex_unlock(&con->mutex);
> -		con->in_msg = con->ops->alloc_msg(con, hdr, &skip);
> +		con->in_msg = con->ops->alloc_msg(con, hdr, skip);
>  		mutex_lock(&con->mutex);
>  		if (con->in_msg) {
>  			con->in_msg->con = con->ops->get(con);
>  			BUG_ON(con->in_msg->con == NULL);
>  		}
> -		if (skip)
> +		if (*skip) {
>  			con->in_msg = NULL;
> -
> -		if (!con->in_msg)
> -			return skip != 0;
> +			return 0;
> +		}
> +		if (!con->in_msg) {
> +			con->error_msg =
> +				"error allocating memory for incoming message";
> +			return -ENOMEM;
> +		}
>  	}
>  	if (!con->in_msg) {
>  		con->in_msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
>  		if (!con->in_msg) {
>  			pr_err("unable to allocate msg type %d len %d\n",
>  			       type, front_len);
> -			return false;
> +			return -ENOMEM;
>  		}
>  		con->in_msg->con = con->ops->get(con);
>  		BUG_ON(con->in_msg->con == NULL);
> @@ -2767,7 +2773,7 @@ static bool ceph_con_in_msg_alloc(struct ceph_connection *con,
>  		}
>  	}
>  
> -	return false;
> +	return ret;

I believe ret will always be 0 here, and if you agree, this
should just be more direct about it:

	return 0;

>  }
>  
>  
> 

