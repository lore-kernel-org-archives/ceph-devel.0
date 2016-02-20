From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/4] libceph: use the right footer size when skipping a
 message
Date: Sat, 20 Feb 2016 12:44:29 -0600
Message-ID: <56C8B40D.90602@ieee.org>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
 <1455986729-12544-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33408 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbcBTSob (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 13:44:31 -0500
Received: by mail-io0-f173.google.com with SMTP id z135so141425936iof.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 10:44:31 -0800 (PST)
In-Reply-To: <1455986729-12544-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

+On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
> ceph_msg_footer is 21 bytes long, while ceph_msg_footer_old is only 13.
> Don't skip too much when CEPH_FEATURE_MSG_AUTH isn't negotiated.

This looks good, but I have a few suggestions.

You could done some factoring in prepare_write_message_footer()
to use the new function for setting iov_len and updating
out_kvec_bytes.

Consider my suggestions, but otherwise I believe this
is correct.

Reviewed-by: Alex Elder <elder@linaro.org>

> Cc: stable@vger.kernel.org # 3.19+
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/messenger.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index fec20819a5ea..dd7c1b7f932b 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2284,6 +2284,13 @@ static int read_partial_msg_data(struct ceph_connection *con)
>  	return 1;	/* must return > 0 to indicate success */
>  }
>  
> +static size_t sizeof_footer(struct ceph_connection *con)

I understand why this is named this way.  But it's supplying a
connection as argument, but a footer is a message attribute.
So I might call this con_msg_footer_size().

> +{
> +	return (con->peer_features & CEPH_FEATURE_MSG_AUTH) ?
> +	    sizeof(struct ceph_msg_footer) :
> +	    sizeof(struct ceph_msg_footer_old);
> +}
> +
>  /*
>   * read (part of) a message.
>   */
> @@ -2335,7 +2342,7 @@ static int read_partial_message(struct ceph_connection *con)
>  			ceph_pr_addr(&con->peer_addr.in_addr),
>  			seq, con->in_seq + 1);
>  		con->in_base_pos = -front_len - middle_len - data_len -
> -			sizeof(m->footer);
> +			sizeof_footer(con);
>  		con->in_tag = CEPH_MSGR_TAG_READY;
>  		return 1;
>  	} else if ((s64)seq - (s64)con->in_seq > 1) {
> @@ -2360,7 +2367,7 @@ static int read_partial_message(struct ceph_connection *con)
>  			/* skip this message */
>  			dout("alloc_msg said skip message\n");
>  			con->in_base_pos = -front_len - middle_len - data_len -
> -				sizeof(m->footer);
> +				sizeof_footer(con);
>  			con->in_tag = CEPH_MSGR_TAG_READY;
>  			con->in_seq++;
>  			return 1;
> @@ -2402,11 +2409,7 @@ static int read_partial_message(struct ceph_connection *con)
>  	}
>  
>  	/* footer */
> -	if (need_sign)
> -		size = sizeof(m->footer);
> -	else
> -		size = sizeof(m->old_footer);
> -
> +	size = sizeof_footer(con);
>  	end += size;
>  	ret = read_partial(con, end, size, &m->footer);
>  	if (ret <= 0)
> 

