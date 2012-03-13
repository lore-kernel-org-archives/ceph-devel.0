From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: fix inverted crc option logic
Date: Mon, 12 Mar 2012 22:39:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203122238540.17324@cobra.newdream.net>
References: <4F5E77B3.4070801@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57277 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab2CMFjA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 01:39:00 -0400
In-Reply-To: <4F5E77B3.4070801@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@newdream.net>

On Mon, 12 Mar 2012, Alex Elder wrote:

> CRC's are computed for all messages between ceph entities.  The CRC
> computation for the data portion of message can optionally be
> disabled using the "nocrc" (common) ceph option.  The default is
> for CRC computation for the data portion to be enabled.
> 
> Unfortunately, the code that implements this feature interprets the
> feature flag wrong, meaning that by default the CRC's have *not*
> been computed (or checked) for the data portion of messages unless
> the "nocrc" option was supplied.
> 
> Fix this, in write_partial_msg_pages() and read_partial_message().
> Also change the flag variable in write_partial_msg_pages() to be
> "no_datacrc" to match the usage elsewhere in the file.
> 
> This fixes http://tracker.newdream.net/issues/2064
> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  net/ceph/messenger.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 1a22975..589b768 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -812,7 +812,7 @@ static int write_partial_msg_pages(struct ceph_connection
> *con)
>  	struct ceph_msg *msg = con->out_msg;
>  	unsigned data_len = le32_to_cpu(msg->hdr.data_len);
>  	size_t len;
> -	bool do_crc = con->msgr->nocrc;
> +	bool do_datacrc = !con->msgr->nocrc;
>  	int ret;
>  	int total_max_write;
>  	int in_trail = 0;
> @@ -850,17 +850,17 @@ static int write_partial_msg_pages(struct
> ceph_connection *con)
> 
>  			page = list_first_entry(&msg->trail->head,
>  						struct page, lru);
> -			if (do_crc)
> +			if (do_datacrc)
>  				kaddr = kmap(page);
>  			max_write = PAGE_SIZE;
>  		} else if (msg->pages) {
>  			page = msg->pages[con->out_msg_pos.page];
> -			if (do_crc)
> +			if (do_datacrc)
>  				kaddr = kmap(page);
>  		} else if (msg->pagelist) {
>  			page = list_first_entry(&msg->pagelist->head,
>  						struct page, lru);
> -			if (do_crc)
> +			if (do_datacrc)
>  				kaddr = kmap(page);
>  #ifdef CONFIG_BLOCK
>  		} else if (msg->bio) {
> @@ -869,19 +869,19 @@ static int write_partial_msg_pages(struct
> ceph_connection *con)
>  			bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
>  			page = bv->bv_page;
>  			page_shift = bv->bv_offset;
> -			if (do_crc)
> +			if (do_datacrc)
>  				kaddr = kmap(page) + page_shift;
>  			max_write = bv->bv_len;
>  #endif
>  		} else {
>  			page = zero_page;
> -			if (do_crc)
> +			if (do_datacrc)
>  				kaddr = zero_page_address;
>  		}
>  		len = min_t(int, max_write - con->out_msg_pos.page_pos,
>  			    total_max_write);
> 
> -		if (do_crc && !con->out_msg_pos.did_page_crc) {
> +		if (do_datacrc && !con->out_msg_pos.did_page_crc) {
>  			u32 crc;
>  			void *base = kaddr + con->out_msg_pos.page_pos;
>  			u32 tmpcrc =
> le32_to_cpu(con->out_msg->footer.data_crc);
> @@ -897,7 +897,7 @@ static int write_partial_msg_pages(struct ceph_connection
> *con)
>  				      MSG_DONTWAIT | MSG_NOSIGNAL |
>  				      MSG_MORE);
> 
> -		if (do_crc && kaddr != zero_page_address)
> +		if (do_datacrc && kaddr != zero_page_address)
>  			kunmap(page);
> 
>  		if (ret == -EAGAIN)
> @@ -927,7 +927,7 @@ static int write_partial_msg_pages(struct ceph_connection
> *con)
>  	dout("write_partial_msg_pages %p msg %p done\n", con, msg);
> 
>  	/* prepare and queue up footer, too */
> -	if (!do_crc)
> +	if (!do_datacrc)
>  		con->out_msg->footer.flags |= CEPH_MSG_FOOTER_NOCRC;
>  	ceph_con_out_kvec_reset(con);
>  	prepare_write_message_footer(con);
> @@ -1639,7 +1639,7 @@ static int read_partial_message(struct ceph_connection
> *con)
>  	int ret;
>  	int to, left;
>  	unsigned front_len, middle_len, data_len;
> -	bool do_datacrc = con->msgr->nocrc;
> +	bool do_datacrc = !con->msgr->nocrc;
>  	int skip;
>  	u64 seq;
>  	u32 crc;
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
