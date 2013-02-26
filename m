From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: make ceph_msg->bio_seg be unsigned
Date: Tue, 26 Feb 2013 10:12:48 -0800
Message-ID: <512CFB20.3060507@inktank.com>
References: <512BE85F.5090502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:34974 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3BZSNL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 13:13:11 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so2519337pbc.37
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 10:13:11 -0800 (PST)
In-Reply-To: <512BE85F.5090502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/25/2013 02:40 PM, Alex Elder wrote:
> The bio_seg field is used by the ceph messenger in iterating through
> a bio.  It should never have a negative value, so make it an
> unsigned.
>
> Change variables used to hold bio_seg values to all be unsigned as
> well.  Change two variable names in init_bio_iter() to match the
> convention used everywhere else.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/messenger.h |    2 +-
>   net/ceph/messenger.c           |   16 +++++++++-------
>   2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 60903e0..8297288 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -86,7 +86,7 @@ struct ceph_msg {
>   #ifdef CONFIG_BLOCK
>   	struct bio  *bio;		/* instead of pages/pagelist */
>   	struct bio  *bio_iter;		/* bio iterator */
> -	int bio_seg;			/* current bio segment */
> +	unsigned int bio_seg;		/* current bio segment */
>   #endif /* CONFIG_BLOCK */
>   	struct ceph_pagelist *trail;	/* the trailing part of the data */
>   	bool front_is_vmalloc;
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 2c0669f..c06f940 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -697,18 +697,19 @@ static void con_out_kvec_add(struct
> ceph_connection *con,
>   }
>
>   #ifdef CONFIG_BLOCK
> -static void init_bio_iter(struct bio *bio, struct bio **iter, int *seg)
> +static void init_bio_iter(struct bio *bio, struct bio **bio_iter,
> +			unsigned int *bio_seg)
>   {
>   	if (!bio) {
> -		*iter = NULL;
> -		*seg = 0;
> +		*bio_iter = NULL;
> +		*bio_seg = 0;
>   		return;
>   	}
> -	*iter = bio;
> -	*seg = bio->bi_idx;
> +	*bio_iter = bio;
> +	*bio_seg = (unsigned int) bio->bi_idx;
>   }
>
> -static void iter_bio_next(struct bio **bio_iter, int *seg)
> +static void iter_bio_next(struct bio **bio_iter, unsigned int *seg)
>   {
>   	if (*bio_iter == NULL)
>   		return;
> @@ -1818,7 +1819,8 @@ static int read_partial_message_pages(struct
> ceph_connection *con,
>
>   #ifdef CONFIG_BLOCK
>   static int read_partial_message_bio(struct ceph_connection *con,
> -				    struct bio **bio_iter, int *bio_seg,
> +				    struct bio **bio_iter,
> +				    unsigned int *bio_seg,
>   				    unsigned int data_len, bool do_datacrc)
>   {
>   	struct bio_vec *bv = bio_iovec_idx(*bio_iter, *bio_seg);
>

