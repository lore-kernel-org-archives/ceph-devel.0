From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: fix wrong opcode use in osd_req_encode_op()
Date: Mon, 04 Mar 2013 17:37:22 -0800
Message-ID: <51354C52.5070705@inktank.com>
References: <5132AA7F.3000709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37478 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732Ab3CEBhy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 20:37:54 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so3702612pbc.39
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 17:37:54 -0800 (PST)
In-Reply-To: <5132AA7F.3000709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/02/2013 05:42 PM, Alex Elder wrote:
> The new cases added to osd_req_encode_op() caused a new sparse
> error, which highlighted an existing problem that had been
> overlooked since it was originally checked in.  When an unsupported
> opcode is found the destination rather than the source opcode was
> being used in the error message.  The two differ in their byte
> order, and we want to be using the one in the source.
>
> Fix the problem in both spots.
>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: b/net/ceph/osd_client.c
> ===================================================================
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -258,7 +258,7 @@ static void osd_req_encode_op(struct cep
>   		dst->watch.flag = src->watch.flag;
>   		break;
>   	default:
> -		pr_err("unrecognized osd opcode %d\n", dst->op);
> +		pr_err("unrecognized osd opcode %d\n", src->op);
>   		WARN_ON(1);
>   		break;
>   	case CEPH_OSD_OP_MAPEXT:
> @@ -316,7 +316,7 @@ static void osd_req_encode_op(struct cep
>   	case CEPH_OSD_OP_PGLS:
>   	case CEPH_OSD_OP_PGLS_FILTER:
>   		pr_err("unsupported osd opcode %s\n",
> -			ceph_osd_op_name(dst->op));
> +			ceph_osd_op_name(src->op));
>   		WARN_ON(1);
>   		break;
>   	}

