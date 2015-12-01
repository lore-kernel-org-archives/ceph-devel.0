From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] rbd: don't put snap_context twice in rbd_queue_workfn()
Date: Tue, 1 Dec 2015 13:04:51 -0800
Message-ID: <565E0B73.2060106@redhat.com>
References: <1449000269-27732-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59964 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbbLAVER (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 16:04:17 -0500
In-Reply-To: <1449000269-27732-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 12/01/2015 12:04 PM, Ilya Dryomov wrote:
> Commit 4e752f0ab0e8 ("rbd: access snapshot context and mapping size
> safely") moved ceph_get_snap_context() out of rbd_img_request_create()
> and into rbd_queue_workfn(), adding a ceph_put_snap_context() to the
> error path in rbd_queue_workfn().  However, rbd_img_request_create()
> consumes a ref on snapc, so calling ceph_put_snap_context() after
> a successful rbd_img_request_create() leads to an extra put.  Fix it.
>
> Cc: stable@vger.kernel.org # 3.18+
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Whoops!

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

>   drivers/block/rbd.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 24a757e97d56..4a876785b68c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3442,6 +3442,7 @@ static void rbd_queue_workfn(struct work_struct *work)
>   		goto err_rq;
>   	}
>   	img_request->rq = rq;
> +	snapc = NULL; /* img_request consumes a ref */
>
>   	if (op_type == OBJ_OP_DISCARD)
>   		result = rbd_img_request_fill(img_request, OBJ_REQUEST_NODATA,
>

