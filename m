From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: tweak ceph_alloc_msg()
Date: Tue, 5 Jun 2012 22:14:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206052210240.22586@cobra.newdream.net>
References: <4FCECD7F.9030002@inktank.com> <4FCECF12.4050601@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51959 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab2FFFOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 01:14:05 -0400
In-Reply-To: <4FCECF12.4050601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Jun 2012, Alex Elder wrote:

> The function ceph_alloc_msg() is only used to allocate a message
> that will be assigned to a connection's in_msg pointer.  Rename the
> function so this implied usage is more clear.
> 
> In addition, make that assignment inside the function (again, since
> that's precisely what it's intended to be used for).  This allows us
> to return what is now provided via the passed-in address of a "skip"
> variable.  The return type is now Boolean to be explicit that there
> are only two possible outcomes.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |   58
> ++++++++++++++++++++++++++-----------------------
>  1 files changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 3b65f6e..f7c9061 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1655,9 +1655,8 @@ static int read_partial_message_section(struct
> ceph_connection *con,
>  	return 1;
>  }
> 
> -static struct ceph_msg *ceph_alloc_msg(struct ceph_connection *con,
> -				struct ceph_msg_header *hdr,
> -				int *skip);
> +static bool ceph_con_in_msg_alloc(struct ceph_connection *con,
> +				struct ceph_msg_header *hdr);
> 
> 
>  static int read_partial_message_pages(struct ceph_connection *con,
> @@ -1740,7 +1739,6 @@ static int read_partial_message(struct
> ceph_connection *con)
>  	int ret;
>  	unsigned front_len, middle_len, data_len;
>  	bool do_datacrc = !con->msgr->nocrc;
> -	int skip;
>  	u64 seq;
>  	u32 crc;
> 
> @@ -1793,9 +1791,7 @@ static int read_partial_message(struct
> ceph_connection *con)
>  	if (!con->in_msg) {
>  		dout("got hdr type %d front %d data %d\n", con->in_hdr.type,
>  		     con->in_hdr.front_len, con->in_hdr.data_len);
> -		skip = 0;
> -		con->in_msg = ceph_alloc_msg(con, &con->in_hdr, &skip);
> -		if (skip) {
> +		if (ceph_con_in_msg_alloc(con, &con->in_hdr)) {
>  			/* skip this message */
>  			dout("alloc_msg said skip message\n");
>  			BUG_ON(con->in_msg);
> @@ -2577,46 +2573,54 @@ static int ceph_alloc_middle(struct
> ceph_connection *con, struct ceph_msg *msg)
>  }
> 
>  /*
> - * Generic message allocator, for incoming messages.
> + * Allocate a message for receiving an incoming message on a
> + * connection, and save the result in con->in_msg.  Uses the
> + * connection's private alloc_msg op if available.
> + *
> + * Returns true if the message should be skipped, false otherwise.

I would document that there are three possible outcomes:

	true and in_msg == NULL  .. skip next msg
 	false and in_msg != NULL .. msg is ready to go
	false and in_msg == NULL .. ENOMEM :(

>   */
> -static struct ceph_msg *ceph_alloc_msg(struct ceph_connection *con,
> -				struct ceph_msg_header *hdr,
> -				int *skip)
> +static bool ceph_con_in_msg_alloc(struct ceph_connection *con,
> +				struct ceph_msg_header *hdr)
>  {
>  	int type = le16_to_cpu(hdr->type);
>  	int front_len = le32_to_cpu(hdr->front_len);
>  	int middle_len = le32_to_cpu(hdr->middle_len);
> -	struct ceph_msg *msg = NULL;
>  	int ret;
> 
> +	BUG_ON(con->in_msg != NULL);
> +
>  	if (con->ops->alloc_msg) {
> +		int skip = 0;
> +
>  		mutex_unlock(&con->mutex);
> -		msg = con->ops->alloc_msg(con, hdr, skip);
> +		con->in_msg = con->ops->alloc_msg(con, hdr, &skip);
>  		mutex_lock(&con->mutex);
> -		if (!msg || *skip)
> -			return NULL;
> +		if (skip)
> +			con->in_msg = NULL;

I think this can be a BUG_ON(con->in_msg)... the alloc_msg() op shouldn't 
set skip = 1 *and* return a msg pointer.  That would have leaked with the 
old code, which is a bug.

> +
> +		if (!con->in_msg)
> +			return skip != 0;

or maybe
		if (skip || !con->in_msg)
			return skip;

?

Reviewed-by: Sage Weil <sage@inktank.com>

>  	}
> -	if (!msg) {
> -		*skip = 0;
> -		msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
> -		if (!msg) {
> +	if (!con->in_msg) {
> +		con->in_msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
> +		if (!con->in_msg) {
>  			pr_err("unable to allocate msg type %d len %d\n",
>  			       type, front_len);
> -			return NULL;
> +			return false;
>  		}
> -		msg->page_alignment = le16_to_cpu(hdr->data_off);
> +		con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
>  	}
> -	memcpy(&msg->hdr, &con->in_hdr, sizeof(con->in_hdr));
> +	memcpy(&con->in_msg->hdr, &con->in_hdr, sizeof(con->in_hdr));
> 
> -	if (middle_len && !msg->middle) {
> -		ret = ceph_alloc_middle(con, msg);
> +	if (middle_len && !con->in_msg->middle) {
> +		ret = ceph_alloc_middle(con, con->in_msg);
>  		if (ret < 0) {
> -			ceph_msg_put(msg);
> -			return NULL;
> +			ceph_msg_put(con->in_msg);
> +			con->in_msg = NULL;
>  		}
>  	}
> 
> -	return msg;
> +	return false;
>  }
> 
> 
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
