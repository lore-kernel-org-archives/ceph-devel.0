From: Sage Weil <sage@newdream.net>
Subject: Re: why my cluster become unavailable
Date: Sat, 21 Nov 2015 09:49:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511210948270.24879@cobra.newdream.net>
References: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com> <CACJqLyazL_vCxpRGUGROgXN0reyJdUxL-i-OxseT5UV2cXu3pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54571 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbKURtD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Nov 2015 12:49:03 -0500
In-Reply-To: <CACJqLyazL_vCxpRGUGROgXN0reyJdUxL-i-OxseT5UV2cXu3pQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Libin Wu <hzwulibin@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 22 Nov 2015, Haomai Wang wrote:
> On Thu, Nov 19, 2015 at 11:26 PM, Libin Wu <hzwulibin@gmail.com> wrote:
> > Hi, cepher
> >
> > I have a cluster of 6 OSD server, every server has 8 OSDs.
> >
> > I out 4 OSDs on every server, then my client io is blocking.
> >
> > I reboot my client and then create a new rbd device, but the new
> > device also can't write io.
> >
> > Yeah, i understand that some data may lost as threee replicas of some
> > object were lost, but why the cluster become unavailable?
> >
> > There 80 incomplete pg and 4 down+incomplete pg.
> >
> > Any solution i could solve the problem?
> 
> Yes, if you doesn't have a special crushmap to control the data
> replcement policy, pg will lack of necessary metadata to boot. If need
> to readd outed osds or force remove pg which is incomplete(hope it's
> just a test).

Is min_size 2 or 1?  Reducing it to 1 will generally clear some of the 
incomplete pgs.  Just remember to raise it back to 2 after the cluster 
recovers.

sage
