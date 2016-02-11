From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCHv2 4/6] osd_client, rbd: update event interface for
 watch/notify2
Date: Thu, 11 Feb 2016 18:51:27 +0100
Message-ID: <20160211185127.753d724f@g21.suse.de>
References: <cover.1434550968.git.dfuller@redhat.com>
	<7fbb2dc2af702d07326369133839eab5e09054c3.1434550968.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcBKRva (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Feb 2016 12:51:30 -0500
In-Reply-To: <7fbb2dc2af702d07326369133839eab5e09054c3.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: ceph-devel@vger.kernel.org, Mike Christie <mchristi@redhat.com>

Hi Douglas,

Do you still plan on getting these changes upstream? I have one comment
on this patch:

On Wed, 17 Jun 2015 07:25:54 -0700, Douglas Fuller wrote:

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
> +	rbd_dev_header_unwatch_sync(rbd_dev);
> +	ret = rbd_dev_header_watch_sync(rbd_dev);
> +	rbd_dev_refresh(rbd_dev);
> +	if (ret)
> +		rbd_warn(rbd_dev, "refresh failed: %d", ret);
> +}

The watch reset here could potentially race with the
rbd_dev_header_unwatch_sync() performed on unmap. To handle this,
notify_wq should be stopped prior to unwatch in do_rbd_remove().

Cheers, David
