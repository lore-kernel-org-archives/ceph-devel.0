From: Wido den Hollander <wido@42on.com>
Subject: Re: Zabbix plugin for ceph-mgr
Date: Tue, 27 Jun 2017 11:57:47 +0200 (CEST)
Message-ID: <2085831152.2838.1498557467669@ox.pcextreme.nl>
References: <1977676292.2763.1498503429028@ox.pcextreme.nl>
 <CALe9h7fTn10YGPSswZpe15aaWamdh1KekV24Ax=Umg7asi4Ehw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se06-out.mail.pcextreme.nl ([185.87.185.222]:37745 "EHLO
        se06-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751625AbdF0PmI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 11:42:08 -0400
In-Reply-To: <CALe9h7fTn10YGPSswZpe15aaWamdh1KekV24Ax=Umg7asi4Ehw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 27 juni 2017 om 11:42 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Mon, Jun 26, 2017 at 7:57 PM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > After looking at the documentation [0] on how to write a plugin for ceph-mgr I've been playing with the idea to create a Zabbix [1] plugin for ceph-mgr.
> >
> > Before I start writing one I'd like to check if I'm thinking in the right direction.
> >
> > Zabbix supports Items and Triggers. Triggers are based on Items's values. A Item could be from the type 'Trapper' where a application can simply send key=value pairs, for example:
> >
> > my.host.name ceph.health HEALTH_OK
> > my.host.name ceph.osd.up 499
> > my.host.name ceph.osd.in 498
> >
> > A simple ceph-mgr module could do:
> >
> > def serve(self):
> >   while True:
> >     send_data_to_zabbix()
> >     time.sleep(60)
> >
> > Now, would that be a sane plugin for ceph-mgr or is this something you shouldn't put in the mgr? To me it seems like a good place since it already has all the data present.
> 
> This is absolutely a sane thing to put in the mgr (and include in the
> main ceph tree) -- go for it!
> 

Ok, good! I'll take a stab at it and also include a Zabbix template (XML) so users can easily adopt it.

Sorry for posting this message a couple of times. Spamfilters were fighting me, greylisting and such, but suddenly the messages came through. My apologies!

Wido

> John
> 
> >
> > Wido
> >
> > [0]: http://docs.ceph.com/docs/master/mgr/plugins/
> > [1]: http://www.zabbix.com/
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
