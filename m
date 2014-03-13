From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH 2/3 v2] rbd: extend the operation type
Date: Thu, 13 Mar 2014 13:32:19 +0800
Message-ID: <20140313053219.GA8759@x230>
References: <1394680896-8554-1-git-send-email-lucienchao@gmail.com>
 <1394680896-8554-2-git-send-email-lucienchao@gmail.com>
 <53213868.1010808@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:34299 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaCMFcg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Mar 2014 01:32:36 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so595411pbc.4
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 22:32:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53213868.1010808@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: ceph-devel@vger.kernel.org

On Wed, Mar 12, 2014 at 11:47:36PM -0500, Alex Elder wrote:
> On 03/12/2014 10:21 PM, Guangliang Zhao wrote:
> > It could only handle the read and write operations now,
> > extend it for the coming discard support.
> 
> Wow, it looks like you took all of my suggestions.
> 
> This looks good.

Good comment again :-)

Thanks.

> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> > ---
> >  drivers/block/rbd.c |   96 +++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 63 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 2d48858..fc5bf37 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -209,6 +209,11 @@ enum obj_request_type {
> >  	OBJ_REQUEST_NODATA, OBJ_REQUEST_BIO, OBJ_REQUEST_PAGES
> >  };
> >  
> 
> . . .
> 

-- 
Best regards,
Guangliang
