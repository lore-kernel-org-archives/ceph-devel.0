From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH -next] rbd: fix error return code in
 rbd_dev_device_setup()
Date: Wed, 13 Aug 2014 20:50:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408132050280.12544@cobra.newdream.net>
References: <1407977768-15119-1-git-send-email-weiyj_lk@163.com> <53EC2207.1070409@ieee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58359 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaHNDuc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 23:50:32 -0400
In-Reply-To: <53EC2207.1070409@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: weiyj_lk@163.com, Yehuda Sadeh <yehuda@inktank.com>, Alex Elder <elder@kernel.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, ceph-devel@vger.kernel.org

Applied.  Thanks!

On Wed, 13 Aug 2014, Alex Elder wrote:

> On 08/13/2014 07:56 PM, weiyj_lk@163.com wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > Fix to return -ENOMEM from the workqueue alloc error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> This looks good to me.  Sorry I missed this when I first
> reviewed the workqueue code.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> 
> > ---
> >   drivers/block/rbd.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 623c841..f3be022 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -5088,8 +5087,10 @@ static int rbd_dev_device_setup(struct rbd_device
> > *rbd_dev)
> >   	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
> > 
> >   	rbd_dev->rq_wq = alloc_workqueue(rbd_dev->disk->disk_name, 0, 0);
> > -	if (!rbd_dev->rq_wq)
> > +	if (!rbd_dev->rq_wq) {
> > +		ret = -ENOMEM;
> >   		goto err_out_mapping;
> > +	}
> > 
> >   	ret = rbd_bus_add_dev(rbd_dev);
> >   	if (ret)
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
