From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: OSD doesn't start
Date: Thu, 05 Jul 2012 16:12:42 +0200
Message-ID: <95834053.QbLuzMQ4OG@mranderson>
References: <1563053.ttVafs9Pph@mranderson> <F1FB8F95B3FA4FF19D53AE9F060D88F5@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from imap.ki.iif.hu ([193.6.222.244]:35545 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab2GEOMx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 10:12:53 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by strudel.ki.iif.hu (Postfix) with ESMTP id C1E3F3B0
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jul 2012 16:12:51 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id f8FD1KB2waqy for <ceph-devel@vger.kernel.org>;
	Thu,  5 Jul 2012 16:12:43 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:401:f47e:7b88:6c9e:453a])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 6A9A33A8
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jul 2012 16:12:43 +0200 (CEST)
In-Reply-To: <F1FB8F95B3FA4FF19D53AE9F060D88F5@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 4. 09:34:04 Gregory Farnum wrote:
> Hrm, it looks like the OSD data directory got a little busted somehow=
=2E How
> did you perform your upgrade? (That is, how did you kill your daemons=
, in
> what order, and when did you bring them back up.)

Since it would be hard and long to describe in text, I've collected the=
=20
relevant log entries, sorted by time at http://pastebin.com/Ev3M4DQ9 . =
The=20
short story is that after seeing that the OSDs won't start, I tried to =
bring=20
down the whole cluster and start it up from scratch. It didn't change=20
anything, so I rebooted the two machines (running all three daemons), t=
o see=20
if it changes anything. It didn't and I gave up.

My ceph config is available at http://pastebin.com/KKNjmiWM .

Since this is my test cluster, I'm not very concerned about the data on=
 it.=20
But the other one, with the same config, is dying I think. ceph-fuse is=
 eating=20
around 75% CPU on the sole monitor ("cc") node. The monitor about 15%. =
On the=20
other two nodes, the OSD eats around 50%, the MDS 15%, the monitor anot=
her=20
10%. No Ceph filesystem activity is going on at the moment. Blktrace re=
ports=20
about 1kB/s disk traffic on the partition hosting the OSD data dir. The=
 data=20
seems to be accessible at the moment, but I'm afraid that my production=
=20
cluster will end up in a similar situation after upgrade, so I don't da=
re to=20
touch it.

Do you have any suggestion what I should check?

Thanks,
--=20
cc

> On Wednesday, July 4, 2012 at 8:31 AM, Sz=E9kelyi Szabolcs wrote:
> > Hi,
> >=20
> > after upgrading to 0.48 "Argonaut", my OSDs won't start up again. T=
his
> > problem might not be related to the upgrade, since the cluster had
> > strange behavior before, too: ceph-fuse was spinning the CPU around=
 70%,
> > so did the OSDs. This happened to both of my clusters. Thought that
> > upgrading might solve the problem, but it just got worse.
> >=20
> > I've copied the log of the OSD run to http://pastebin.com/XYRtfFMU =
=2E I've
> > rebooted all the nodes, but they still don't work.
> >=20
> > What should I do to resurrect my OSDs?
> >=20
> > Thanks,
> > --
> > cc
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > (mailto:majordomo@vger.kernel.org) More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
