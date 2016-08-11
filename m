From: Wido den Hollander <wido@42on.com>
Subject: Re: Delayed start of OSDs with systemd to prevent slowdowns
Date: Thu, 11 Aug 2016 12:53:54 +0200 (CEST)
Message-ID: <1156162690.2373.1470912834230@ox.pcextreme.nl>
References: <97824899.2313.1470818261025@ox.pcextreme.nl>
 <CABZ+qqnX0k_0SvoM3bTLAL0q2z-pmGt4AnUpsd126vKOFnZU9Q@mail.gmail.com>
 <CABZ+qq=S4ay1475BuR2AD2qhYmq279oKazGAKJG9ti-9pwPzug@mail.gmail.com>
 <CABZ+qqmNi63on6Gipi5uhnL1X9e_erTwXHZt6cSw5XfkmoVaYA@mail.gmail.com>
 <CABZ+qqnH0EK0bYc0xm6329+3WGk81GKb1OFR_9+No05bsAB5qg@mail.gmail.com>
 <CABZ+qqmizdT9mpft9TkT87ygS0jJv=9NBipFVuS37dW4a2JvTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:38322 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcHKKx6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 06:53:58 -0400
In-Reply-To: <CABZ+qqmizdT9mpft9TkT87ygS0jJv=9NBipFVuS37dW4a2JvTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 11 augustus 2016 om 1:05 schreef Dan van der Ster <dan@vanderster.com>:
> 
> 
> Hi Wido,
> 
> I can't help you with the systemd foo, but I have two quick remarks ...
> 

Nobody seems to be able :) systemd is new to everybody.

> 1. I've always thought that this was a nice feature of systemd... To get
> the osds booted and online as quickly as possible. And we've not seen the
> peering issues you described.
> 

Yes, it's a nice feature. But these machines have 24 OSDs on a Dual Xeon E5 and the have a difficult time in coming up.

Have to note that it's a mixed 0.94.7 <> 10.2.2 cluster, so it might be something there.

> 2. The crush weight change shouldn't cause problems, if the weight isn't
> actually changing. IIRC it shouldn't even change the osdmap if the value
> doesn't change.
> 

True, my bad indeed. That doesn't trigger a change, but it keeps the MONs busy however.

Wido

> Cheers, Dan
> 
> 
> On 10 Aug 2016 11:01 a.m., "Wido den Hollander" <wido@42on.com> wrote:
> >
> > Hi,
> >
> > Currently with the systemd design a booting system will start all OSDs at
> the same time. This means that a cluster suddenly gets a bunch of CRUSH
> updates (if update on start is enabled), booting OSDs and PGs which go into
> peering state.
> >
> > My systemd-foo isn't that good, but I was wondering if there is a way to
> modify ceph-osd.target in such a way that it doesn't start all the OSDs in
> parallel?
> >
> > I would like 1 or maybe 2 OSDs to start at the same time with a delay of
> 120 seconds in between. This way the boot will take longer, but the impact
> on the cluster will be less.
> >
> > Any ideas on how we might achieve this with systemd?
> >
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
