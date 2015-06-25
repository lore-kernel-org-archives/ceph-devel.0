From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/3] rbd: queue_depth map option
Date: Thu, 25 Jun 2015 09:24:48 -0500
Message-ID: <558C0F30.6050907@ieee.org>
References: <1435223480-35238-1-git-send-email-idryomov@gmail.com> <1435223480-35238-4-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34342 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbbFYOYt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 10:24:49 -0400
Received: by pabvl15 with SMTP id vl15so50898855pab.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 07:24:49 -0700 (PDT)
In-Reply-To: <1435223480-35238-4-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 06/25/2015 04:11 AM, Ilya Dryomov wrote:
> nr_requests (/sys/block/rbd<id>/queue/nr_requests) is pretty much
> irrelevant in blk-mq case because each driver sets its own max depth
> that it can handle and that's the number of tags that gets preallocated
> on setup.  Users can't increase queue depth beyond that value via
> writing to nr_requests.
>
> For rbd we are happy with the default BLKDEV_MAX_RQ (128) for most
> cases but we want to give users the opportunity to increase it.
> Introduce a new per-device queue_depth option to do just that:
>
>      $ sudo rbd map -o queue_depth=1024 ...
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

I haven't gone to follow through what happens with this
but I assume a value that's too large will be caught when
it's attempted to be used or something.

In any case this looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/block/rbd.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e502bce02d2c..b316ee48a30b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -728,6 +728,7 @@ static struct rbd_client *rbd_client_find(struct ceph_options *ceph_opts)
>    * (Per device) rbd map options
>    */
>   enum {
> +	Opt_queue_depth,
>   	Opt_last_int,
>   	/* int args above */
>   	Opt_last_string,
> @@ -738,6 +739,7 @@ enum {
>   };
>
>   static match_table_t rbd_opts_tokens = {
> +	{Opt_queue_depth, "queue_depth=%d"},
>   	/* int args above */
>   	/* string args above */
>   	{Opt_read_only, "read_only"},
> @@ -748,9 +750,11 @@ static match_table_t rbd_opts_tokens = {
>   };
>
>   struct rbd_options {
> +	int	queue_depth;
>   	bool	read_only;
>   };
>
> +#define RBD_QUEUE_DEPTH_DEFAULT	BLKDEV_MAX_RQ
>   #define RBD_READ_ONLY_DEFAULT	false
>
>   static int parse_rbd_opts_token(char *c, void *private)
> @@ -774,6 +778,13 @@ static int parse_rbd_opts_token(char *c, void *private)
>   	}
>
>   	switch (token) {
> +	case Opt_queue_depth:
> +		if (intval < 1) {
> +			pr_err("queue_depth out of range\n");
> +			return -EINVAL;
> +		}
> +		rbd_opts->queue_depth = intval;
> +		break;
>   	case Opt_read_only:
>   		rbd_opts->read_only = true;
>   		break;
> @@ -3761,10 +3772,9 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>
>   	memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));
>   	rbd_dev->tag_set.ops = &rbd_mq_ops;
> -	rbd_dev->tag_set.queue_depth = BLKDEV_MAX_RQ;
> +	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
>   	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
> -	rbd_dev->tag_set.flags =
> -		BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
> +	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
>   	rbd_dev->tag_set.nr_hw_queues = 1;
>   	rbd_dev->tag_set.cmd_size = sizeof(struct work_struct);
>
> @@ -4948,6 +4958,7 @@ static int rbd_add_parse_args(const char *buf,
>   		goto out_mem;
>
>   	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
> +	rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
>
>   	copts = ceph_parse_options(options, mon_addrs,
>   					mon_addrs + mon_addrs_size - 1,
>

