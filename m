From: Sage Weil <sage@inktank.com>
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Thu, 25 Jul 2013 08:46:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307250845140.29435@cobra.newdream.net>
References: <fac262a41d5df6360f3106a38b9a6a79@2force.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35463 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402Ab3GYPqq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 11:46:46 -0400
In-Reply-To: <fac262a41d5df6360f3106a38b9a6a79@2force.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: peter@2force.nl
Cc: ceph-devel@vger.kernel.org

On Thu, 25 Jul 2013, peter@2force.nl wrote:
> We did not upgrade from bobtail to cuttlefish and are still seeing this issue.
> I posted this on the ceph-users mailinglist and I missed this thread (sorry!)
> so I didn't know.

That's interesting; a bobtail upgraded cluster was the only way I was able 
to reproduce it, but I'm also working with relatively short-lived clusters 
in a test environment so there may very well be a possibility I missed.  
Can you summarize what the lineage of your cluster is?  (What version was 
it installed with, and when was it upgraded and to what versions?)

> Either way, I also have an osd crashing after upgrading to 0.61.6. As said on
> the other list, I'm more than happy to share log files etc with you guys.

Will take a look.

Thanks!
sage


> 
> Thanks,
> 
> Peter
> 
> > This is fixed in the cuttlefish branch as of earlier this afternoon.  I've
> > spent most of the day expanding the automated test suite to include
> > upgrade combinations to trigger this and *finally* figured out that this
> > particular problem seems to surface on clusters that upgraded from bobtail
> > -> cuttlefish but not clusters created on cuttlefish.
> 
> > If you've run into this issue, please use the cuttlefish branch build for
> > now.  We will have a release out in the next day or so that includes this
> > and a few other pending fixes.
> 
> > I'm sorry we missed this one!  The upgrade test matrix I've been working
> > on today should catch this type of issue in the future.
> 
> > Thanks!
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
