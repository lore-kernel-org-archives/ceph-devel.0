From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: v0.27 released
Date: Mon, 25 Apr 2011 19:05:44 +0200
Message-ID: <BANLkTincA2E++BG0RaV1G0URoYCqed9BWw@mail.gmail.com>
References: <Pine.LNX.4.64.1104232136330.9549@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42418 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab1DYRFq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Apr 2011 13:05:46 -0400
Received: by wwk4 with SMTP id 4so1501111wwk.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Apr 2011 10:05:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104232136330.9549@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

=2E..
> For v0.28 we're focusing on the OSD cluster, radosgw, and continuing =
with
> the MDS clustering fixes. =A0Sam and Josh are working on a refactor i=
n the
> OSD peering code that will make peering more understandable, verifiab=
le,
> and (we hope) less buggy.

Im using ceph since a while an follow the mailinglist since more than a=
 year.
In the same project as we use ceph, we also use a messaging api called
zeromq (http://www.zeromq.org/) for messaging between our other
components.
And i thought this might be a proper replacement for your messaging
implementation, which causes some trouble.

ZeroMQ was developed to speed up stock trading and is now widely used
in many high performance messaging applications.
It offers a lot of different messaging pattern implementations
(publish/subscribe, fanout, ..) as well as different transport
mechanisms (tcp, multicast (pgm), inprocess ..).
It has a brokerless design and has many language bindings, but is
entirely written in c/c++.
There is a very active community.

It is also very well documented: http://zguide.zeromq.org/page:all

I was thinking since some time to point the ceph development team to
this piece of code, now with your announcement of the 0.28 work i
decided to do so.

So if you want to spend some spare time to read through the basic
concepts, enjoy.

Greetings from Munich

Stefan Majer

>
> Relevant URLs:
> =A0* Direct download at: http://ceph.newdream.net/download/ceph-0.27.=
tar.gz
> =A0* For Debian and Ubuntu packages, see http://ceph.newdream.net/wik=
i/Debian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
