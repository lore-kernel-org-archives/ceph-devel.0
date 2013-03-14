From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: collapse all data items into one
Date: Thu, 14 Mar 2013 12:50:00 -0700
Message-ID: <514229E8.6060806@inktank.com>
References: <513FD114.9000407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63557 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab3CNT6F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:58:05 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so2729384pbc.30
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 12:58:04 -0700 (PDT)
In-Reply-To: <513FD114.9000407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/12/2013 06:06 PM, Alex Elder wrote:
> It turns out that only one of the data item types is ever used at
> any one time in a single message (currently).
>      - A page array is used by the osd client (on behalf of the file
>        system) and by rbd.  Only one osd op (and therefore at most
>        one data item) is ever used at a time by rbd.  And the only
>        time the file system sends two, the second op contains no
>        data.
>      - A bio is only used by the rbd client (and again, only one
>        data item per message)
>      - A page list is used by the file system and by rbd for outgoing
>        data, but only one op (and one dat item) at a time.
>
> We can therefore collapse all three of our data item fields into a
> single field "data", and depend on the messenger code to properly
> handle it based on its type.
>
> This allows us to eliminate quite a bit of duplicated code.
>
> This is related to:
>      http://tracker.ceph.com/issues/4429
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/messenger.h |   12 +----
>   net/ceph/messenger.c           |  112
> ++++++++++++----------------------------
>   2 files changed, 36 insertions(+), 88 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 252e01b..af786b2 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -64,11 +64,7 @@ struct ceph_messenger {
>   	u32 required_features;
>   };
>
> -#define ceph_msg_has_pages(m)		((m)->p.type == CEPH_MSG_DATA_PAGES)
> -#define ceph_msg_has_pagelist(m)	((m)->l.type == CEPH_MSG_DATA_PAGELIST)
> -#ifdef CONFIG_BLOCK
> -#define ceph_msg_has_bio(m)		((m)->b.type == CEPH_MSG_DATA_BIO)
> -#endif /* CONFIG_BLOCK */
> +#define ceph_msg_has_data(m)		((m)->data.type != CEPH_MSG_DATA_NONE)
>
>   enum ceph_msg_data_type {
>   	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
> @@ -145,11 +141,7 @@ struct ceph_msg {
>   	struct ceph_buffer *middle;
>
>   	/* data payload */
> -	struct ceph_msg_data	p;	/* pages */
> -	struct ceph_msg_data	l;	/* pagelist */
> -#ifdef CONFIG_BLOCK
> -	struct ceph_msg_data	b;	/* bio */
> -#endif /* CONFIG_BLOCK */
> +	struct ceph_msg_data	data;
>
>   	struct ceph_connection *con;
>   	struct list_head list_head;	/* links for connection lists */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 190b74b..30943c1 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1085,22 +1085,15 @@ static void prepare_message_data(struct ceph_msg
> *msg,
>
>   	/* initialize page iterator */
>   	msg_pos->page = 0;
> -	if (ceph_msg_has_pages(msg))
> -		msg_pos->page_pos = msg->p.alignment;
> +	if (ceph_msg_has_data(msg))
> +		msg_pos->page_pos = msg->data.alignment;
>   	else
>   		msg_pos->page_pos = 0;
>   	msg_pos->data_pos = 0;
>
>   	/* Initialize data cursors */
>
> -#ifdef CONFIG_BLOCK
> -	if (ceph_msg_has_bio(msg))
> -		ceph_msg_data_cursor_init(&msg->b, data_len);
> -#endif /* CONFIG_BLOCK */
> -	if (ceph_msg_has_pages(msg))
> -		ceph_msg_data_cursor_init(&msg->p, data_len);
> -	if (ceph_msg_has_pagelist(msg))
> -		ceph_msg_data_cursor_init(&msg->l, data_len);
> +	ceph_msg_data_cursor_init(&msg->data, data_len);
>
>   	msg_pos->did_page_crc = false;
>   }
> @@ -1166,10 +1159,10 @@ static void prepare_write_message(struct
> ceph_connection *con)
>   		m->needs_out_seq = false;
>   	}
>
> -	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d (%zd)\n",
> +	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d\n",
>   	     m, con->out_seq, le16_to_cpu(m->hdr.type),
>   	     le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len),
> -	     le32_to_cpu(m->hdr.data_len), m->p.length);
> +	     le32_to_cpu(m->hdr.data_len));
>   	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);
>
>   	/* tag + hdr + front + middle */
> @@ -1393,14 +1386,7 @@ static void out_msg_pos_next(struct
> ceph_connection *con, struct page *page,
>
>   	msg_pos->data_pos += sent;
>   	msg_pos->page_pos += sent;
> -	if (ceph_msg_has_pages(msg))
> -		need_crc = ceph_msg_data_advance(&msg->p, sent);
> -	else if (ceph_msg_has_pagelist(msg))
> -		need_crc = ceph_msg_data_advance(&msg->l, sent);
> -#ifdef CONFIG_BLOCK
> -	else if (ceph_msg_has_bio(msg))
> -		need_crc = ceph_msg_data_advance(&msg->b, sent);
> -#endif /* CONFIG_BLOCK */
> +	need_crc = ceph_msg_data_advance(&msg->data, sent);
>   	BUG_ON(need_crc && sent != len);
>
>   	if (sent < len)
> @@ -1423,12 +1409,8 @@ static void in_msg_pos_next(struct
> ceph_connection *con, size_t len,
>
>   	msg_pos->data_pos += received;
>   	msg_pos->page_pos += received;
> -	if (ceph_msg_has_pages(msg))
> -		(void) ceph_msg_data_advance(&msg->p, received);
> -#ifdef CONFIG_BLOCK
> -	else if (ceph_msg_has_bio(msg))
> -		(void) ceph_msg_data_advance(&msg->b, received);
> -#endif /* CONFIG_BLOCK */
> +	(void) ceph_msg_data_advance(&msg->data, received);
> +
>   	if (received < len)
>   		return;
>
> @@ -1468,6 +1450,9 @@ static int write_partial_message_data(struct
> ceph_connection *con)
>   	dout("%s %p msg %p page %d offset %d\n", __func__,
>   	     con, msg, msg_pos->page, msg_pos->page_pos);
>
> +	if (WARN_ON(!ceph_msg_has_data(msg)))
> +		return -EINVAL;
> +
>   	/*
>   	 * Iterate through each page that contains data to be
>   	 * written, and send as much as possible for each.
> @@ -1482,23 +1467,8 @@ static int write_partial_message_data(struct
> ceph_connection *con)
>   		size_t length;
>   		bool last_piece;
>
> -		if (ceph_msg_has_pages(msg)) {
> -			page = ceph_msg_data_next(&msg->p, &page_offset,
> -							&length, &last_piece);
> -		} else if (ceph_msg_has_pagelist(msg)) {
> -			page = ceph_msg_data_next(&msg->l, &page_offset,
> -							&length, &last_piece);
> -#ifdef CONFIG_BLOCK
> -		} else if (ceph_msg_has_bio(msg)) {
> -			page = ceph_msg_data_next(&msg->b, &page_offset,
> -							&length, &last_piece);
> -#endif
> -		} else {
> -			WARN(1, "con %p data_len %u but no outbound data\n",
> -				con, data_len);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
> +							&last_piece);
>   		if (do_datacrc && !msg_pos->did_page_crc) {
>   			u32 crc = le32_to_cpu(msg->footer.data_crc);
>
> @@ -2170,20 +2140,13 @@ static int read_partial_msg_data(struct
> ceph_connection *con)
>   	int ret;
>
>   	BUG_ON(!msg);
> +	if (WARN_ON(!ceph_msg_has_data(msg)))
> +		return -EIO;
>
>   	data_len = le32_to_cpu(con->in_hdr.data_len);
>   	while (msg_pos->data_pos < data_len) {
> -		if (ceph_msg_has_pages(msg)) {
> -			page = ceph_msg_data_next(&msg->p, &page_offset,
> -					&length, NULL);
> -#ifdef CONFIG_BLOCK
> -		} else if (ceph_msg_has_bio(msg)) {
> -			page = ceph_msg_data_next(&msg->b, &page_offset,
> -					&length, NULL);
> -#endif
> -		} else {
> -			BUG_ON(1);
> -		}
> +		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
> +							NULL);
>   		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
>   		if (ret <= 0)
>   			return ret;
> @@ -2191,7 +2154,6 @@ static int read_partial_msg_data(struct
> ceph_connection *con)
>   		if (do_datacrc)
>   			con->in_data_crc = ceph_crc32c_page(con->in_data_crc,
>   							page, page_offset, ret);
> -
>   		in_msg_pos_next(con, length, ret);
>   	}
>
> @@ -3011,12 +2973,12 @@ void ceph_msg_data_set_pages(struct ceph_msg
> *msg, struct page **pages,
>   {
>   	BUG_ON(!pages);
>   	BUG_ON(!length);
> -	BUG_ON(msg->p.type != CEPH_MSG_DATA_NONE);
> +	BUG_ON(msg->data.type != CEPH_MSG_DATA_NONE);
>
> -	msg->p.type = CEPH_MSG_DATA_PAGES;
> -	msg->p.pages = pages;
> -	msg->p.length = length;
> -	msg->p.alignment = alignment & ~PAGE_MASK;
> +	msg->data.type = CEPH_MSG_DATA_PAGES;
> +	msg->data.pages = pages;
> +	msg->data.length = length;
> +	msg->data.alignment = alignment & ~PAGE_MASK;
>   }
>   EXPORT_SYMBOL(ceph_msg_data_set_pages);
>
> @@ -3025,20 +2987,20 @@ void ceph_msg_data_set_pagelist(struct ceph_msg
> *msg,
>   {
>   	BUG_ON(!pagelist);
>   	BUG_ON(!pagelist->length);
> -	BUG_ON(msg->l.type != CEPH_MSG_DATA_NONE);
> +	BUG_ON(msg->data.type != CEPH_MSG_DATA_NONE);
>
> -	msg->l.type = CEPH_MSG_DATA_PAGELIST;
> -	msg->l.pagelist = pagelist;
> +	msg->data.type = CEPH_MSG_DATA_PAGELIST;
> +	msg->data.pagelist = pagelist;
>   }
>   EXPORT_SYMBOL(ceph_msg_data_set_pagelist);
>
>   void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
>   {
>   	BUG_ON(!bio);
> -	BUG_ON(msg->b.type != CEPH_MSG_DATA_NONE);
> +	BUG_ON(msg->data.type != CEPH_MSG_DATA_NONE);
>
> -	msg->b.type = CEPH_MSG_DATA_BIO;
> -	msg->b.bio = bio;
> +	msg->data.type = CEPH_MSG_DATA_BIO;
> +	msg->data.bio = bio;
>   }
>   EXPORT_SYMBOL(ceph_msg_data_set_bio);
>
> @@ -3062,9 +3024,7 @@ struct ceph_msg *ceph_msg_new(int type, int
> front_len, gfp_t flags,
>   	INIT_LIST_HEAD(&m->list_head);
>   	kref_init(&m->kref);
>
> -	ceph_msg_data_init(&m->p);
> -	ceph_msg_data_init(&m->l);
> -	ceph_msg_data_init(&m->b);
> +	ceph_msg_data_init(&m->data);
>
>   	/* front */
>   	m->front_max = front_len;
> @@ -3219,15 +3179,11 @@ void ceph_msg_last_put(struct kref *kref)
>   		ceph_buffer_put(m->middle);
>   		m->middle = NULL;
>   	}
> -	if (ceph_msg_has_pages(m)) {
> -		m->p.length = 0;
> -		m->p.pages = NULL;
> -	}
>
> -	if (ceph_msg_has_pagelist(m)) {
> -		ceph_pagelist_release(m->l.pagelist);
> -		kfree(m->l.pagelist);
> -		m->l.pagelist = NULL;
> +	if (ceph_msg_has_data(m) && m->data.type == CEPH_MSG_DATA_PAGELIST) {
> +		ceph_pagelist_release(m->data.pagelist);
> +		kfree(m->data.pagelist);
> +		m->data.pagelist = NULL;
>   	}
>
>   	if (m->pool)
> @@ -3240,7 +3196,7 @@ EXPORT_SYMBOL(ceph_msg_last_put);
>   void ceph_msg_dump(struct ceph_msg *msg)
>   {
>   	pr_debug("msg_dump %p (front_max %d length %zd)\n", msg,
> -		 msg->front_max, msg->p.length);
> +		 msg->front_max, msg->data.length);
>   	print_hex_dump(KERN_DEBUG, "header: ",
>   		       DUMP_PREFIX_OFFSET, 16, 1,
>   		       &msg->hdr, sizeof(msg->hdr), true);
>

