From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH 4/6] osd_client, rbd: update event interface for
 watch/notify2
Date: Tue, 16 Jun 2015 13:05:33 -0400 (EDT)
Message-ID: <1394702260.16200045.1434474333441.JavaMail.zimbra@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com> <5580397F.9060306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:56858 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbFPRFd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 13:05:33 -0400
In-Reply-To: <5580397F.9060306@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org



----- Original Message -----
> From: "Mike Christie" <mchristi@redhat.com>
> To: "Douglas Fuller" <dfuller@redhat.com>, ceph-devel@vger.kernel.org
> Sent: Tuesday, June 16, 2015 10:58:07 AM
> Subject: Re: [PATCH 4/6] osd_client, rbd: update event interface for watch/notify2
> 
> On 06/12/2015 10:56 AM, Douglas Fuller wrote:
> > +static void rbd_watch_error_cb(void *arg, u64 cookie, int err)
> > +{
> > +	struct rbd_device *rbd_dev = (struct rbd_device *)arg;
> > +	int ret;
> > +
> > +	dout("%s: watch error %d on cookie %llu\n", rbd_dev->header_name,
> > +		err, cookie);
> > +	rbd_warn(rbd_dev, "%s: watch error %d on cookie %llu\n",
> > +	         rbd_dev->header_name, err, cookie);
> > +
> > +	/* reset watch */
> > +	rbd_dev_refresh(rbd_dev);
> > +	rbd_dev_header_unwatch_sync(rbd_dev);
> > +	ret = rbd_dev_header_watch_sync(rbd_dev);
> > +	BUG_ON(ret); /* XXX: was the image deleted? can we be more graceful? */
> 
> Is this for debugging only? BUG()/BUG_ON() can kill the system. We
> normally use it for cases where proceeding might cause something like
> data corruption or where we want to catch programming bugs early on like
> passing incorrect args to a function.
> 
> The other caller if this function does not escalate like this function.
> Are you sure you need to here? The code below will not run if we BUG
> above, so if you did want to BUG, you would want to move the rbd_warn
> before it.

Thanks for the catch; this case is probably worse than rbd_warn() and not as bad as
BUG(). If the watch timed out or was disconnected and cannot be re-established, it's
likely the rbd image has been deleted out from under this client. We should probably
set the block device to a state where it just returns -EIO all the time at that point.

I have logic for that in my earlier patchset; I'll duplicate it here.

