From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 05/20] libceph: define ceph_osd_data_length()
Date: Fri, 05 Apr 2013 11:17:18 -0700
Message-ID: <515F152E.8090102@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED972.2030309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55778 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162362Ab3DESRj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 14:17:39 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so2129117pdi.22
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 11:17:39 -0700 (PDT)
In-Reply-To: <515ED972.2030309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:02 AM, Alex Elder wrote:
> One more osd data helper, which returns the length of the
> data item, regardless of its type.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |   31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index df0f856..110cd83 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -117,6 +117,25 @@ void ceph_osd_data_bio_init(struct ceph_osd_data
> *osd_data,
>   EXPORT_SYMBOL(ceph_osd_data_bio_init);
>   #endif /* CONFIG_BLOCK */
>
> +static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
> +{
> +	switch (osd_data->type) {
> +	case CEPH_OSD_DATA_TYPE_NONE:
> +		return 0;
> +	case CEPH_OSD_DATA_TYPE_PAGES:
> +		return osd_data->length;
> +	case CEPH_OSD_DATA_TYPE_PAGELIST:
> +		return (u64)osd_data->pagelist->length;
> +#ifdef CONFIG_BLOCK
> +	case CEPH_OSD_DATA_TYPE_BIO:
> +		return (u64)osd_data->bio_length;
> +#endif /* CONFIG_BLOCK */
> +	default:
> +		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
> +		return 0;
> +	}
> +}
> +
>   static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
>   {
>   	if (osd_data->type != CEPH_OSD_DATA_TYPE_PAGES)
> @@ -1887,17 +1906,19 @@ bad:
>   static void ceph_osdc_msg_data_set(struct ceph_msg *msg,
>   				struct ceph_osd_data *osd_data)
>   {
> +	u64 length = ceph_osd_data_length(osd_data);
> +
>   	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
> -		BUG_ON(osd_data->length > (u64) SIZE_MAX);
> -		if (osd_data->length)
> +		BUG_ON(length > (u64) SIZE_MAX);
> +		if (length)
>   			ceph_msg_data_set_pages(msg, osd_data->pages,
> -				osd_data->length, osd_data->alignment);
> +					length, osd_data->alignment);
>   	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
> -		BUG_ON(!osd_data->pagelist->length);
> +		BUG_ON(!length);
>   		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
>   #ifdef CONFIG_BLOCK
>   	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
> -		ceph_msg_data_set_bio(msg, osd_data->bio, osd_data->bio_length);
> +		ceph_msg_data_set_bio(msg, osd_data->bio, length);
>   #endif
>   	} else {
>   		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
>

