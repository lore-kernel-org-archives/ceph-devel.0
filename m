From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: support pages for class request data
Date: Mon, 22 Apr 2013 00:15:39 -0700
Message-ID: <5174E39B.8040401@inktank.com>
References: <5171C963.2050402@inktank.com> <5171CA01.7000805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:48980 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab3DVHPm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 03:15:42 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so789307dan.24
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 00:15:41 -0700 (PDT)
In-Reply-To: <5171CA01.7000805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/19/2013 03:49 PM, Alex Elder wrote:
> Add the ability to provide an array of pages as outbound request
> data for object class method calls.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osd_client.h |    5 +++++
>   net/ceph/osd_client.c           |   12 ++++++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 4d84a2b..4191cd2 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -273,6 +273,11 @@ extern void osd_req_op_extent_osd_data_bio(struct
> ceph_osd_request *,
>   extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
>   					unsigned int which,
>   					struct ceph_pagelist *pagelist);
> +extern void osd_req_op_cls_request_data_pages(struct ceph_osd_request *,
> +					unsigned int which,
> +					struct page **pages, u64 length,
> +					u32 alignment, bool pages_from_pool,
> +					bool own_pages);
>   extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
>   					unsigned int which,
>   					struct page **pages, u64 length,
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index c842e87..467020c 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -214,6 +214,18 @@ void osd_req_op_cls_request_data_pagelist(
>   }
>   EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
>
> +void osd_req_op_cls_request_data_pages(struct ceph_osd_request *osd_req,
> +			unsigned int which, struct page **pages, u64 length,
> +			u32 alignment, bool pages_from_pool, bool own_pages)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
> +	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
> +				pages_from_pool, own_pages);
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_request_data_pages);
> +
>   void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
>   			unsigned int which, struct page **pages, u64 length,
>   			u32 alignment, bool pages_from_pool, bool own_pages)
>

