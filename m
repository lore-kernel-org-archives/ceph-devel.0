From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Cluster sync doesn't finsh
Date: Fri, 18 Nov 2011 10:05:18 -0800
Message-ID: <CAORUGqA888s9u23r6EfHCbMQ5t5QjGW8iNajdAZqK8pp7GqcXw@mail.gmail.com>
References: <4EC57338.9040004@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42118 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab1KRSFk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2011 13:05:40 -0500
Received: by wwe5 with SMTP id 5so5672302wwe.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2011 10:05:39 -0800 (PST)
In-Reply-To: <4EC57338.9040004@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Thu, Nov 17, 2011 at 12:48, Martin Mailand <martin@tuxadero.com> wro=
te:
> Hi,
> I am doing cluster failure test, where I shut down one OSD an wait fo=
r the
> cluster to sync. But the sync never finshed, at around 4-5% it stops.=
 I
> stoped osd2.
=2E..
> 2011-11-17 16:42:45.520740 =C2=A0 =C2=A0pg v1337: 600 pgs: 547 active=
+clean, 53
> active+clean+degraded; 113 GB data, 184 GB used, 1141 GB / 1395 GB av=
ail;
> 4025/82404 degraded (4.884%)
=2E..
> The osd log, the ceph.conf, pg dump, osd dump could be found here.
>
> http://85.214.49.87/ceph/

This looks a bit worrying:

2011-11-17 17:56:35.771574 7f704c834700 -- 192.168.42.113:0/2424 >>
192.168.42.114:6802/21115 pipe(0x2596c80 sd=3D17 pgs=3D0 cs=3D0 l=3D0).=
connect
claims to be 192.168.42.114:6802/21507 not 192.168.42.114:6802/21115 -
wrong node!

So osd.0 is basically refusing to talk to one of the other OSDs. I
don't understand the messenger well enough to know why this would be,
but it wouldn't surprise me if this problem kept the objects degraded
-- it looks like a breakage in the osd<->osd communication.

Now if this was the reason, I'd expect a restart of all the OSDs to
get it back in shape; messenger state is ephemeral. Can you confirm
that?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
