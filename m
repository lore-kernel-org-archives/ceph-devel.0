From: Sage Weil <sage@inktank.com>
Subject: Re: rbd: assertion failure in rbd_img_obj_callback()
Date: Thu, 20 Jun 2013 08:45:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306200845070.27572@cobra.newdream.net>
References: <20130620104004.10574583@doppio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38525 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021Ab3FTPpa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 11:45:30 -0400
In-Reply-To: <20130620104004.10574583@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 20 Jun 2013, Andreas Bluemle wrote:
> Hi,
> 
> when working on a large rbd image, I am hitting an
> assertion failure in rbd kernel module; the
> assertion is in rbd_img_obj_callback()
> 
>             rbd_assert(img_request != NULL);
> 
> The test is a sequential write on an rbd
> image, format 1. The size of the image is 1 TByte,
> order is 22 (i.e. default object size).
> 
> The code of the rbd (and libceph) kernel modules is
> from kernel.org, 3.10-rc6, running on a 3.0.80-0.5 kernel.
> 
> The problem looks like the rbd_obj_request structure in
> question has been released already when processing of
> the reponse to the original request takes place.
> 
> Please find attached some more details on this problem.
> 
> Is this a known issue already?

Not yet. Do you mind opening an issue at tracker.ceph.com to track this?

Thanks!
sage
