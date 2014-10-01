From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: Weekly performance meeting
Date: Wed, 1 Oct 2014 11:30:58 +0200
Message-ID: <20141001113058.59b11ac3@doppio>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
	<20140925192728.GA22139@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:39904 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaJAJvM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 05:51:12 -0400
In-Reply-To: <20140925192728.GA22139@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Somnath.Roy@sandisk.com" <Somnath.Roy@sandisk.com>, "Allen.Samuels@sandisk.com" <Allen.Samuels@sandisk.com>, "PVonStamwitz@us.fujitsu.com" <PVonStamwitz@us.fujitsu.com>, "xinxin.shu@intel.com" <xinxin.shu@intel.com>, "haomaiwang@gmail.com" <haomaiwang@gmail.com>, "s.priebe@profihost.ag" <s.priebe@profihost.ag>, "xiaoxi.chen@intel.com" <xiaoxi.chen@intel.com>, "milosz@adfin.com" <milosz@adfin.com>, "zhiqiang.wang@intel.com" <zhiqiang.wang@intel.com>, "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>, "gdror@mellanox.com" <gdror@mellanox.com>, "vuhuong@mellanox.com" <vuhuong@mellanox.com>, "mark.nelson@inktank.com" <mark.nelson@inktank.com>

Hi,

to illustrate the "number of threads issue":
we had setup a cluster with 11 storage nodes and a total of 375 osd's,
i.e. like 30 to 40 osd's per storage node.
Looking at one of the storage nodes when the
cluster is idle (no client I/O, no scrub) we encounter

- up to 82.000 ceph-osd threads
  or approx. 2.000 threads per osd

- a CPU load of 20%:
  this is on a storage node with 12 CPU cores
  which means that more than 2 CPU cores are busy 

- a network load of almost 50.000 packets/second:
  separate cluster and public network,
  12.000 packets per second on each network interface,
  outgoing and incoming (heartbeats?)


Regards

Andreas Bluemle


On Thu, 25 Sep 2014 21:27:28 +0200
Kasper Dieter <dieter.kasper@ts.fujitsu.com> wrote:

> Hi Sage,
> 
> I'm definitely interested in joining this weekly call starting Oct
> 1st. Thanks for this initiative!
> 
> Especially I'm interested in:
> - how can we reduce the number of threads in the system 
>   -- including to avoid the context switches in between
>   -- including to avoid the queues and locks in between
> - how we can reduce the number of lines of code 
>   -- including the multiple system calls for each IO
> - how we can introduce a high efficient timestamp collection of the
> most important FN check-points (see for example the attached file)
> 	to measure the change and effect of our actions
> 
> Best Regards,
> -Dieter
> 
> 
> On Thu, Sep 25, 2014 at 08:27:00PM +0200, Sage Weil wrote:
> > Hi everyone,
> > 
> > A number of people have approached me about how to get more
> > involved with the current work on improving performance and how to
> > better coordinate with other interested parties.  A few meetings
> > have taken place offline with good results but only a few
> > interested parties were involved.
> > 
> > Ideally, we'd like to move as much of this dicussion into the
> > public forums: ceph-devel@vger.kernel.org and #ceph-devel.  That
> > isn't always sufficient, however.  I'd like to also set up a
> > regular weekly meeting using google hangouts or bluejeans so that
> > all interested parties can share progress.  There are a lot of
> > things we can do during the Hammer cycle to improve things but it
> > will require some coordination of effort.
> > 
> > Among other things, we can discuss:
> > 
> >  - observed performance limitations
> >  - high level strategies for addressing them
> >  - proposed patch sets and their performance impact
> >  - anything else that will move us forward
> > 
> > One challenge is timezones: there are developers in the US, China,
> > Europe, and Israel who may want to join.  As a starting point, how
> > about next Wednesday, 15:00 UTC?  If I didn't do my tz math wrong,
> > that's
> > 
> >   8:00 (PDT, California)
> >  15:00 (UTC)
> >  18:00 (IDT, Israel)
> >  23:00 (CST, China)
> > 
> > That is surely not the ideal time for everyone but it can hopefully
> > be a starting point.
> > 
> > I've also created an etherpad for collecting discussion/agenda
> > items at
> > 
> > 	http://pad.ceph.com/p/performance_weekly
> > 
> > Is there interest here?  Please let everyone know if you are
> > actively working in this area and/or would like to join, and update
> > the pad above with the topics you would like to discuss.
> > 
> > Thanks!
> > sage



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
