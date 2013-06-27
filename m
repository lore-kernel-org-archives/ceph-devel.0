From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: send snapshot context with writes
Date: Thu, 27 Jun 2013 05:54:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306270554090.14059@cobra.newdream.net>
References: <1372277199-9774-1-git-send-email-josh.durgin@inktank.com> <51CC32B3.8010907@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44204 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab3F0MzA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 08:55:00 -0400
In-Reply-To: <51CC32B3.8010907@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <alex.elder@linaro.org>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Hi Alex!

On Thu, 27 Jun 2013, Alex Elder wrote:
> On 06/26/2013 03:06 PM, Josh Durgin wrote:
> > Sending the right snapshot context with each write is required for
> > snapshots to work. Due to the ordering of calls, the snapshot context
> > is never set for any requests. This causes writes to the current
> > version of the image to be reflected in all snapshots, which are
> > supposed to be read-only.
> > 
> > This happens because rbd_osd_req_format_write() sets the snapshot
> > context based on obj_request->img_request. At this point, however,
> > obj_request->img_request has not been set yet, to the snapshot context
> > is set to NULL. Fix this by moving rbd_img_obj_request_add(), which
> > sets obj_request->img_request, before the osd request formatting
> > calls.
> > 
> > This resolves:
> >     http://tracker.ceph.com/issues/5465
> 
> That appears to be the wrong bug number.
> 
> One fix needed for commenting style (don't use "//"), but otherwise
> this looks good.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Looks like the comments were already fixed up to the commit that landed 
in the tree.  I've added your reviewed-by, though.

Thanks!
sage

> 
> > Reported-by: Karol Jurak <karol.jurak@gmail.com>
> > Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> > ---
> >  drivers/block/rbd.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index d79831a..4b03d02 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -2266,13 +2266,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
> >  					obj_request->pages, length,
> >  					offset & ~PAGE_MASK, false, false);
> >  
> > +		// writes get the snapc from the img_request, so
> > +		// set it before formatting the osd_req
> 
> Don't use C++ comments, use /* */.
> 
> > +		rbd_img_obj_request_add(img_request, obj_request);
> >  		if (write_request)
> >  			rbd_osd_req_format_write(obj_request);
> >  		else
> >  			rbd_osd_req_format_read(obj_request);
> >  
> >  		obj_request->img_offset = img_offset;
> > -		rbd_img_obj_request_add(img_request, obj_request);
> >  
> >  		img_offset += length;
> >  		resid -= length;
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
