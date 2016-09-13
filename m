From: Haomai Wang <haomai@xsky.com>
Subject: Re: msgr2 protocol
Date: Tue, 13 Sep 2016 09:35:18 +0800
Message-ID: <CACJqLyZOh=scFqW2LyWMQ3h9LND0mXkaycs=38XfNjJKQwWryg@mail.gmail.com>
References: <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com> <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
 <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com> <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
 <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com> <20160610190510.GA18999@degu.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101658530.6221@cpach.fuggernut.com> <20160611230503.GA18268@degu.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606121950490.32559@cpach.fuggernut.com> <CACJqLyax_SXEZp3vA2_wR+CdwKOo2Re=SsK2xfXqmXjz9d8iNw@mail.gmail.com>
 <alpine.DEB.2.11.1609092112171.19761@piezo.us.to> <CACJqLyYwKZ5_1OHR_5=+mr=1ED2Nt34x4TB29j5dE1D+NjzFpg@mail.gmail.com>
 <CACJqLybA-cArcno2oS0AZx238hrV64PZyK9fFXdCBuVHKQQP3Q@mail.gmail.com>
 <alpine.DEB.2.11.1609111703430.19761@piezo.us.to> <CACJqLybGs1paSFu4zBEFW8dhYVBfDHSEzY3RwKGvDA03wdiF2A@mail.gmail.com>
 <alpine.DEB.2.11.1609121319270.19761@piezo.us.to> <CAJ4mKGZYTr4D1dXa8aEt9muNwrOA9DsxRzWVf0=zWH44VZ-Onw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0102.outbound.protection.outlook.com ([104.47.124.102]:23584
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751673AbcIMBff (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 21:35:35 -0400
Received: by mail-vk0-f52.google.com with SMTP id 16so140726304vko.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 18:35:27 -0700 (PDT)
In-Reply-To: <CAJ4mKGZYTr4D1dXa8aEt9muNwrOA9DsxRzWVf0=zWH44VZ-Onw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Marcus Watts <mwatts@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 13, 2016 at 8:03 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Sep 12, 2016 at 6:21 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Mon, 12 Sep 2016, Haomai Wang wrote:
>>> This way is ok to me. So another change is double messenger
>>> instances(to v1 and v2) or let each messenger support multi binding
>>> addresses(this may need to refactor messenger interface).
>>
>> Yeah.  I'm guessing we'll want to have an entity_addrvec_t with address
>> types mapped to different Messenger implementations (e.g., xio), so we'll
>> wan to allow multiple instance eventually.  But we'll also just want to
>> allow multiple binding (v1 + v2, or ipv4 + ipv6).  :/
>
> Hmm, is that really necessary? It seems a fair bit more complicated
> and I'm not sure there's much payoff given the connection types.
> Long-term the only doubled connection I can see being needed is the
> client one; OSD cluster messengers will only be required to bind twice
> during the initial upgrade period.
>
> Put another way, what's the advantage of supporting two different
> protocols within one messenger? That just sounds like a disaster

I don't think this version upgrade will happen right now. I guess
there will be a version to switch to async msgr, then we consider to
upgrade msgr version really.

> waiting to happen, and not one worth risking for slightly reducing the
> thread count on AsyncMessenger (especially with users coming from the
> SimpleMessenger).

Maybe you like aonther msgr like asyncmessengerv2? instead of the same
msgr type. From my view, msgrv2 will reduce packet per message and
prepare for the other new features.

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
