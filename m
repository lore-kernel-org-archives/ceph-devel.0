From: Sage Weil <sweil@redhat.com>
Subject: Re: Weekly performance meeting
Date: Thu, 25 Sep 2014 12:41:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409251237210.16795@cobra.newdream.net>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net> <20140925192728.GA22139@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41361 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaIYTli (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 15:41:38 -0400
In-Reply-To: <20140925192728.GA22139@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Somnath.Roy@sandisk.com" <Somnath.Roy@sandisk.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, "Allen.Samuels@sandisk.com" <Allen.Samuels@sandisk.com>, "PVonStamwitz@us.fujitsu.com" <PVonStamwitz@us.fujitsu.com>, "xinxin.shu@intel.com" <xinxin.shu@intel.com>, "haomaiwang@gmail.com" <haomaiwang@gmail.com>, "s.priebe@profihost.ag" <s.priebe@profihost.ag>, "xiaoxi.chen@intel.com" <xiaoxi.chen@intel.com>, "milosz@adfin.com" <milosz@adfin.com>, "zhiqiang.wang@intel.com" <zhiqiang.wang@intel.com>, "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>, "gdror@mellanox.com" <gdror@mellanox.com>, "vuhuong@mellanox.com" <vuhuong@mellanox.com>, "mark.nelson@inktank.com" <mark.nelson@inktank.com>

Hi Dieter,

On Thu, 25 Sep 2014, Kasper Dieter wrote:
> Hi Sage,
> 
> I'm definitely interested in joining this weekly call starting Oct 1st.
> Thanks for this initiative!

Great!  Please add these notes to

	http://pad.ceph.com/p/performance_weekly

> Especially I'm interested in:
> - how can we reduce the number of threads in the system 
>   -- including to avoid the context switches in between
>   -- including to avoid the queues and locks in between

You should take a look at Haomai's AsyncMessenger implementation he posted 
a few weeks back.  I'm not sure how much testing it's seen, but it 
essentially refactors SimpleMessenger into a state machine and uses 
libevent to schedule work.

> - how we can reduce the number of lines of code 
>   -- including the multiple system calls for each IO

I have some planned changes to ObjectStore::Transaction that make it 
handle-based.  This will make it easier to cache and avoid lots of dup 
lookups (and lay some of the groundwork for the proposed KeyFileStore).

> - how we can introduce a high efficient timestamp collection of the most important FN check-points
> 	(see for example the attached file)
> 	to measure the change and effect of our actions

I think most of us are looking to LTTng or systemtap for this.  You should 
also check out the thread '?nstrumenting RADOS with Zipkin + LTTng' from  
several weeks ago for a pretty promising tracing strategy.

sage



> 
> Best Regards,
> -Dieter
> 
> 
> On Thu, Sep 25, 2014 at 08:27:00PM +0200, Sage Weil wrote:
> > Hi everyone,
> > 
> > A number of people have approached me about how to get more involved with 
> > the current work on improving performance and how to better coordinate 
> > with other interested parties.  A few meetings have taken place offline 
> > with good results but only a few interested parties were involved.
> > 
> > Ideally, we'd like to move as much of this dicussion into the public 
> > forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always 
> > sufficient, however.  I'd like to also set up a regular weekly meeting 
> > using google hangouts or bluejeans so that all interested parties can 
> > share progress.  There are a lot of things we can do during the Hammer 
> > cycle to improve things but it will require some coordination of effort.
> > 
> > Among other things, we can discuss:
> > 
> >  - observed performance limitations
> >  - high level strategies for addressing them
> >  - proposed patch sets and their performance impact
> >  - anything else that will move us forward
> > 
> > One challenge is timezones: there are developers in the US, China, Europe, 
> > and Israel who may want to join.  As a starting point, how about next 
> > Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's
> > 
> >   8:00 (PDT, California)
> >  15:00 (UTC)
> >  18:00 (IDT, Israel)
> >  23:00 (CST, China)
> > 
> > That is surely not the ideal time for everyone but it can hopefully be a 
> > starting point.
> > 
> > I've also created an etherpad for collecting discussion/agenda items at
> > 
> > 	http://pad.ceph.com/p/performance_weekly
> > 
> > Is there interest here?  Please let everyone know if you are actively 
> > working in this area and/or would like to join, and update the pad above 
> > with the topics you would like to discuss.
> > 
> > Thanks!
> > sage
> 
