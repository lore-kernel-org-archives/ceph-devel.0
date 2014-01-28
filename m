From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Re: RADOS + deep scrubbing performance issues in production
 environment
Date: Tue, 28 Jan 2014 20:13:06 +0200
Message-ID: <20140128181306.GC11532@philipgian-mac>
References: <20140127151321.GD26390@philipgian-mac>
 <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
 <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:29363 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754970AbaA1SNK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jan 2014 13:13:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

On Mon, Jan 27, 2014 at 10:45:48AM -0800, Sage Weil wrote:
> There is also 
> 
>  ceph osd set noscrub
> 
> and then later
> 
>  ceph osd unset noscrub
> 
> I forget whether this pauses an in-progress PG scrub or just makes it stop 
> when it gets to the next PG boundary.
> 
> sage

I bumped into those settings but I couldn't find any documentation about them.
When I first tried them, they didn't do anything immediately, so I thought they
weren't the answer. After your mention, I tried them again, and after a while
the deep-scrubbing stopped. So I'm guessing they stop scrubbing on the next PG
boundary.

I see from this thread and others before, that some people think it is a spindle
issue. I'm not sure that it is just that. Replicating it to an idle cluster that
can do more than 250MiB/seconds and pausing for 4-5 seconds on a single request,
sounds like an issue by itself. Maybe there is too much locking or not enough
priority to the actual I/O ? Plus, that idea of throttling deep scrubbing based
on the iops sounds appealing.

Kind Regards,
-- 
Filippos
<philipgian@grnet.gr>
