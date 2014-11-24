From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: don't treat CEPH_OSD_OP_DELETE as extent op
Date: Mon, 24 Nov 2014 06:23:02 -0600
Message-ID: <54732326.7050301@ieee.org>
References: <1416823190-10246-1-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:61417 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaKXMXF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 07:23:05 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so3210364iga.8
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 04:23:03 -0800 (PST)
In-Reply-To: <1416823190-10246-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 11/24/2014 03:59 AM, Ilya Dryomov wrote:
> CEPH_OSD_OP_DELETE is not an extent op, stop treating it as such.  This
> sneaked in with discard patches - it's one of the three osd ops (the
> other two are CEPH_OSD_OP_TRUNCATE and CEPH_OSD_OP_ZERO) that discard
> is implemented with.
> 
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>

Is the CEPH_OSD_OP_DELETE used in ceph_zero_partial_object()
an extent op?  If it is not, you should get rid of the BUG_ON()
in osd_req_op_extent_init() that allows CEPH_OSD_OP_DELETE.

And if that's the case it looks like that function or
ceph_osdc_new_request() handle CEPH_OSD_OP_DELETE
properly--so it's not treated as an extent op.

And:  osd_req_encode_op() encodes a CEPH_OSD_OP_DELETE
as an extent op as well.

If it *can* be an extent op (but just not as used by RBD)
then it warrants a comment here that explains why it is
not being initialized as an extent op.

					-Alex

> ---
>  drivers/block/rbd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 27b71a0b72d0..1df0802bf6cb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2370,8 +2370,12 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
>  		opcode = CEPH_OSD_OP_READ;
>  	}
>  
> -	osd_req_op_extent_init(osd_request, num_ops, opcode, offset, length,
> -				0, 0);
> +	if (opcode == CEPH_OSD_OP_DELETE)
> +		osd_req_op_init(osd_request, num_ops, opcode);
> +	else
> +		osd_req_op_extent_init(osd_request, num_ops, opcode,
> +				       offset, length, 0, 0);
> +
>  	if (obj_request->type == OBJ_REQUEST_BIO)
>  		osd_req_op_extent_osd_data_bio(osd_request, num_ops,
>  					obj_request->bio_list, length);
> 

