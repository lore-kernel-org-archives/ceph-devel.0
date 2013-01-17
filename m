From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST] rbd: kill ceph_osd_req_op->flags
Date: Wed, 16 Jan 2013 19:01:29 -0800
Message-ID: <50F76989.6070509@inktank.com>
References: <50E6EB40.3050701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:64820 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607Ab3AQDBc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 22:01:32 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so1108022pbc.23
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 19:01:32 -0800 (PST)
In-Reply-To: <50E6EB40.3050701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 06:46 AM, Alex Elder wrote:
> The flags field of struct ceph_osd_req_op is never used, so just get
> rid of it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   include/linux/ceph/osd_client.h |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 2b04d05..69287cc 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -157,7 +157,6 @@ struct ceph_osd_client {
>
>   struct ceph_osd_req_op {
>   	u16 op;           /* CEPH_OSD_OP_* */
> -	u32 flags;        /* CEPH_OSD_FLAG_* */
>   	union {
>   		struct {
>   			u64 offset, length;
>

