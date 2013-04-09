From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/6, v3] libceph: implement multiple data items in a message
Date: Mon, 08 Apr 2013 17:27:58 -0700
Message-ID: <5163608E.7010203@inktank.com>
References: <515F4F01.2000704@inktank.com> <515F4F96.4010308@inktank.com> <515F6009.3050704@inktank.com> <51635752.5080507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:54797 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952Ab3DIA2Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 20:28:25 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx1so3547730pab.14
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 17:28:24 -0700 (PDT)
In-Reply-To: <51635752.5080507@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/08/2013 04:48 PM, Alex Elder wrote:
> Sorry, I've found another problem with this patch.
> I've updated it below, and have updated the patches
> that followed it.  The result is available in the
> "review/wip-3761-5" branch of the ceph-client git
> repository.
>
> Previously there were assertions that caught attempts
> to add more than one data item to a message.  Those
> need to go away, now that we support multiple
> data items.
>
>
>
> This patch adds support to the messenger for more than one data item
> in its data list.
>
> A message data cursor has two more fields to support this:
>      - a count of the number of bytes left to be consumed across
>        all data items in the list, "total_resid"
>      - a pointer to the head of the list (for validation only)
>
> The cursor initialization routine has been split into two parts: the
> outer one, which initializes the cursor for traversing the entire
> list of data items; and the inner one, which initializes the cursor
> to start processing a single data item.
>
> When a message cursor is first initialized, the outer initialization
> routine sets total_resid to the length provided.  The data pointer
> is initialized to the first data item on the list.  From there, the
> inner initialization routine finishes by setting up to process the
> data item the cursor points to.
>
> Advancing the cursor consumes bytes in total_resid.  If the resid
> field reaches zero, it means the current data item is fully
> consumed.  If total_resid indicates there is more data, the cursor
> is advanced to point to the next data item, and then the inner
> initialization routine prepares for using that.  (A check is made at
> this point to make sure we don't wrap around the front of the list.)
>
> The type-specific init routines are modified so they can be given a
> length that's larger than what the data item can support.  The resid
> field is initialized to the smaller of the provided length and the
> length of the entire data item.
>
> When total_resid reaches zero, we're done.
>
> This resolves:
>      http://tracker.ceph.com/issues/3761
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: set total_resid to the passed-in length when initializing cursor
> v3: turn off single data item assertions; it's ok now
>
>   include/linux/ceph/messenger.h |    5 ++++-
>   net/ceph/messenger.c           |   48
> ++++++++++++++++++++++++++--------------
>   2 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 318da01..de1d2e1 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -108,7 +108,10 @@ struct ceph_msg_data {
>   };
>
>   struct ceph_msg_data_cursor {
> -	struct ceph_msg_data	*data;		/* data item this describes */
> +	size_t			total_resid;	/* across all data items */
> +	struct list_head	*data_head;	/* = &ceph_msg->data */
> +
> +	struct ceph_msg_data	*data;		/* current data item */
>   	size_t			resid;		/* bytes not yet consumed */
>   	bool			last_piece;	/* current is last piece */
>   	bool			need_crc;	/* crc update needed */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 8bfe7d3..84703e5 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -734,7 +734,7 @@ static void ceph_msg_data_bio_cursor_init(struct
> ceph_msg_data_cursor *cursor,
>   	BUG_ON(!bio);
>   	BUG_ON(!bio->bi_vcnt);
>
> -	cursor->resid = length;
> +	cursor->resid = min(length, data->bio_length);
>   	cursor->bio = bio;
>   	cursor->vector_index = 0;
>   	cursor->vector_offset = 0;
> @@ -833,9 +833,8 @@ static void ceph_msg_data_pages_cursor_init(struct
> ceph_msg_data_cursor *cursor,
>
>   	BUG_ON(!data->pages);
>   	BUG_ON(!data->length);
> -	BUG_ON(length > data->length);	/* short reads are OK */
>
> -	cursor->resid = length;
> +	cursor->resid = min(length, data->length);
>   	page_count = calc_pages_for(data->alignment, (u64)data->length);
>   	cursor->page_offset = data->alignment & ~PAGE_MASK;
>   	cursor->page_index = 0;
> @@ -904,7 +903,6 @@ ceph_msg_data_pagelist_cursor_init(struct
> ceph_msg_data_cursor *cursor,
>
>   	pagelist = data->pagelist;
>   	BUG_ON(!pagelist);
> -	BUG_ON(length > pagelist->length);	/* short reads are OK */
>
>   	if (!length)
>   		return;		/* pagelist can be assigned but empty */
> @@ -912,7 +910,7 @@ ceph_msg_data_pagelist_cursor_init(struct
> ceph_msg_data_cursor *cursor,
>   	BUG_ON(list_empty(&pagelist->head));
>   	page = list_first_entry(&pagelist->head, struct page, lru);
>
> -	cursor->resid = length;
> +	cursor->resid = min(length, pagelist->length);
>   	cursor->page = page;
>   	cursor->offset = 0;
>   	cursor->last_piece = length <= PAGE_SIZE;
> @@ -982,13 +980,10 @@ static bool ceph_msg_data_pagelist_advance(struct
> ceph_msg_data_cursor *cursor,
>    * be processed in that piece.  It also tracks whether the current
>    * piece is the last one in the data item.
>    */
> -static void ceph_msg_data_cursor_init(struct ceph_msg *msg, size_t length)
> +static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor
> *cursor)
>   {
> -	struct ceph_msg_data_cursor *cursor = &msg->cursor;
> -	struct ceph_msg_data *data;
> +	size_t length = cursor->total_resid;
>
> -	data = list_first_entry(&msg->data, struct ceph_msg_data, links);
> -	cursor->data = data;
>   	switch (cursor->data->type) {
>   	case CEPH_MSG_DATA_PAGELIST:
>   		ceph_msg_data_pagelist_cursor_init(cursor, length);
> @@ -1009,6 +1004,25 @@ static void ceph_msg_data_cursor_init(struct
> ceph_msg *msg, size_t length)
>   	cursor->need_crc = true;
>   }
>
> +static void ceph_msg_data_cursor_init(struct ceph_msg *msg, size_t length)
> +{
> +	struct ceph_msg_data_cursor *cursor = &msg->cursor;
> +	struct ceph_msg_data *data;
> +
> +	BUG_ON(!length);
> +	BUG_ON(length > msg->data_length);
> +	BUG_ON(list_empty(&msg->data));
> +
> +	data = list_first_entry(&msg->data, struct ceph_msg_data, links);
> +
> +	cursor->data_head = &msg->data;
> +	cursor->total_resid = length;
> +	data = list_first_entry(&msg->data, struct ceph_msg_data, links);
> +	cursor->data = data;
> +
> +	__ceph_msg_data_cursor_init(cursor);
> +}
> +
>   /*
>    * Return the page containing the next piece to process for a given
>    * data item, and supply the page offset and length of that piece.
> @@ -1073,8 +1087,16 @@ static bool ceph_msg_data_advance(struct
> ceph_msg_data_cursor *cursor,
>   		BUG();
>   		break;
>   	}
> +	cursor->total_resid -= bytes;
>   	cursor->need_crc = new_piece;
>
> +	if (!cursor->resid && cursor->total_resid) {
> +		WARN_ON(!cursor->last_piece);
> +		BUG_ON(list_is_last(&cursor->data->links, cursor->data_head));
> +		cursor->data = list_entry_next(cursor->data, links);
> +		__ceph_msg_data_cursor_init(cursor);
> +	}
> +
>   	return new_piece;
>   }
>
> @@ -2990,8 +3012,6 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
> struct page **pages,
>
>   	BUG_ON(!pages);
>   	BUG_ON(!length);
> -	BUG_ON(msg->data_length);
> -	BUG_ON(!list_empty(&msg->data));
>
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGES);
>   	BUG_ON(!data);
> @@ -3012,8 +3032,6 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
>
>   	BUG_ON(!pagelist);
>   	BUG_ON(!pagelist->length);
> -	BUG_ON(msg->data_length);
> -	BUG_ON(!list_empty(&msg->data));
>
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
>   	BUG_ON(!data);
> @@ -3031,8 +3049,6 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
> struct bio *bio,
>   	struct ceph_msg_data *data;
>
>   	BUG_ON(!bio);
> -	BUG_ON(msg->data_length);
> -	BUG_ON(!list_empty(&msg->data));
>
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
>   	BUG_ON(!data);
>

