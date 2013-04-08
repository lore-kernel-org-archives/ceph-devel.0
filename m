From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/6] libceph: record bio length
Date: Mon, 08 Apr 2013 16:58:07 -0700
Message-ID: <5163598F.5060902@inktank.com>
References: <515F4F01.2000704@inktank.com> <515F4F56.3000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:64243 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936469Ab3DHX6e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 19:58:34 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so2799030dan.24
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 16:58:33 -0700 (PDT)
In-Reply-To: <515F4F56.3000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 03:25 PM, Alex Elder wrote:
> The bio is the only data item type that doesn't record its full
> length.  Fix that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/messenger.h |    5 ++++-
>   net/ceph/messenger.c           |    1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index cdeebae..4fb870a 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -116,7 +116,10 @@ struct ceph_msg_data {
>   	enum ceph_msg_data_type		type;
>   	union {
>   #ifdef CONFIG_BLOCK
> -		struct bio		*bio;
> +		struct {
> +			struct bio	*bio;
> +			size_t		bio_length;
> +		};
>   #endif /* CONFIG_BLOCK */
>   		struct {
>   			struct page	**pages;	/* NOT OWNER. */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index ae825e44..9571d03 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3030,6 +3030,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
> struct bio *bio,
>   	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
>   	BUG_ON(!data);
>   	data->bio = bio;
> +	data->bio_length = length;
>
>   	msg->data = data;
>   	msg->data_length = length;
>

