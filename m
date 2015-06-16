From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH 4/6] osd_client, rbd: update event interface for watch/notify2
Date: Tue, 16 Jun 2015 16:18:33 -0700
Message-ID: <5580AEC9.9020908@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbbFPXSa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 19:18:30 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id BE584B7A80
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 23:18:29 +0000 (UTC)
In-Reply-To: <1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/12/2015 08:56 AM, Douglas Fuller wrote:
> Change unused ceph_osd_event structure to refer to pending watch/notify2
> messages. Watch events include the separate watch and watch error callbacks
> used for watch/notify2. Update rbd to use separate watch and watch error
> callbacks via the new watch event.
>
> Signed-off-by: Douglas Fuller <dfuller@redhat.com>
> ---
>   drivers/block/rbd.c             |  41 +++++++---
>   include/linux/ceph/osd_client.h |  27 +++++--
>   net/ceph/osd_client.c           | 175 +++++++++++++++++++++++++++++-----------
>   3 files changed, 179 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ed170b1..20b3b23 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -427,6 +427,8 @@ static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
>   				       size_t count);
>   static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
>   static void rbd_spec_put(struct rbd_spec *spec);
> +static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev);
> +static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev);
>
>   static int rbd_dev_id_to_minor(int dev_id)
>   {
> @@ -3103,19 +3105,17 @@ out:
>   	return ret;
>   }
>
> -static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
> -			 u64 notifier_gid, void *data, void *payload,
> -			 u32 payload_len)
> +static void rbd_watch_cb(void *arg, u64 notify_id, u64 cookie, u64 notifier_id,
> +                        void *data, size_t data_len)
>   {
> -	struct rbd_device *rbd_dev = (struct rbd_device *)data;
> +	struct rbd_device *rbd_dev = (struct rbd_device *)arg;
>   	int ret;
>
>   	if (!rbd_dev)
>   		return;
>
> -	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
> -		rbd_dev->header_name, (unsigned long long)notify_id,
> -		(unsigned int)opcode);
> +	dout("%s: \"%s\" notify_id %llu bl len %lu\n", __func__,
> +	    rbd_dev->header_name, (unsigned long long)notify_id, data_len);
>
>   	/*
>   	 * Until adequate refresh error handling is in place, there is
> @@ -3132,6 +3132,26 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
>   		rbd_warn(rbd_dev, "notify_ack ret %d", ret);
>   }
>
> +static void rbd_watch_error_cb(void *arg, u64 cookie, int err)
> +{
> +	struct rbd_device *rbd_dev = (struct rbd_device *)arg;
> +	int ret;
> +
> +	dout("%s: watch error %d on cookie %llu\n", rbd_dev->header_name,
> +		err, cookie);
> +	rbd_warn(rbd_dev, "%s: watch error %d on cookie %llu\n",
> +	         rbd_dev->header_name, err, cookie);
> +
> +	/* reset watch */
> +	rbd_dev_refresh(rbd_dev);
> +	rbd_dev_header_unwatch_sync(rbd_dev);
> +	ret = rbd_dev_header_watch_sync(rbd_dev);
> +	BUG_ON(ret); /* XXX: was the image deleted? can we be more graceful? */
> +	rbd_dev_refresh(rbd_dev);

Why refresh before and after unwatching? Only the second one seems
necessary.

