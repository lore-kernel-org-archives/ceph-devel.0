From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: [WRN] map e### wrongly marked me down or wrong addr
Date: Tue, 28 Feb 2012 18:26:47 +0100
Message-ID: <2723197.ltUXXyvl0z@mranderson>
References: <2230716.Iq9SpLVmvc@mranderson> <2227262.Lg19pAvyvB@mranderson> <CAF3hT9DDKCV6uh3WPStrmnTOuWOBc1k_n-YUJMi9wzCT8GL5YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:57433 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965608Ab2B1R05 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 12:26:57 -0500
In-Reply-To: <CAF3hT9DDKCV6uh3WPStrmnTOuWOBc1k_n-YUJMi9wzCT8GL5YA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, wido@widodh.nl

On 2012. February 28. 08:16:34 Gregory Farnum wrote:
> 2012/2/28 Sz=C3=A9kelyi Szabolcs <szekelyi@niif.hu>:
> > On 2012. February 27. 09:03:11 Sage Weil wrote:
> >> On Mon, 27 Feb 2012, Sz=C3=A9kelyi Szabolcs wrote:
> >> > whenever I restart osd.0 I see a pair of messages like
> >> >=20
> >> > 2012-02-27 17:26:00.132666 mon.0 <osd_1_ip>:6789/0 106 : [INF]
> >> > osd.0
> >> > <osd_0_ip>:6801/29931 failed (by osd.1 <osd_1_ip>:6806/20125)
> >> > 2012-02-27 17:26:21.074926 osd.0 <osd_0_ip>:6801/29931 1 : [WRN]
> >> > map
> >> > e370
> >> > wrongly marked me down or wrong addr
> >> >=20
> >> > a couple of times. The situation stabilizes in a normal state
> >> > after
> >> > about two minutes.
> >> >=20
> >> > Should I worry about this? Maybe the first message is about the
> >> > just
> >> > killed OSD, and the second comes from the new incarnation, and
> >> > this is
> >> > completely normal? This is Ceph 0.41.
> >>=20
> >> It's not normal.  Wido was seeing something similar, I think.  I
> >> suspect
> >> the problem is that during startup ceph-osd just busy, but the
> >> heartbeat
> >> code is such that it's not supposed to miss them.
> >>=20
> >> Can you reproduce this with 'debug ms =3D 1'?
> >=20
> > Yes, I managed to. Output of ceph -w attached (with IP addresses
> > mangled). My setup is 3 nodes, node 1 and 2 running OSD, MDS and MO=
N,
> > node 3 running MON only. I also have the logs from all nodes in cas=
e
> > you need it.
>=20
> Yes, please. Just the cluster state is not very helpful =E2=80=94 we =
want to
> see why the OSDs are marking each other down, not when. :)

Okay, it was a firewall issue. The port range that was allowed to reach=
 the=20
OSDs didn't include a number of necessary ports. It started working aft=
er a=20
while because I also had a rule like

-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT=20

So osd.1 could not talk to osd.0 after a restart (because of the wrong =
port=20
range), only after osd.0 started talking to osd.1 (because of the -m st=
ate=20
rule).

Sorry for the noise.

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
