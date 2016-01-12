From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: fix ceph_msg_revoke()
Date: Tue, 12 Jan 2016 09:40:14 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601120931560.27580@cpach.fuggernut.com>
References: <1452595959-13541-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45553 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcALOkL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jan 2016 09:40:11 -0500
In-Reply-To: <1452595959-13541-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Matt Conner <matt.conner@keepertech.com>

On Tue, 12 Jan 2016, Ilya Dryomov wrote:
> There are a number of problems with revoking a "was sending" message:
> 
> (1) We never make any attempt to revoke data - only kvecs contibute to
> con->out_skip.  However, once the header (envelope) is written to the
> socket, our peer learns data_len and sets itself to expect at least
> data_len bytes to follow front or front+middle.  If ceph_msg_revoke()
> is called while the messenger is sending message's data portion,
> anything we send after that call is counted by the OSD towards the now
> revoked message's data portion.  The effects vary, the most common one
> is the eventual hang - higher layers get stuck waiting for the reply to
> the message that was sent out after ceph_msg_revoke() returned and
> treated by the OSD as a bunch of data bytes.  This is what Matt ran
> into.
> 
> (2) Flat out zeroing con->out_kvec_bytes worth of bytes to handle kvecs
> is wrong.  If ceph_msg_revoke() is called before the tag is sent out or
> while the messenger is sending the header, we will get a connection
> reset, either due to a bad tag (0 is not a valid tag) or a bad header
> CRC, which kind of defeats the purpose of revoke.  Currently the kernel
> client refuses to work with header CRCs disabled, but that will likely
> change in the future, making this even worse.
> 
> (3) con->out_skip is not reset on connection reset, leading to one or
> more spurious connection resets if we happen to get a real one between
> con->out_skip is set in ceph_msg_revoke() and before it's cleared in
> write_partial_skip().
> 
> Fixing (1) and (3) is trivial.  The idea behind fixing (2) is to never
> zero the tag or the header, i.e. send out tag+header regardless of when
> ceph_msg_revoke() is called.  That way the header is always correct, no
> unnecessary resets are induced and revoke stands ready for disabled
> CRCs.  Since ceph_msg_revoke() reaps out con->out_msg, introduce a new

                                 rips

> "message out temp" and copy the header into it before sending.
> 
> Reported-by: Matt Conner <matt.conner@keepertech.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Tested-by: Matt Conner <matt.conner@keepertech.com>
> ---
>  include/linux/ceph/messenger.h |  2 +-
>  net/ceph/messenger.c           | 76 ++++++++++++++++++++++++++++++++----------
>  2 files changed, 59 insertions(+), 19 deletions(-)

This looks right to me.

Reviewed-by: Sage Weil <sage@redhat.com>

sage

> 
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 71b1d6cdcb5d..8dbd7879fdc6 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -220,6 +220,7 @@ struct ceph_connection {
>  	struct ceph_entity_addr actual_peer_addr;
>  
>  	/* message out temps */
> +	struct ceph_msg_header out_hdr;
>  	struct ceph_msg *out_msg;        /* sending message (== tail of
>  					    out_sent) */
>  	bool out_msg_done;
> @@ -229,7 +230,6 @@ struct ceph_connection {
>  	int out_kvec_left;   /* kvec's left in out_kvec */
>  	int out_skip;        /* skip this many bytes */
>  	int out_kvec_bytes;  /* total bytes left */
> -	bool out_kvec_is_msg; /* kvec refers to out_msg */
>  	int out_more;        /* there is more data after the kvecs */
>  	__le64 out_temp_ack; /* for writing an ack */
>  	struct ceph_timespec out_temp_keepalive2; /* for writing keepalive2
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index de3eb19a6968..3850d1a5bd7c 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -669,6 +669,8 @@ static void reset_connection(struct ceph_connection *con)
>  	}
>  	con->in_seq = 0;
>  	con->in_seq_acked = 0;
> +
> +	con->out_skip = 0;
>  }
>  
>  /*
> @@ -768,6 +770,8 @@ static u32 get_global_seq(struct ceph_messenger *msgr, u32 gt)
>  
>  static void con_out_kvec_reset(struct ceph_connection *con)
>  {
> +	BUG_ON(con->out_skip);
> +
>  	con->out_kvec_left = 0;
>  	con->out_kvec_bytes = 0;
>  	con->out_kvec_cur = &con->out_kvec[0];
> @@ -776,9 +780,9 @@ static void con_out_kvec_reset(struct ceph_connection *con)
>  static void con_out_kvec_add(struct ceph_connection *con,
>  				size_t size, void *data)
>  {
> -	int index;
> +	int index = con->out_kvec_left;
>  
> -	index = con->out_kvec_left;
> +	BUG_ON(con->out_skip);
>  	BUG_ON(index >= ARRAY_SIZE(con->out_kvec));
>  
>  	con->out_kvec[index].iov_len = size;
> @@ -787,6 +791,27 @@ static void con_out_kvec_add(struct ceph_connection *con,
>  	con->out_kvec_bytes += size;
>  }
>  
> +/*
> + * Chop off a kvec from the end.  Return residual number of bytes for
> + * that kvec, i.e. how many bytes would have been written if the kvec
> + * hadn't been nuked.
> + */
> +static int con_out_kvec_skip(struct ceph_connection *con)
> +{
> +	int off = con->out_kvec_cur - con->out_kvec;
> +	int skip = 0;
> +
> +	if (con->out_kvec_bytes > 0) {
> +		skip = con->out_kvec[off + con->out_kvec_left - 1].iov_len;
> +		BUG_ON(con->out_kvec_bytes < skip);
> +		BUG_ON(!con->out_kvec_left);
> +		con->out_kvec_bytes -= skip;
> +		con->out_kvec_left--;
> +	}
> +
> +	return skip;
> +}
> +
>  #ifdef CONFIG_BLOCK
>  
>  /*
> @@ -1194,7 +1219,6 @@ static void prepare_write_message_footer(struct ceph_connection *con)
>  	m->footer.flags |= CEPH_MSG_FOOTER_COMPLETE;
>  
>  	dout("prepare_write_message_footer %p\n", con);
> -	con->out_kvec_is_msg = true;
>  	con->out_kvec[v].iov_base = &m->footer;
>  	if (con->peer_features & CEPH_FEATURE_MSG_AUTH) {
>  		if (con->ops->sign_message)
> @@ -1222,7 +1246,6 @@ static void prepare_write_message(struct ceph_connection *con)
>  	u32 crc;
>  
>  	con_out_kvec_reset(con);
> -	con->out_kvec_is_msg = true;
>  	con->out_msg_done = false;
>  
>  	/* Sneak an ack in there first?  If we can get it into the same
> @@ -1262,18 +1285,19 @@ static void prepare_write_message(struct ceph_connection *con)
>  
>  	/* tag + hdr + front + middle */
>  	con_out_kvec_add(con, sizeof (tag_msg), &tag_msg);
> -	con_out_kvec_add(con, sizeof (m->hdr), &m->hdr);
> +	con_out_kvec_add(con, sizeof(con->out_hdr), &con->out_hdr);
>  	con_out_kvec_add(con, m->front.iov_len, m->front.iov_base);
>  
>  	if (m->middle)
>  		con_out_kvec_add(con, m->middle->vec.iov_len,
>  			m->middle->vec.iov_base);
>  
> -	/* fill in crc (except data pages), footer */
> +	/* fill in hdr crc and finalize hdr */
>  	crc = crc32c(0, &m->hdr, offsetof(struct ceph_msg_header, crc));
>  	con->out_msg->hdr.crc = cpu_to_le32(crc);
> -	con->out_msg->footer.flags = 0;
> +	memcpy(&con->out_hdr, &con->out_msg->hdr, sizeof(con->out_hdr));
>  
> +	/* fill in front and middle crc, footer */
>  	crc = crc32c(0, m->front.iov_base, m->front.iov_len);
>  	con->out_msg->footer.front_crc = cpu_to_le32(crc);
>  	if (m->middle) {
> @@ -1285,6 +1309,7 @@ static void prepare_write_message(struct ceph_connection *con)
>  	dout("%s front_crc %u middle_crc %u\n", __func__,
>  	     le32_to_cpu(con->out_msg->footer.front_crc),
>  	     le32_to_cpu(con->out_msg->footer.middle_crc));
> +	con->out_msg->footer.flags = 0;
>  
>  	/* is there a data payload? */
>  	con->out_msg->footer.data_crc = 0;
> @@ -1489,7 +1514,6 @@ static int write_partial_kvec(struct ceph_connection *con)
>  		}
>  	}
>  	con->out_kvec_left = 0;
> -	con->out_kvec_is_msg = false;
>  	ret = 1;
>  out:
>  	dout("write_partial_kvec %p %d left in %d kvecs ret = %d\n", con,
> @@ -1581,6 +1605,7 @@ static int write_partial_skip(struct ceph_connection *con)
>  {
>  	int ret;
>  
> +	dout("%s %p %d left\n", __func__, con, con->out_skip);
>  	while (con->out_skip > 0) {
>  		size_t size = min(con->out_skip, (int) PAGE_CACHE_SIZE);
>  
> @@ -2503,13 +2528,13 @@ more:
>  
>  more_kvec:
>  	/* kvec data queued? */
> -	if (con->out_skip) {
> -		ret = write_partial_skip(con);
> +	if (con->out_kvec_left) {
> +		ret = write_partial_kvec(con);
>  		if (ret <= 0)
>  			goto out;
>  	}
> -	if (con->out_kvec_left) {
> -		ret = write_partial_kvec(con);
> +	if (con->out_skip) {
> +		ret = write_partial_skip(con);
>  		if (ret <= 0)
>  			goto out;
>  	}
> @@ -3047,16 +3072,31 @@ void ceph_msg_revoke(struct ceph_msg *msg)
>  		ceph_msg_put(msg);
>  	}
>  	if (con->out_msg == msg) {
> -		dout("%s %p msg %p - was sending\n", __func__, con, msg);
> -		con->out_msg = NULL;
> -		if (con->out_kvec_is_msg) {
> -			con->out_skip = con->out_kvec_bytes;
> -			con->out_kvec_is_msg = false;
> +		BUG_ON(con->out_skip);
> +		/* footer */
> +		if (con->out_msg_done) {
> +			con->out_skip += con_out_kvec_skip(con);
> +		} else {
> +			BUG_ON(!msg->data_length);
> +			if (con->peer_features & CEPH_FEATURE_MSG_AUTH)
> +				con->out_skip += sizeof(msg->footer);
> +			else
> +				con->out_skip += sizeof(msg->old_footer);
>  		}
> +		/* data, middle, front */
> +		if (msg->data_length)
> +			con->out_skip += msg->cursor.total_resid;
> +		if (msg->middle)
> +			con->out_skip += con_out_kvec_skip(con);
> +		con->out_skip += con_out_kvec_skip(con);
> +
> +		dout("%s %p msg %p - was sending, will write %d skip %d\n",
> +		     __func__, con, msg, con->out_kvec_bytes, con->out_skip);
>  		msg->hdr.seq = 0;
> -
> +		con->out_msg = NULL;
>  		ceph_msg_put(msg);
>  	}
> +
>  	mutex_unlock(&con->mutex);
>  }
>  
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
