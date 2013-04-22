From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: fix byte order mismatch
Date: Mon, 22 Apr 2013 15:26:31 -0700
Message-ID: <5175B917.4060802@inktank.com>
References: <5174606B.4090906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:42596 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab3DVW1Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 18:27:16 -0400
Received: by mail-pd0-f174.google.com with SMTP id y14so962295pdi.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 15:27:16 -0700 (PDT)
In-Reply-To: <5174606B.4090906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/21/2013 02:55 PM, Alex Elder wrote:
> A WATCH op includes an object version.  The version that's supplied
> is incorrectly byte-swapped osd_req_op_watch_init() where it's first
> assigned (it's been this way since that code was first added).
>
> The result is that the version sent to the osd is wrong, because
> that value gets byte-swapped again in osd_req_encode_op().  This
> is the source of a sparse warning related to improper byte order in
> the assignment.
>
> The approach of using the version to avoid a race is deprecated
> (see http://tracker.ceph.com/issues/3871), and the watch parameter
> is no longer even examined by the osd.  So fix the assignment in
> osd_req_op_watch_init() so it no longer does the byte swap.

IIRC it was never examined by the osd. Doesn't hurt to fix the encoding
though.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> This resolves:
>      http://tracker.ceph.com/issues/3847
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 467020c..57d8db5 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -577,8 +577,7 @@ void osd_req_op_watch_init(struct ceph_osd_request
> *osd_req,
>   	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);
>
>   	op->watch.cookie = cookie;
> -	/* op->watch.ver = version; */	/* XXX 3847 */
> -	op->watch.ver = cpu_to_le64(version);
> +	op->watch.ver = version;
>   	if (opcode == CEPH_OSD_OP_WATCH && flag)
>   		op->watch.flag = (u8)1;
>   }
>

