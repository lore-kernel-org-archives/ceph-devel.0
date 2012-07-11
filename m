From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 16/16] rbd: kill num_reply parameters
Date: Wed, 11 Jul 2012 14:07:54 -0700
Message-ID: <4FFDEB2A.9040800@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD87A0.4000602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62731 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2GKVH5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 17:07:57 -0400
Received: by pbbrp8 with SMTP id rp8so2556798pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 14:07:56 -0700 (PDT)
In-Reply-To: <4FFD87A0.4000602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/11/2012 07:03 AM, Alex Elder wrote:
> Several functions include a num_reply parameter, but it is never
> used.  Just get rid of it everywhere--it seems to be something
> that never got fully implemented.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |   19 ++++++-------------
>   1 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index c99ea08..c023be5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -863,7 +863,6 @@ static int rbd_do_request(struct request *rq,
>   			  int num_pages,
>   			  int flags,
>   			  struct ceph_osd_req_op *ops,
> -			  int num_reply,
>   			  struct rbd_req_coll *coll,
>   			  int coll_index,
>   			  void (*rbd_cb)(struct ceph_osd_request *req,
> @@ -1019,7 +1018,6 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>   			   int opcode,
>   			   int flags,
>   			   struct ceph_osd_req_op *orig_ops,
> -			   int num_reply,
>   			   const char *object_name,
>   			   u64 ofs, u64 len,
>   			   char *buf,
> @@ -1055,7 +1053,6 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>   			  pages, num_pages,
>   			  flags,
>   			  ops,
> -			  2,
>   			  NULL, 0,
>   			  NULL,
>   			  linger_req, ver);
> @@ -1080,7 +1077,7 @@ static int rbd_do_op(struct request *rq,
>   		     struct rbd_device *rbd_dev,
>   		     struct ceph_snap_context *snapc,
>   		     u64 snapid,
> -		     int opcode, int flags, int num_reply,
> +		     int opcode, int flags,
>   		     u64 ofs, u64 len,
>   		     struct bio *bio,
>   		     struct rbd_req_coll *coll,
> @@ -1119,7 +1116,6 @@ static int rbd_do_op(struct request *rq,
>   			     NULL, 0,
>   			     flags,
>   			     ops,
> -			     num_reply,
>   			     coll, coll_index,
>   			     rbd_req_cb, 0, NULL);
>
> @@ -1143,7 +1139,6 @@ static int rbd_req_write(struct request *rq,
>   	return rbd_do_op(rq, rbd_dev, snapc, CEPH_NOSNAP,
>   			 CEPH_OSD_OP_WRITE,
>   			 CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> -			 2,
>   			 ofs, len, bio, coll, coll_index);
>   }
>
> @@ -1162,7 +1157,6 @@ static int rbd_req_read(struct request *rq,
>   			 snapid,
>   			 CEPH_OSD_OP_READ,
>   			 CEPH_OSD_FLAG_READ,
> -			 2,
>   			 ofs, len, bio, coll, coll_index);
>   }
>
> @@ -1182,7 +1176,7 @@ static int rbd_req_sync_read(struct rbd_device
> *rbd_dev,
>   			       CEPH_OSD_OP_READ,
>   			       CEPH_OSD_FLAG_READ,
>   			       NULL,
> -			       1, object_name, ofs, len, buf, NULL, ver);
> +			       object_name, ofs, len, buf, NULL, ver);
>   }
>
>   /*
> @@ -1209,7 +1203,6 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *rbd_dev,
>   			  NULL, 0,
>   			  CEPH_OSD_FLAG_READ,
>   			  ops,
> -			  1,
>   			  NULL, 0,
>   			  rbd_simple_req_cb, 0, NULL);
>
> @@ -1265,7 +1258,7 @@ static int rbd_req_sync_watch(struct rbd_device
> *rbd_dev,
>   			      0,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			      ops,
> -			      1, object_name, 0, 0, NULL,
> +			      object_name, 0, 0, NULL,
>   			&rbd_dev->watch_request, NULL);
>
>   	if (ret<  0)
> @@ -1303,7 +1296,7 @@ static int rbd_req_sync_unwatch(struct rbd_device
> *rbd_dev,
>   			      0,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			      ops,
> -			      1, object_name, 0, 0, NULL, NULL, NULL);
> +			      object_name, 0, 0, NULL, NULL, NULL);
>
>   	rbd_destroy_ops(ops);
>   	ceph_osdc_cancel_event(rbd_dev->watch_event);
> @@ -1361,7 +1354,7 @@ static int rbd_req_sync_notify(struct rbd_device
> *rbd_dev,
>   			       0,
>   			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			       ops,
> -			       1, object_name, 0, 0, NULL, NULL, NULL);
> +			       object_name, 0, 0, NULL, NULL, NULL);
>   	if (ret<  0)
>   		goto fail_event;
>
> @@ -1409,7 +1402,7 @@ static int rbd_req_sync_exec(struct rbd_device
> *rbd_dev,
>   			       0,
>   			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			       ops,
> -			       1, object_name, 0, 0, NULL, NULL, ver);
> +			       object_name, 0, 0, NULL, NULL, ver);
>
>   	rbd_destroy_ops(ops);
>

