From: Sage Weil <sage@newdream.net>
Subject: Re: mds suicide
Date: Mon, 4 Oct 2010 22:40:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010042233230.21681@cobra.newdream.net>
References: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
 <Pine.LNX.4.64.1010042151480.21681@cobra.newdream.net>
 <Pine.LNX.4.64.1010042157100.21681@cobra.newdream.net>
 <AANLkTi=DG74g=fTcQzRoRM-Zpd9=ttz71wHyiUEXoONV@mail.gmail.com>
 <Pine.LNX.4.64.1010042213350.21681@cobra.newdream.net>
 <AANLkTi=rk8unODtsWcEZRXbnnof3SkrCM4J_cuhsP-f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1946151379-1286257216=:21681"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39675 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab0JEFid (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 01:38:33 -0400
In-Reply-To: <AANLkTi=rk8unODtsWcEZRXbnnof3SkrCM4J_cuhsP-f0@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1010042240180.21681@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1946151379-1286257216=:21681
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1010042240181.21681@cobra.newdream.net>

On Tue, 5 Oct 2010, Leander Yu wrote:
> I have another OSD was marked as down however I can still access the
> machine by ssh and I saw the cosd process is running.
> the log shows the same pipe fault error like:
>
> 192.168.1.9:6801/1537 >> 192.168.1.25:6801/29084 pipe(0x7f7b680e2620
> sd=3D-1 pgs=3D437 cs=3D1 l=3D0).fault with nothing to send, going to stan=
dby

That error means there was a socket error (usually connection dropped,=20
but it could lots of things), but the connection wasn't in use.

This one looks like the heartbeat channel.  Most likely that connection=20
reconnected shortly after that (the osds send heartbeats every couple=20
seconds).  They're marked down when peer osds expected a heartbeat and=20
don't get one.  The monitor log ($mon_data/log) normally has information=20
about who reported the failure, but it looks like you've turned it off. =20

In any case, usually the error is harmless.  And probably unrelated to the=
=20
MDS error (unless perhaps the same network glitch was to blame).

sage



>=20
> are those two cases related?
>=20
> Regards,
> Leander Yu.
>=20
>=20
> On Tue, Oct 5, 2010 at 1:15 PM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 5 Oct 2010, Leander Yu wrote:
> >> Hi Sage,
> >> Thanks a lot for your prompt answer.
> >> So is the behavior normal? I mean if we assume there was a network iss=
ue.
> >> In this case will it be better to restart the mds instead of suicide?
> >> or leave it there as standby?
> >
> > The mds has lots of internal state that would be tricky to clean up
> > properly, so one way or another the old instance should die.
> >
> > But you're right: probably it should just respawn a new instance instea=
d
> > of exiting? =A0The new instance will come back up in standby mode. Mayb=
e
> > re-exec with the same set of arguments the original instance was exectu=
ed
> > with?
> >
> > sage
> >
> >
> >>
> >> Regards,
> >> Leander Yu.
> >>
> >> On Tue, Oct 5, 2010 at 1:00 PM, Sage Weil <sage@newdream.net> wrote:
> >> > On Mon, 4 Oct 2010, Sage Weil wrote:
> >> >> On Tue, 5 Oct 2010, Leander Yu wrote:
> >> >> > Hi,
> >> >> > I have a 46 machines cluster(44 osd/mon + 2 mds) running ceph now=
=2E MDS
> >> >> > is running in active/standby mode.
> >> >> > This morning one of the MDS suicide the log shows:
> >> >> >
> >> >> > -------------------------------------------
> >> >> > 2010-10-04 22:24:19.450022 7f2e5a1ee710 mds0.cache.ino(10000002b8=
7)
> >> >> > pop_projected_snaprealm 0x7f2e50cd9f70 seq1
> >> >> > 2010-10-04 22:26:12.180854 7f2debbfb710 -- 192.168.1.103:6800/208=
1 >>
> >> >> > 192.168.1.106:0/2453428678 pipe(0x7f2e380013d0 sd=3D-1 pgs=3D2 cs=
=3D1
> >> >> > l=3D0).fault with nothing to send, going to standby
> >> >> > 2010-10-04 22:26:12.181019 7f2e481dc710 -- 192.168.1.103:6800/208=
1 >>
> >> >> > 192.168.1.111:0/18905730 pipe(0x7f2e38002250 sd=3D-1 pgs=3D2 cs=
=3D1
> >> >> > l=3D0).fault with nothing to send, going to standby
> >> >> > 2010-10-04 22:26:12.181041 7f2dc3fff710 -- 192.168.1.103:6800/208=
1 >>
> >> >> > 192.168.1.114:0/1945631186 pipe(0x7f2e38000f00 sd=3D-1 pgs=3D2 cs=
=3D1
> >> >> > l=3D0).fault with nothing to send, going to standby
> >> >> > 2010-10-04 22:26:12.181149 7f2deaef6710 -- 192.168.1.103:6800/208=
1 >>
> >> >> > 192.168.1.113:0/521184914 pipe(0x7f2e38002f90 sd=3D-1 pgs=3D2 cs=
=3D1
> >> >> > l=3D0).fault with nothing to send, going to standby
> >> >> > 2010-10-04 22:26:12.181563 7f2deb5f5710 -- 192.168.1.103:6800/208=
1 >>
> >> >> > 192.168.1.112:0/4272114728 pipe(0x7f2e38002ac0 sd=3D-1 pgs=3D2 cs=
=3D1
> >> >> > l=3D0).fault with nothing to send, going to standby
> >> >> > 2010-10-04 22:26:13.777624 7f2e5a1ee710 mds-1.3 handle_mds_map i
> >> >> > (192.168.1.103:6800/2081) dne in the mdsmap, killing myself
> >> >> > 2010-10-04 22:26:13.777649 7f2e5a1ee710 mds-1.3 suicide. =A0wante=
d
> >> >> > up:active, now down:dne
> >> >> > 2010-10-04 22:26:13.777769 7f2e489e4710 -- 192.168.1.103:6800/208=
1 >>
> >> >> > 192.168.1.101:0/15702 pipe(0x7f2e380008c0 sd=3D-1 pgs=3D1847 cs=
=3D1
> >> >> > l=3D0).fault with nothing to send, going to standby
> >> >> > -----------------------------------------------------------------=
-------------
> >> >> > Would you suggest how do I trouble shooting this issue? or should=
 I
> >> >> > just restart the mds to recover it?
> >> >>
> >> >> The MDS killed itself because it was removed from the mdsmap. =A0Th=
e
> >> >> monitor log will tell you why if you had logging turned up. =A0If n=
ot, you
> >> >> might find some clue by looking at each mdsmap iteration. =A0If you=
 do
> >> >>
> >> >> =A0$ ceph mds stat
> >> >>
> >> >> it will tell you the map epoch (e###). =A0You can then dump any map
> >> >> iteration with
> >> >>
> >> >> =A0$ ceph mds dump 123 -o -
> >> >>
> >> >> Work backward a few iterations until you find which epoch removed t=
hat mds
> >> >> instance. =A0The one prior to that might have some clue (maybe it w=
as
> >> >> laggy?)...
> >> >
> >> > Okay, looking at the maps on your cluster, it looks like there was a
> >> > standby mds, and the live one was marked down. =A0Probably some inte=
rmittent
> >> > network issue preventing it from sending the monitor beacon on time,=
 and
> >> > the monitor decided it was dead/unresponsive. =A0The standby cmds to=
ok over
> >> > successfully. =A0The recovery looks like it took about 20 seconds.
> >> >
> >> > sage
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1946151379-1286257216=:21681--
