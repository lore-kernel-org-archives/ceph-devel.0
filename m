From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/8] libceph: define and use in_msg_pos_next()
Date: Mon, 11 Mar 2013 11:57:00 -0700
Message-ID: <513E28FC.8060608@inktank.com>
References: <513B5116.2020305@inktank.com> <513B51E5.6080503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62462 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab3CKS5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 14:57:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so4055354pbc.5
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 11:57:40 -0700 (PDT)
In-Reply-To: <513B51E5.6080503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/09/2013 07:14 AM, Alex Elder wrote:
> Define a new function in_msg_pos_next() to match out_msg_pos_next(),
> and use it in place of code at the end of read_partial_message_pages()
> and read_partial_message_bio().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/messenger.c |   57
> ++++++++++++++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 2017b88..fb5f6e7 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1052,6 +1052,28 @@ static void out_msg_pos_next(struct
> ceph_connection *con, struct page *page,
>   #endif
>   }
>
> +static void in_msg_pos_next(struct ceph_connection *con, size_t len,
> +				size_t received)
> +{
> +	struct ceph_msg *msg = con->in_msg;
> +
> +	BUG_ON(!msg);
> +	BUG_ON(!received);
> +
> +	con->in_msg_pos.data_pos += received;
> +	con->in_msg_pos.page_pos += received;
> +	if (received < len)
> +		return;

This is different from the condition in read_partial_message_pages()
case, which only increments in_msg_pos.page and resets page_pos when
page_pos == PAGE_SIZE. Maybe this is equivalent, but if so it's not
obvious.

> +
> +	BUG_ON(received != len);
> +	con->in_msg_pos.page_pos = 0;
> +	con->in_msg_pos.page++;
> +#ifdef CONFIG_BLOCK
> +	if (msg->bio)
> +		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
> +#endif /* CONFIG_BLOCK */
> +}
> +
>   /*
>    * Write as much message data payload as we can.  If we finish, queue
>    * up the footer.
> @@ -1789,6 +1811,7 @@ static int read_partial_message_pages(struct
> ceph_connection *con,
>   				      struct page **pages,
>   				      unsigned int data_len, bool do_datacrc)
>   {
> +	struct page *page;
>   	void *p;
>   	int ret;
>   	int left;
> @@ -1797,22 +1820,18 @@ static int read_partial_message_pages(struct
> ceph_connection *con,
>   		   (int)(PAGE_SIZE - con->in_msg_pos.page_pos));
>   	/* (page) data */
>   	BUG_ON(pages == NULL);
> -	p = kmap(pages[con->in_msg_pos.page]);
> -	ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos,
> -			       left);
> +	page = pages[con->in_msg_pos.page];
> +	p = kmap(page);
> +	ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos, left);
>   	if (ret > 0 && do_datacrc)
>   		con->in_data_crc =
>   			crc32c(con->in_data_crc,
>   				  p + con->in_msg_pos.page_pos, ret);
> -	kunmap(pages[con->in_msg_pos.page]);
> +	kunmap(page);
>   	if (ret <= 0)
>   		return ret;
> -	con->in_msg_pos.data_pos += ret;
> -	con->in_msg_pos.page_pos += ret;
> -	if (con->in_msg_pos.page_pos == PAGE_SIZE) {
> -		con->in_msg_pos.page_pos = 0;
> -		con->in_msg_pos.page++;
> -	}
> +
> +	in_msg_pos_next(con, left, ret);
>
>   	return ret;
>   }
> @@ -1823,32 +1842,30 @@ static int read_partial_message_bio(struct
> ceph_connection *con,
>   {
>   	struct ceph_msg *msg = con->in_msg;
>   	struct bio_vec *bv;
> +	struct page *page;
>   	void *p;
>   	int ret, left;
>
>   	BUG_ON(!msg);
>   	BUG_ON(!msg->bio_iter);
>   	bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
> +
>   	left = min((int)(data_len - con->in_msg_pos.data_pos),
>   		   (int)(bv->bv_len - con->in_msg_pos.page_pos));
>
> -	p = kmap(bv->bv_page) + bv->bv_offset;
> +	page = bv->bv_page;
> +	p = kmap(page) + bv->bv_offset;
>
> -	ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos,
> -			       left);
> +	ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos, left);
>   	if (ret > 0 && do_datacrc)
>   		con->in_data_crc =
>   			crc32c(con->in_data_crc,
>   				  p + con->in_msg_pos.page_pos, ret);
> -	kunmap(bv->bv_page);
> +	kunmap(page);
>   	if (ret <= 0)
>   		return ret;
> -	con->in_msg_pos.data_pos += ret;
> -	con->in_msg_pos.page_pos += ret;
> -	if (con->in_msg_pos.page_pos == bv->bv_len) {
> -		con->in_msg_pos.page_pos = 0;
> -		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
> -	}
> +
> +	in_msg_pos_next(con, left, ret);
>
>   	return ret;
>   }
>

