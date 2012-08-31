From: Sage Weil <sage@inktank.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 09:10:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208310908520.1531@cobra.newdream.net>
References: <50409BDC.5010006@gmail.com> <5040D179.5000008@aktzero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47223 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab2HaQKn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:10:43 -0400
In-Reply-To: <5040D179.5000008@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: Xiaopong Tran <xiaopong.tran@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 31 Aug 2012, Andrew Thompson wrote:
> On 8/31/2012 7:11 AM, Xiaopong Tran wrote:
> > Hi,
> > 
> > Ceph storage on each disk in the cluster is very unbalanced. On each
> > node, the data seems to go to one or two disks, while other disks
> > are almost empty.
> > 
> > I can't find anything wrong from the crush map, it's just the
> > default for now. Attached is the crush map.
> 
> Have you been reweight-ing osds? I went round and round with my cluster a few
> days ago reloading different crush maps only to find that it re-injecting a
> crush map didn't seem to overwrite reweights.
> 
> Take a look at `ceph osd tree` to see if the reweight column matches the
> weight column.

Note that the ideal situation is for reweight to be 1, regardless of what 
the crush weight is.  If you find the utilizations are skewed, I would 
look for other causes before resorting to reweight-by-utilization; it is 
meant to adjust the normal statistical variation you expect from a 
(pseudo)random placement, but if the variance is high there is likely 
another cause.

sage

> 
> Note: I'm new at this. This is my experience only, with 0.48.1, and may not be
> entirely correct.
> 
> -- 
> Andrew Thompson
> http://aktzero.com/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
