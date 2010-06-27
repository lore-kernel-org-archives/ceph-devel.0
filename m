From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH] rbd: add queuing delay
Date: Sun, 27 Jun 2010 23:05:00 +0200
Message-ID: <20100627210500.GB1568@chb-desktop>
References: <AANLkTilzf9GqS4Nqyz02IH59Wyb28gy5ojgxDU78CWsK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62361 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0F0VFF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jun 2010 17:05:05 -0400
Received: by fxm14 with SMTP id 14so290559fxm.19
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jun 2010 14:05:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilzf9GqS4Nqyz02IH59Wyb28gy5ojgxDU78CWsK@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> >> > 10.06.20 22:10:07.337108 b67dcb70 client4136.objecter =A0pg 3.43=
7e on [0] is laggy: 33
> >> > 10.06.20 22:10:07.337708 b67dcb70 client4136.objecter =A0pg 3.25=
53 on [0] is laggy: 19
> >> > [...]
> >> >
> >> > Everything is working fine, though. I think that the large numbe=
r of
> >> > queued requests is the cause for this behaviour and I would prop=
ose to
> >> > delay futher requests (see attached patch).
> >>
> >> It seems that the osd is lagging behind. The usleep might work for=
 you
> >> as you avoid the pressure, but it's also somewhat random and will
> >> probably hurt performance on other setups. I'd rather see a
> >> configurable solution that lets you specify a total in-flight byte=
s or
> >> some other resizable window scheme.
> >
> > I'm not sure if I understand what "lagging behind" means. If the in=
-flight
> > bytes are the sum of all requests in the queue, a solution could lo=
ok like
> > this (although it isn't configurable yet).
> >
> The problem is that the sleep will lead to having the osd being
> underutilized in certain configurations. What you probably need here
> is some mechanism that keeps feeding the osd with pending data
> whenever old data has been cleared. E.g., make use of the async
> callbacks to wake up the sender whenever the amount of pending
> outgoing data has fell below some threshold.

Do you mean replacing the sleep with something like a futex?=20

When thinking about this a little bit more I'm not sure if doing this i=
n
the client is the right way to handle this. The client has no way to=20
judge if the delay is caused by a general high load or by a single slow=
 osd.
Maybe it would be better if libraos could notify the client to slow dow=
n?

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
