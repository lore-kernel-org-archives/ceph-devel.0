From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] libceph: implement RECONNECT_SEQ feature
Date: Mon, 25 Mar 2013 08:20:41 -0500
Message-ID: <51504F29.5020703@inktank.com>
References: <1363733312-26760-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51277 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab3CYNUk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 09:20:40 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so4365326iec.33
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 06:20:40 -0700 (PDT)
In-Reply-To: <1363733312-26760-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/19/2013 05:48 PM, Sage Weil wrote:
> This is an old protocol extension that allows the client and server to
> avoid resending old messages after a reconnect (following a socket error).
> Instead, the exchange their sequence numbers during the handshake.  This
> avoids sending a bunch of useless data over the socket.
> 
> It has been supported in the server code since v0.22 (Sep 2010).

OK, a few comments below, but this looks good to me.
Make the suggested (or implied) changes below if you
like, but either way:

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  include/linux/ceph/ceph_features.h |    2 ++
>  include/linux/ceph/msgr.h          |    1 +
>  net/ceph/messenger.c               |   47 +++++++++++++++++++++++++++++++++---
>  3 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 76554ce..4c420803 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -41,6 +41,7 @@
>   */
>  #define CEPH_FEATURES_SUPPORTED_DEFAULT  \
>  	(CEPH_FEATURE_NOSRCADDR |		\
> +	 CEPH_FEATURE_RECONNECT_SEQ |		\
>  	 CEPH_FEATURE_PGID64 |			\
>  	 CEPH_FEATURE_PGPOOL3 |			\
>  	 CEPH_FEATURE_OSDENC |			\
> @@ -51,6 +52,7 @@
>  
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
>  	(CEPH_FEATURE_NOSRCADDR |	 \
> +	 CEPH_FEATURE_RECONNECT_SEQ |	 \
>  	 CEPH_FEATURE_PGID64 |		 \
>  	 CEPH_FEATURE_PGPOOL3 |		 \
>  	 CEPH_FEATURE_OSDENC)

Is it really a required feature?

If the other end doesn't support it is there any
reason we can't fall back to the old behavior?

This code is only *responding* to a SEQ tag, it doesn't
initiate one.  If one is never sent by the server the
behavior remains correct, just slower.

I also have two points you might help clarify for me:
- Is this a server initiated feature, or could a client
  send it?
- Because it's a tagged bit of message data it really
  could occur at any time--though at the end of a
  reconnect negotiation is where it's valuable.  Correct?

> diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
> index 680d3d6..3d94a73 100644
> --- a/include/linux/ceph/msgr.h
> +++ b/include/linux/ceph/msgr.h
> @@ -87,6 +87,7 @@ struct ceph_entity_inst {
>  #define CEPH_MSGR_TAG_BADPROTOVER  10  /* bad protocol version */
>  #define CEPH_MSGR_TAG_BADAUTHORIZER 11 /* bad authorizer */
>  #define CEPH_MSGR_TAG_FEATURES      12 /* insufficient features */
> +#define CEPH_MSGR_TAG_SEQ           13 /* 64-bit int follows with seen seq number */
>  
>  
>  /*
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 997dacc..2bf2806 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1247,6 +1247,24 @@ static void prepare_write_ack(struct ceph_connection *con)
>  }
>  
>  /*
> + * Prepare to share the seq during handshake
> + */
> +static void prepare_write_seq(struct ceph_connection *con)
> +{
> +	dout("prepare_write_seq %p %llu -> %llu\n", con,
> +	     con->in_seq_acked, con->in_seq);
> +	con->in_seq_acked = con->in_seq;
> +
> +	con_out_kvec_reset(con);
> +
> +	con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
> +	con_out_kvec_add(con, sizeof (con->out_temp_ack),
> +			 &con->out_temp_ack);
> +
> +	con_flag_set(con, CON_FLAG_WRITE_PENDING);
> +}
> +
> +/*
>   * Prepare to write keepalive byte.
>   */
>  static void prepare_write_keepalive(struct ceph_connection *con)
> @@ -1582,6 +1600,13 @@ static void prepare_read_ack(struct ceph_connection *con)
>  	con->in_base_pos = 0;
>  }
>  
> +static void prepare_read_seq(struct ceph_connection *con)
> +{
> +	dout("prepare_read_seq %p\n", con);
> +	con->in_base_pos = 0;
> +	con->in_tag = CEPH_MSGR_TAG_SEQ;
> +}
> +
>  static void prepare_read_tag(struct ceph_connection *con)
>  {
>  	dout("prepare_read_tag %p\n", con);
> @@ -2059,6 +2084,7 @@ static int process_connect(struct ceph_connection *con)
>  		prepare_read_connect(con);
>  		break;
>  
> +	case CEPH_MSGR_TAG_SEQ:
>  	case CEPH_MSGR_TAG_READY:
>  		if (req_feat & ~server_feat) {
>  			pr_err("%s%lld %s protocol feature mismatch,"
> @@ -2089,7 +2115,12 @@ static int process_connect(struct ceph_connection *con)
>  
>  		con->delay = 0;      /* reset backoff memory */
>  
> -		prepare_read_tag(con);
> +		if (con->in_reply.tag == CEPH_MSGR_TAG_SEQ) {
> +			prepare_write_seq(con);
> +			prepare_read_seq(con);
> +		} else {
> +			prepare_read_tag(con);
> +		}
>  		break;
>  
>  	case CEPH_MSGR_TAG_WAIT:
> @@ -2123,7 +2154,6 @@ static int read_partial_ack(struct ceph_connection *con)
>  	return read_partial(con, end, size, &con->in_temp_ack);
>  }
>  
> -
>  /*
>   * We can finally discard anything that's been acked.
>   */
> @@ -2148,8 +2178,6 @@ static void process_ack(struct ceph_connection *con)
>  }
>  
>  
> -
> -
>  static int read_partial_message_section(struct ceph_connection *con,
>  					struct kvec *section,
>  					unsigned int sec_len, u32 *crc)
> @@ -2628,6 +2656,17 @@ more:
>  		if (con->in_base_pos)
>  			goto more;
>  	}
> +	if (con->in_tag == CEPH_MSGR_TAG_SEQ) {
> +		/*
> +		 * the final seq exchange is semantically equivalent
> +		 * to an ACK; re-use those helpers.
> +		 */
> +		ret = read_partial_ack(con);
> +		if (ret <= 0)
> +			goto out;
> +		process_ack(con);
> +		goto more;
> +	}

This block (above) is identical to the block a little later on
that handles CEPH_MSGR_TAG_ACK.  It might be nice to make that
fact obvious by combining them (and if so, I would say here, not
below).  (It's OK as-is, however.)

>  	if (con->in_tag == CEPH_MSGR_TAG_READY) {
>  		/*
>  		 * what's next?
> 

