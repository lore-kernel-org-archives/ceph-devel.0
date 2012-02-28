From: Sage Weil <sage@newdream.net>
Subject: Re: Recommended number of pools, one Q. ever wanted to ask
Date: Tue, 28 Feb 2012 09:14:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202280911100.19562@cobra.newdream.net>
References: <4F4C9FE9.7000808@filoo.de> <4F4CA17F.4070007@widodh.nl>
 <4F4CA380.2010004@filoo.de> <4F4CF7EF.7010505@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58681 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082Ab2B1RPO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 12:15:14 -0500
In-Reply-To: <4F4CF7EF.7010505@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, ceph-devel@vger.kernel.org

On Tue, 28 Feb 2012, Wido den Hollander wrote:
> Hi,
> 
> On 02/28/2012 10:50 AM, Oliver Francke wrote:
> > Well,
> > 
> > On 02/28/2012 10:42 AM, Wido den Hollander wrote:
> > > Hi,
> > > 
> > > On 02/28/2012 10:35 AM, Oliver Francke wrote:
> > > > Hi *,
> > > > 
> > > > well, there was once a comment on our layout in means of "too many
> > > > pools".
> > > > Our setup is to have a pool per customer, to simplify the view on used
> > > > storage
> > > > capacity.
> > > > So, if we have - in a couple of months, we hope - more then some hundred
> > > > customers, this setup was not recommended, cause the whole system is not
> > > > designed for handling that. ( Sage)
> > > > 
> > > > What does "not recommended" mean? Is it, that per OSD the used memory
> > > > will be
> > > > too high?
> > > 
> > > Yes. Every new pool you create will consume some memory on the OSD. So
> > > if you start creating a lot of pools, you will also start consuming
> > > more and more memory.
> > > 
> > > I haven't followed this lately, but that is the current information I
> > > have.
> > > 
> > > The number of objects in a pool is also not a problem, you can have
> > > millions without any issues. It's the number of pools which will haunt
> > > you later on.
> > 
> > thnx for the quick reply, so if we can imagine, that the number of pool
> > per OSD is
> > the limiting factor, we shall not have more than let's say ~100, means,
> > we shall be
> > safe.
> 
> IIRC the number of pools is a problem, but for every pool you have a number of
> Placement Groups (PG's) (pg_num). Each PG eats a small amount of memory.
> 
> As the number of OSD's increases you also want to increase the number of PG's,
> this improves performance.
> 
> But as you have more PG's per pool, you start increasing memory usage. Now,
> PG's will be spread out over your OSD's, but it could still increase the
> usage.
> 
> This probably won't be a problem with 500 pools, or maybe a thousand pools
> (but it could), but going above that could be a problem.

Right.

Oliver, just to clarify your requirements... is it just that you want to 
be able to easily measure the amount of used storage per customer, and the 
pools let you do that?  Are there other requirements (independent rbd 
image namespaces, security) that are important?

We've talked some about adding the ability to create separate namespace 
inside each pool, so that we don't have a single abstraction (pool) that 
combines both placement and namespace/accounting in an awkward way.  
Before we move forward with any of that it would be helpful to understand 
exactly what people want/need.

Thanks!
sage


> 
> Wido
> 
> > 
> > > 
> > > Wido
> > 
> > best regards,
> > 
> > Oliver.
> > 
> > > 
> > > > Is this a general performance issue?
> > > > 
> > > > Well, if we read "pool", this gave us the basic idea/concept to put all
> > > > per-customers
> > > > data into it.
> > > > 
> > > > Please sched some light in 8-)
> > > > 
> > > > Kind regards,
> > > > 
> > > > Oliver.
> > > > 
> > > 
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
