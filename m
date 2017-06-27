From: John Spray <jspray@redhat.com>
Subject: Re: Zabbix plugin for ceph-mgr
Date: Tue, 27 Jun 2017 10:42:51 +0100
Message-ID: <CALe9h7fTn10YGPSswZpe15aaWamdh1KekV24Ax=Umg7asi4Ehw@mail.gmail.com>
References: <1977676292.2763.1498503429028@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35737 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdF0JnN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 05:43:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id w126so19327926wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 02:43:12 -0700 (PDT)
In-Reply-To: <1977676292.2763.1498503429028@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 26, 2017 at 7:57 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> After looking at the documentation [0] on how to write a plugin for ceph-mgr I've been playing with the idea to create a Zabbix [1] plugin for ceph-mgr.
>
> Before I start writing one I'd like to check if I'm thinking in the right direction.
>
> Zabbix supports Items and Triggers. Triggers are based on Items's values. A Item could be from the type 'Trapper' where a application can simply send key=value pairs, for example:
>
> my.host.name ceph.health HEALTH_OK
> my.host.name ceph.osd.up 499
> my.host.name ceph.osd.in 498
>
> A simple ceph-mgr module could do:
>
> def serve(self):
>   while True:
>     send_data_to_zabbix()
>     time.sleep(60)
>
> Now, would that be a sane plugin for ceph-mgr or is this something you shouldn't put in the mgr? To me it seems like a good place since it already has all the data present.

This is absolutely a sane thing to put in the mgr (and include in the
main ceph tree) -- go for it!

John

>
> Wido
>
> [0]: http://docs.ceph.com/docs/master/mgr/plugins/
> [1]: http://www.zabbix.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
