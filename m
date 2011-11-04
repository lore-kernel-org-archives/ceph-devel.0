From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Feature request: "max mon" setting
Date: Fri, 4 Nov 2011 09:12:13 +0100
Message-ID: <201111040912.14250.a.ott@m-privacy.de>
References: <201111031302.51236.a.ott@m-privacy.de> <CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:46749 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451Ab1KDIMZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 04:12:25 -0400
In-Reply-To: <CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thursday 03 November 2011 you wrote:
> On Thu, Nov 3, 2011 at 05:02, Amon Ott <a.ott@m-privacy.de> wrote:
> > Documentation recommends three monitors. In our special cluster
> > configuration, this would mean that if accidentially two nodes with
> > monitors fail (e.g. one in maintenance and one crashes), the whole
> > cluster dies. What I would really
>
> If you feel two monitors going down is too likely, run a monitor
> cluster of size 5. And if you feel 3 monitors going down is too
> likely, run 7.

So there is no problem in having much more than three, as long as it is=
 an odd=20
number.

> > like would be that I can define a monitor on each node and e.g. set=
 "max
> > mon =3D 3". Each monitor starting up can then check how many monito=
rs are
> > already up and go to standby, if the number has already been reache=
d.
> > Regular rechecking could allow another monitor to become active, if=
 one
> > of the previously active monitors has died. Just like "max mds" act=
ually.
>
> Unfortunately, that is fundamentally not wanted. That would let a so
> called "split brain" situation occur, and the whole purpose of the
> majority rule of monitors is to ensure that it does not happen. If we
> didn't care about that, the monitors left standing would never need t=
o
> stop operating.

Alright, I see you point. A network split could be unfortunate, but it =
could=20
also make problems with e.g. 7 monitors - 4 on one and 3 on the other=20
partition. So best would be to really stick with 3.

> > A special case that gives me most headaches is the case of just two
> > active nodes. According to documentation, the monitor problem means=
 that
> > one failing monitor kills the cluster whatever the number of define=
d
> > monitors (1 or 2), even if we have all data safely placed on both n=
odes.
>
> Yes, 1 or 2 total physical nodes in a Ceph cluster makes it hard to d=
o
> HA. You could run just one ceph-mon, then the other node failing
> doesn't affect the cluster at all (but naturally the one running
> ceph-mon must not fail).
>
> Perhaps you can get a third machine to also be a monitor, even if it
> doesn't participate in storage etc. ceph-mon is a very lightweight
> process. Share a server that has other responsibilities, or buy the
> cheapest atom netbook you can find -- it should do the job just fine.

Yes, this sounds like a useful idea.

> Clusters of <=3D2 nodes are pretty far from what Ceph was designed fo=
r,
> and while we use them all the time for testing, running a setup that
> small for real is pretty rare. Sorry.

I agree that our needs are special. We want to be able to start with 2 =
and=20
extend as customer needs grow, or start with 20 and shut some of them d=
own if=20
load gets low. I now understand that we should start with at least thre=
e=20
nodes.

Thank you for clearing things up!

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=C3=B6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
