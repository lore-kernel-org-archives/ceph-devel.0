From: Sage Weil <sage@newdream.net>
Subject: Re: why my cluster become unavailable (min_size of pool)
Date: Thu, 26 Nov 2015 05:30:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511260528330.12118@cobra.newdream.net>
References: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com> <CACJqLyazL_vCxpRGUGROgXN0reyJdUxL-i-OxseT5UV2cXu3pQ@mail.gmail.com> <alpine.DEB.2.00.1511210948270.24879@cobra.newdream.net> <5652651C.8040902@gmail.com>
 <5656BA98.4090301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52196 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbKZNat (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Nov 2015 08:30:49 -0500
In-Reply-To: <5656BA98.4090301@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hzwulibin <hzwulibin@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 26 Nov 2015, hzwulibin wrote:
> Hi, Sage
> 
> I has a question about min_size of pool.
> 
> The default value of min_size is 2, but in this setting, when two OSDs 
> are down(mean two replicas lost) at same time, the IO will be blocked. 
> We want to set the min_size to 1 in our production environment as we 
> think it's normal case when two OSDs are down(sure on different host) at 
> same time.
> 
> So is there anypotential problem of this setting?

min_size = 1 is okay, but be aware that it will increase the risk of a 
situation of a pg history like

 epoch 10: osd.0, osd.1, osd.2
 epoch 11: osd.0   (1 and 2 down)
 epoch 12: - (osd.0 fails hard)
 epoch 13: osd.1 osd.2

i.e., a pg is serviced by a single osd for some period (possibly very 
short) and then fails permanently, and any writes during that period are 
*only* stored on that osd.  It'll require some manual recovery to get past 
it (mark that osd as lost, and accept that you may have lost some recent 
writes to the data).

sage



 

> 
> We use 0.80.10 version.
> 
> Thanks!
> 
> 
> ------------------				 
> hzwulibin
> 2015-11-26
> 
> -------------------------------------------------------------
> ????"hzwulibin"<hzwulibin@gmail.com>
> ?????2015-11-23 09:00
> ????Sage Weil,Haomai Wang
> ???ceph-devel
> ???Re: why my cluster become unavailable
> 
> Hi, Sage
> 
> Thanks! Will try it when next testing!
> 
> ------------------				 
> hzwulibin
> 2015-11-23
> 
> -------------------------------------------------------------
> ????Sage Weil <sage@newdream.net>
> ?????2015-11-22 01:49
> ????Haomai Wang
> ???Libin Wu,ceph-devel
> ???Re: why my cluster become unavailable
> 
> On Sun, 22 Nov 2015, Haomai Wang wrote:
> > On Thu, Nov 19, 2015 at 11:26 PM, Libin Wu <hzwulibin@gmail.com> wrote:
> > > Hi, cepher
> > >
> > > I have a cluster of 6 OSD server, every server has 8 OSDs.
> > >
> > > I out 4 OSDs on every server, then my client io is blocking.
> > >
> > > I reboot my client and then create a new rbd device, but the new
> > > device also can't write io.
> > >
> > > Yeah, i understand that some data may lost as threee replicas of some
> > > object were lost, but why the cluster become unavailable?
> > >
> > > There 80 incomplete pg and 4 down+incomplete pg.
> > >
> > > Any solution i could solve the problem?
> > 
> > Yes, if you doesn't have a special crushmap to control the data
> > replcement policy, pg will lack of necessary metadata to boot. If need
> > to readd outed osds or force remove pg which is incomplete(hope it's
> > just a test).
> 
> Is min_size 2 or 1?  Reducing it to 1 will generally clear some of the 
> incomplete pgs.  Just remember to raise it back to 2 after the cluster 
> recovers.
> 
> sage
> 
> 
> 
