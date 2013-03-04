From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 3/3] libceph: no need for alignment for mds message
Date: Mon, 4 Mar 2013 11:09:04 -0800
Message-ID: <CAPYLRzj2Udv1W5v5vg=6BDy7cZBJ_PW8_ivuBuCOPPZEzDy+0A@mail.gmail.com>
References: <5134E25E.4030701@inktank.com>
	<5134E3AD.4080906@inktank.com>
	<5134E40C.1090303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:56775 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3CDTJG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:09:06 -0500
Received: by mail-qe0-f50.google.com with SMTP id k5so2978724qej.37
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:09:04 -0800 (PST)
In-Reply-To: <5134E40C.1090303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks good.
Reviewed-by: Greg Farnum <greg@inktank.com>

On Mon, Mar 4, 2013 at 10:12 AM, Alex Elder <elder@inktank.com> wrote:
> Currently, incoming mds messages never use page data, which means
> there is no need to set the page_alignment field in the message.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  fs/ceph/mds_client.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a4b986a..afb9dc9 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3486,7 +3486,6 @@ static struct ceph_msg *mds_alloc_msg(struct
> ceph_connection *con,
>                        type, front_len);
>                 return NULL;
>         }
> -       msg->page_alignment = (unsigned int) le16_to_cpu(hdr->data_off);
>
>         return msg;
>  }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
