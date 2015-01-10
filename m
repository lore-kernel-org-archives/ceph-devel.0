From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: convert to blk-mq
Date: Sat, 10 Jan 2015 17:40:20 -0600
Message-ID: <54B1B864.4080008@ieee.org>
References: <1420914688-27563-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34220 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbAJXkW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jan 2015 18:40:22 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so6841170igb.1
        for <ceph-devel@vger.kernel.org>; Sat, 10 Jan 2015 15:40:21 -0800 (PST)
In-Reply-To: <1420914688-27563-1-git-send-email-hch@lst.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On 01/10/2015 12:31 PM, Christoph Hellwig wrote:
> This converts the rbd driver to use the blk-mq infrastructure.  Except
> for switching to a per-request work item this is almost mechanical.
> 
> This was tested by Alexandre DERUMIER in November, and found to give
> him 120000 iops, although the only comparism available was an old
> 3.10 kernel which gave 80000iops.

I'm coming up to speed with the blk-mq stuff only now.  It looks
like requests are sent to the driver via ->queue_rq() rather than
the driver taking them via blk_fetch_request(q).

Previously we would pull as many requests as were available, put
them on the device's request queue, and then activate the rbd
workqueue to handle them one-by-one using rbd_handle_request().

Now, the rbd queue_rq method rbd_request_workfn() adds the request
to the rbd workqueue directly.  The work_struct implicitly follows
the request structure (which is set up by the blk-mq code).  We
have to do the REQ_TYPE_FS check at the time it's queued now,
rather than when it's fetched from the queue.  And finally we now
have to tell the blk-mq subsystem when we've started and ended a
request.

I didn't follow up on all the tag_set initialization values
so I assume you got that right (it looks reasonable to me).

Given the above, it looks like everything else should work
about the same as before, we're just handed requests rather
than asking for them.

With this patch applied, rbd_device->rq_queue is no longer
needed so you should delete it.  I got two warnings about
endo-of-line whitespace in your patch.  And I have one other
very small suggestion below.

Other than those things, this looks great to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 118 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3ec85df..52cd677 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c

. . .

(The following is in the new rbd_queue_rq().)

> +	queue_work(rbd_wq, work);
> +	return 0;

	return BLK_MQ_RQ_QUEUE_OK;

(Because the symbolic values are explicitly checked
by the caller.)

>  }
>  
>  /*

. . .

