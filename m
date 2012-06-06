From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 4/4] libceph: make ceph_con_revoke_message() a msg op
Date: Tue, 5 Jun 2012 22:22:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206052219450.22586@cobra.newdream.net>
References: <4FCECD7F.9030002@inktank.com> <4FCECF2C.8010200@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40677 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab2FFFWS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 01:22:18 -0400
In-Reply-To: <4FCECF2C.8010200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Jun 2012, Alex Elder wrote:
> ceph_con_revoke_message() is passed both a message and a ceph
> connection.  A ceph_msg allocated for incoming messages on a
> connection always has a pointer to that connection, so there's no
> need to provide the connection when revoking such a message.
> 
> Note that the existing logic does not preclude the message supplied
> being a null/bogus message pointer.  The only user of this interface
> is the OSD client, and the only value an osd client passes is a
> request's r_reply field.  That is always non-null (except briefly in
> an error path in ceph_osdc_alloc_request(), and that drops the
> only reference so the request won't ever have a reply to revoke).
> So we can safely assume the passed-in message is non-null, but add a
> BUG_ON() to make it very obvious we are imposing this restriction.
> 
> Rename the function ceph_msg_revoke_incoming() to reflect that it is
> really an operation on an incoming message.

Yes

> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  include/linux/ceph/messenger.h |    4 ++--
>  net/ceph/messenger.c           |   19 +++++++++++++------
>  net/ceph/osd_client.c          |    9 ++++-----
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 9008f81..a334dbd 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -241,8 +241,8 @@ extern void ceph_con_close(struct ceph_connection *con);
>  extern void ceph_con_send(struct ceph_connection *con, struct ceph_msg
> *msg);
> 
>  extern void ceph_msg_revoke(struct ceph_msg *msg);
> -extern void ceph_con_revoke_message(struct ceph_connection *con,
> -				  struct ceph_msg *msg);
> +extern void ceph_msg_revoke_incoming(struct ceph_msg *msg);
> +
>  extern void ceph_con_keepalive(struct ceph_connection *con);
>  extern struct ceph_connection *ceph_con_get(struct ceph_connection *con);
>  extern void ceph_con_put(struct ceph_connection *con);
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 79f3032..a036141 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2456,17 +2456,24 @@ void ceph_msg_revoke(struct ceph_msg *msg)
>  /*
>   * Revoke a message that we may be reading data into
>   */
> -void ceph_con_revoke_message(struct ceph_connection *con, struct
> ceph_msg *msg)
> +void ceph_msg_revoke_incoming(struct ceph_msg *msg)
>  {
> +	struct ceph_connection *con;
> +
> +	BUG_ON(msg == NULL);
> +	if (!msg->con)
> +		return;		/* Message not in our posession */

This case weirds me out.  I think it can happen, but maybe we should at 
least get a debug msg, like the no-op one below.

Reviewed-by: Sage Weil <sage@inktank.com>

> +
> +	con = msg->con;
>  	mutex_lock(&con->mutex);
> -	if (con->in_msg && con->in_msg == msg) {
> +	if (con->in_msg == msg) {
>  		unsigned front_len = le32_to_cpu(con->in_hdr.front_len);
>  		unsigned middle_len = le32_to_cpu(con->in_hdr.middle_len);
>  		unsigned data_len = le32_to_cpu(con->in_hdr.data_len);
> 
>  		/* skip rest of message */
> -		dout("con_revoke_pages %p msg %p revoked\n", con, msg);
> -			con->in_base_pos = con->in_base_pos -
> +		dout("%s %p msg %p revoked\n", __func__, con, msg);
> +		con->in_base_pos = con->in_base_pos -
>  				sizeof(struct ceph_msg_header) -
>  				front_len -
>  				middle_len -
> @@ -2477,8 +2484,8 @@ void ceph_con_revoke_message(struct
> ceph_connection *con, struct ceph_msg *msg)
>  		con->in_tag = CEPH_MSGR_TAG_READY;
>  		con->in_seq++;
>  	} else {
> -		dout("con_revoke_pages %p msg %p pages %p no-op\n",
> -		     con, con->in_msg, msg);
> +		dout("%s %p in_msg %p msg %p no-op\n",
> +		     __func__, con, con->in_msg, msg);
>  	}
>  	mutex_unlock(&con->mutex);
>  }
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 403fefb..9f87edd 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -140,10 +140,9 @@ void ceph_osdc_release_request(struct kref *kref)
>  	if (req->r_request)
>  		ceph_msg_put(req->r_request);
>  	if (req->r_con_filling_msg) {
> -		dout("release_request revoking pages %p from con %p\n",
> +		dout("%s revoking pages %p from con %p\n", __func__,
>  		     req->r_pages, req->r_con_filling_msg);
> -		ceph_con_revoke_message(req->r_con_filling_msg,
> -				      req->r_reply);
> +		ceph_msg_revoke_incoming(req->r_reply);
>  		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
>  	}
>  	if (req->r_reply)
> @@ -2022,9 +2021,9 @@ static struct ceph_msg *get_reply(struct
> ceph_connection *con,
>  	}
> 
>  	if (req->r_con_filling_msg) {
> -		dout("get_reply revoking msg %p from old con %p\n",
> +		dout("%s revoking msg %p from old con %p\n", __func__,
>  		     req->r_reply, req->r_con_filling_msg);
> -		ceph_con_revoke_message(req->r_con_filling_msg, req->r_reply);
> +		ceph_msg_revoke_incoming(req->r_reply);
>  		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
>  		req->r_con_filling_msg = NULL;
>  	}
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
