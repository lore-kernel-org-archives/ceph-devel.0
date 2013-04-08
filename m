From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/6] libceph: move cursor into message
Date: Mon, 08 Apr 2013 16:58:16 -0700
Message-ID: <51635998.10704@inktank.com>
References: <515F4F01.2000704@inktank.com> <515F4F63.4040400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:62034 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936469Ab3DHX6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 19:58:45 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so3464639pdj.38
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 16:58:44 -0700 (PDT)
In-Reply-To: <515F4F63.4040400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 03:25 PM, Alex Elder wrote:
> A message will only be processing a single data item at a time, so
> there's no need for each data item to have its own cursor.
>
> Move the cursor embedded in the message data structure into the
> message itself.  To minimize the impact, keep the data->cursor
> field, but make it be a pointer to the cursor in the message.
>
> Move the definition of ceph_msg_data above ceph_msg_data_cursor so
> the cursor can point to the data without a forward definition rather
> than vice-versa.
>
> This and the upcoming patches are part of:
>      http://tracker.ceph.com/issues/3761
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/messenger.h |   43
> ++++++++++++++++++++--------------------
>   net/ceph/messenger.c           |   35 +++++++++++++++++---------------
>   2 files changed, 41 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 4fb870a..e755724 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -88,6 +88,25 @@ static __inline__ bool ceph_msg_data_type_valid(enum
> ceph_msg_data_type type)
>   	}
>   }
>
> +struct ceph_msg_data {
> +	enum ceph_msg_data_type		type;
> +	union {
> +#ifdef CONFIG_BLOCK
> +		struct {
> +			struct bio	*bio;
> +			size_t		bio_length;
> +		};
> +#endif /* CONFIG_BLOCK */
> +		struct {
> +			struct page	**pages;	/* NOT OWNER. */
> +			size_t		length;		/* total # bytes */
> +			unsigned int	alignment;	/* first page */
> +		};
> +		struct ceph_pagelist	*pagelist;
> +	};
> +	struct ceph_msg_data_cursor	*cursor;
> +};
> +
>   struct ceph_msg_data_cursor {
>   	size_t		resid;		/* bytes not yet consumed */
>   	bool		last_piece;	/* now at last piece of data item */
> @@ -112,25 +131,6 @@ struct ceph_msg_data_cursor {
>   	};
>   };
>
> -struct ceph_msg_data {
> -	enum ceph_msg_data_type		type;
> -	union {
> -#ifdef CONFIG_BLOCK
> -		struct {
> -			struct bio	*bio;
> -			size_t		bio_length;
> -		};
> -#endif /* CONFIG_BLOCK */
> -		struct {
> -			struct page	**pages;	/* NOT OWNER. */
> -			size_t		length;		/* total # bytes */
> -			unsigned int	alignment;	/* first page */
> -		};
> -		struct ceph_pagelist	*pagelist;
> -	};
> -	struct ceph_msg_data_cursor	cursor;		/* pagelist only */
> -};
> -
>   /*
>    * a single message.  it contains a header (src, dest, message type, etc.),
>    * footer (crc values, mainly), a "front" message body, and possibly a
> @@ -142,8 +142,9 @@ struct ceph_msg {
>   	struct kvec front;              /* unaligned blobs of message */
>   	struct ceph_buffer *middle;
>
> -	size_t			data_length;
> -	struct ceph_msg_data	*data;	/* data payload */
> +	size_t				data_length;
> +	struct ceph_msg_data		*data;
> +	struct ceph_msg_data_cursor	cursor;
>
>   	struct ceph_connection *con;
>   	struct list_head list_head;	/* links for connection lists */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 9571d03..287b7fb 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -725,7 +725,7 @@ static void con_out_kvec_add(struct ceph_connection
> *con,
>   static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data *data,
>   					size_t length)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	struct bio *bio;
>
>   	BUG_ON(data->type != CEPH_MSG_DATA_BIO);
> @@ -745,7 +745,7 @@ static struct page *ceph_msg_data_bio_next(struct
> ceph_msg_data *data,
>   						size_t *page_offset,
>   						size_t *length)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	struct bio *bio;
>   	struct bio_vec *bio_vec;
>   	unsigned int index;
> @@ -774,7 +774,7 @@ static struct page *ceph_msg_data_bio_next(struct
> ceph_msg_data *data,
>
>   static bool ceph_msg_data_bio_advance(struct ceph_msg_data *data,
> size_t bytes)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	struct bio *bio;
>   	struct bio_vec *bio_vec;
>   	unsigned int index;
> @@ -826,7 +826,7 @@ static bool ceph_msg_data_bio_advance(struct
> ceph_msg_data *data, size_t bytes)
>   static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data *data,
>   					size_t length)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	int page_count;
>
>   	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
> @@ -849,7 +849,7 @@ static struct page *ceph_msg_data_pages_next(struct
> ceph_msg_data *data,
>   					size_t *page_offset,
>   					size_t *length)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>
>   	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
>
> @@ -868,7 +868,7 @@ static struct page *ceph_msg_data_pages_next(struct
> ceph_msg_data *data,
>   static bool ceph_msg_data_pages_advance(struct ceph_msg_data *data,
>   						size_t bytes)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>
>   	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
>
> @@ -897,7 +897,7 @@ static bool ceph_msg_data_pages_advance(struct
> ceph_msg_data *data,
>   static void ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data,
>   					size_t length)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	struct ceph_pagelist *pagelist;
>   	struct page *page;
>
> @@ -923,7 +923,7 @@ static struct page
> *ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
>   						size_t *page_offset,
>   						size_t *length)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	struct ceph_pagelist *pagelist;
>
>   	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
> @@ -941,13 +941,13 @@ static struct page
> *ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
>   	else
>   		*length = PAGE_SIZE - *page_offset;
>
> -	return data->cursor.page;
> +	return data->cursor->page;
>   }
>
>   static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data *data,
>   						size_t bytes)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	struct ceph_pagelist *pagelist;
>
>   	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
> @@ -1003,7 +1003,7 @@ static void ceph_msg_data_cursor_init(struct
> ceph_msg_data *data,
>   		/* BUG(); */
>   		break;
>   	}
> -	data->cursor.need_crc = true;
> +	data->cursor->need_crc = true;
>   }
>
>   /*
> @@ -1039,7 +1039,7 @@ static struct page *ceph_msg_data_next(struct
> ceph_msg_data *data,
>   	BUG_ON(*page_offset + *length > PAGE_SIZE);
>   	BUG_ON(!*length);
>   	if (last_piece)
> -		*last_piece = data->cursor.last_piece;
> +		*last_piece = data->cursor->last_piece;
>
>   	return page;
>   }
> @@ -1050,7 +1050,7 @@ static struct page *ceph_msg_data_next(struct
> ceph_msg_data *data,
>    */
>   static bool ceph_msg_data_advance(struct ceph_msg_data *data, size_t bytes)
>   {
> -	struct ceph_msg_data_cursor *cursor = &data->cursor;
> +	struct ceph_msg_data_cursor *cursor = data->cursor;
>   	bool new_piece;
>
>   	BUG_ON(bytes > cursor->resid);
> @@ -1071,7 +1071,7 @@ static bool ceph_msg_data_advance(struct
> ceph_msg_data *data, size_t bytes)
>   		BUG();
>   		break;
>   	}
> -	data->cursor.need_crc = new_piece;
> +	data->cursor->need_crc = new_piece;
>
>   	return new_piece;
>   }
> @@ -1404,7 +1404,7 @@ static u32 ceph_crc32c_page(u32 crc, struct page
> *page,
>   static int write_partial_message_data(struct ceph_connection *con)
>   {
>   	struct ceph_msg *msg = con->out_msg;
> -	struct ceph_msg_data_cursor *cursor = &msg->data->cursor;
> +	struct ceph_msg_data_cursor *cursor = msg->data->cursor;
>   	bool do_datacrc = !con->msgr->nocrc;
>   	u32 crc;
>
> @@ -2102,7 +2102,7 @@ static int read_partial_message_section(struct
> ceph_connection *con,
>   static int read_partial_msg_data(struct ceph_connection *con)
>   {
>   	struct ceph_msg *msg = con->in_msg;
> -	struct ceph_msg_data_cursor *cursor = &msg->data->cursor;
> +	struct ceph_msg_data_cursor *cursor = msg->data->cursor;
>   	const bool do_datacrc = !con->msgr->nocrc;
>   	struct page *page;
>   	size_t page_offset;
> @@ -2989,6 +2989,7 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
> struct page **pages,
>
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGES);
>   	BUG_ON(!data);
> +	data->cursor = &msg->cursor;
>   	data->pages = pages;
>   	data->length = length;
>   	data->alignment = alignment & ~PAGE_MASK;
> @@ -3010,6 +3011,7 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
>
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
>   	BUG_ON(!data);
> +	data->cursor = &msg->cursor;
>   	data->pagelist = pagelist;
>
>   	msg->data = data;
> @@ -3029,6 +3031,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
> struct bio *bio,
>
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
>   	BUG_ON(!data);
> +	data->cursor = &msg->cursor;
>   	data->bio = bio;
>   	data->bio_length = length;
>

