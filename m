From: Sage Weil <sweil@redhat.com>
Subject: Re: mgr balancer module
Date: Sun, 30 Jul 2017 18:12:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707301808130.5035@piezo.novalocal>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal> <43A8CF62-77CC-4804-8627-2DB86ACB52B9@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754193AbdG3SMD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 30 Jul 2017 14:12:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5F1FC2BA0
        for <ceph-devel@vger.kernel.org>; Sun, 30 Jul 2017 18:12:02 +0000 (UTC)
In-Reply-To: <43A8CF62-77CC-4804-8627-2DB86ACB52B9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 28 Jul 2017, Douglas Fuller wrote:
> 
> > On Jul 27, 2017, at 11:51 PM, Sage Weil <sage@redhat.com> wrote:
> > 
> > The basics:
> > 
> >  ceph balancer mode <none,upmap,crush-compat,...>
> > 	- which optimiation method to use
> >  ceph balancer on
> > 	- run automagically
> >  ceph balancer off
> > 	- stop running automagically
> 
> So this would leave the last CRUSH map installed by the balancer in 
> place? Or would it restore the CRUSH map that was in place before 
> applying running the balancer? If the former (which seems more 
> reasonable, perhaps), is there a command to revert to the last 
> user-applied map?

I haven't thought about a revert.  I don't think it will be very practical 
because the balancer will make small adjustments to weights over time, but 
mixed in with that may be various other changes due to cluster 
expansion/contraction or admin changes or whatever.

It's probably worth mentioning that the balancer wouldn't actually 
export/import crush maps.  Instead, once it decides what weight 
adjustments to make, it will just issue normal monitor commands to 
initiate those changes.
  
> >  ceph balancer status
> > 	- see curent mode, any plans, whehter it's enabled
> > 
> > The useful bits:
> > 
> >  ceph balancer eval
> > 	- show analysis of current data distribution
> >  ceph balancer optimize <plan>
> > 	- create a new plan to optimize named <plan> based on the current 
> > 	  mode
> > 	- ceph balancer status will include a list of plans in memory 
> >          (these currently go away if ceph-mgr daemon restarts)
> >  ceph balancer eval <plan>
> > 	- analyse resulting distribution if plan is executed
> >  ceph balancer show <plan>
> > 	- show what the plan would do (basically a dump of cli commands to 
> > 	  adjust weights etc)
> >  ceph balancer execute <plan>
> > 	- execute plan (and then discard it)
> >  ceph balancer rm <plan>
> > 	- discard plan
> > 
> > A normal user will be expected to just set the mode and turn it on:
> > 
> >  ceph balancer mode crush-compat
> >  ceph balancer on
> > 
> > An advanced user can play with different optimizer modes etc and see what 
> > they will actually do before making any changes to their cluster.
> > 
> > Does this seem like a reasonable direction for an operator interface?
> 
> I think it makes sense.
> 
> Possibly unrelated: is there a way to adjust the rate of map changes 
> manually or do we just expect the balancer to handle that automagically?

There will be a single threshold, max_misplaced, that controls what 
fraction of the PGs/objects can be misplaced at once.  Default will be 
something like 3%.

I think this is equivalent to what people are after when they do gradual 
reweighting over time?

sage
