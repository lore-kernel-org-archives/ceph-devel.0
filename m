From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH 0/3] patches for rbd
Date: Wed, 12 Mar 2014 16:12:58 +0800
Message-ID: <20140312081258.GA19101@x230>
References: <1394598285-17225-1-git-send-email-lucienchao@gmail.com>
 <531FF070.9000803@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:37966 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaCLIsM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 04:48:12 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so786655pbb.40
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 01:48:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <531FF070.9000803@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On Wed, Mar 12, 2014 at 12:28:16AM -0500, Alex Elder wrote:
> On 03/11/2014 11:24 PM, Guangliang Zhao wrote:

Hi Alex,

Thanks very much for the reviews, version 2 would coming soon.

> > Hi,
> > 
> > I am sorry that didn't notice Jean-Tiare's mail at all, just sage's
> > reminds me. 
> > 
> > There are 3 patches, the first is optimization for rbd writing, the
> > remaining two are support for rbd discard. If you have completed the 
> > discard things, just ignore them.
> > 
> > Guangliang Zhao (3):
> >   rbd: skip the copyup when an entire object writing
> >   rbd: extend the operation type
> >   rbd: add discard support for rbd
> > 
> >  drivers/block/rbd.c |  190 +++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 154 insertions(+), 36 deletions(-)
> > 
> 
> Oh, one more thing.  I reviewed only the code changes presented
> here.  I did not go back to walk through the discard call chains
> to make sure you're doing things correctly.  I'm just assuming
> that, and based on that, I think your changes look overall correct
> to me.
> 
> 					-Alex

-- 
Best regards,
Guangliang
