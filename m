From: Sage Weil <sage@newdream.net>
Subject: Re: Serious problem after increase pg_num in pool
Date: Mon, 20 Feb 2012 12:19:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202201218260.19182@cobra.newdream.net>
References: <CAMwB3Tio0DjJDHv5EXT1=_qb=ytc7ooBMCbFano3aiTQt8ti6Q@mail.gmail.com>
 <CAMwB3TjWU_nttbe2skH8YU0LAOZzxapFhZsyDVZMsyu29_tYJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1314844950-1329769180=:19182"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53460 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab2BTUTn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 15:19:43 -0500
In-Reply-To: <CAMwB3TjWU_nttbe2skH8YU0LAOZzxapFhZsyDVZMsyu29_tYJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1314844950-1329769180=:19182
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Ooh, the pg split functionality is currently broken, and we weren't=20
planning on fixing it for a while longer.  I didn't realize it was still=20
possible to trigger from the monitor.

I'm looking at how difficult it is to make it work (even inefficiently). =
=20

How much data do you have in the cluster?

sage




On Mon, 20 Feb 2012, S?awomir Skowron wrote:

> and this in ceph -w
>=20
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611270 osd.76
> 10.177.64.8:6872/5395 49 : [ERR] mkpg 7.e up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611308 osd.76
> 10.177.64.8:6872/5395 50 : [ERR] mkpg 7.16 up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611339 osd.76
> 10.177.64.8:6872/5395 51 : [ERR] mkpg 7.1e up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611369 osd.76
> 10.177.64.8:6872/5395 52 : [ERR] mkpg 7.26 up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611399 osd.76
> 10.177.64.8:6872/5395 53 : [ERR] mkpg 7.2e up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611428 osd.76
> 10.177.64.8:6872/5395 54 : [ERR] mkpg 7.36 up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611458 osd.76
> 10.177.64.8:6872/5395 55 : [ERR] mkpg 7.3e up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611488 osd.76
> 10.177.64.8:6872/5395 56 : [ERR] mkpg 7.46 up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611517 osd.76
> 10.177.64.8:6872/5395 57 : [ERR] mkpg 7.4e up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611547 osd.76
> 10.177.64.8:6872/5395 58 : [ERR] mkpg 7.56 up [76,11] !=3D acting [76]
> 2012-02-20 20:34:13.531857   log 2012-02-20 20:34:07.611577 osd.76
> 10.177.64.8:6872/5395 59 : [ERR] mkpg 7.5e up [76,11] !=3D acting [76]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618816 osd.20
> 10.177.64.4:6839/6735 54 : [ERR] mkpg 7.f up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618854 osd.20
> 10.177.64.4:6839/6735 55 : [ERR] mkpg 7.17 up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618883 osd.20
> 10.177.64.4:6839/6735 56 : [ERR] mkpg 7.1f up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618912 osd.20
> 10.177.64.4:6839/6735 57 : [ERR] mkpg 7.27 up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618941 osd.20
> 10.177.64.4:6839/6735 58 : [ERR] mkpg 7.2f up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618970 osd.20
> 10.177.64.4:6839/6735 59 : [ERR] mkpg 7.37 up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.618999 osd.20
> 10.177.64.4:6839/6735 60 : [ERR] mkpg 7.3f up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.619027 osd.20
> 10.177.64.4:6839/6735 61 : [ERR] mkpg 7.47 up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.619056 osd.20
> 10.177.64.4:6839/6735 62 : [ERR] mkpg 7.4f up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.619085 osd.20
> 10.177.64.4:6839/6735 63 : [ERR] mkpg 7.57 up [51,20,64] !=3D acting
> [20,51,64]
> 2012-02-20 20:34:17.015290   log 2012-02-20 20:34:07.619113 osd.20
> 10.177.64.4:6839/6735 64 : [ERR] mkpg 7.5f up [51,20,64] !=3D acting
> [20,51,64]
>=20
> 2012/2/20 S?awomir Skowron <slawomir.skowron@gmail.com>:
> > After increase number pg_num from 8 to 100 in .rgw.buckets i have some
> > serious problems.
> >
> > pool name =A0 =A0 =A0 category =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 KB =A0 =
=A0 =A0objects =A0 =A0 =A0 clones
> > =A0 degraded =A0 =A0 =A0unfound =A0 =A0 =A0 =A0 =A0 rd =A0 =A0 =A0 =A0r=
d KB =A0 =A0 =A0 =A0 =A0 wr
> > wr KB
> > .intent-log =A0 =A0 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4662 =
=A0 =A0 =A0 =A0 =A0 19 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A026502
> > 26501
> > .log =A0 =A0 =A0 =A0 =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 913732
> > 913342
> > .rgw =A0 =A0 =A0 =A0 =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A01 =A0 =A0 =A0 =A0 =A0 10 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A01 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A09
> > =A0 =A07
> > .rgw.buckets =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 39582566 =A0 =
=A0 =A0 =A073707 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A08061 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A086594 =A0 =A0 =
=A0 =A0 =A0 =A00 =A0 =A0 =A0 610896
> > 36050541
> > .rgw.control =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00 =A0 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A00
> > .users =A0 =A0 =A0 =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01 =A0 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A01
> > =A0 =A01
> > .users.uid =A0 =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A01 =A0 =A0 =A0 =A0 =A0 =A02 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A02 =
=A0 =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A0 =A03
> > =A0 =A03
> > data =A0 =A0 =A0 =A0 =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A00
> > metadata =A0 =A0 =A0 =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 =A00 =
=A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A00
> > rbd =A0 =A0 =A0 =A0 =A0 =A0 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 21590=
723 =A0 =A0 =A0 =A0 5328 =A0 =A0 =A0 =A0 =A0 =A00
> > =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 77 =A0 =
=A0 =A0 =A0 =A0 75 =A0 =A0 =A03013595
> > 378345507
> > =A0total used =A0 =A0 =A0 229514252 =A0 =A0 =A0 =A079068
> > =A0total avail =A0 =A019685615164
> > =A0total space =A0 =A020980898464
> >
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384251 mon.0
> > 10.177.64.4:6789/0 36135 : [INF] osd.28 10.177.64.6:6806/824 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384275 mon.0
> > 10.177.64.4:6789/0 36136 : [INF] osd.37 10.177.64.6:6841/29133 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384301 mon.0
> > 10.177.64.4:6789/0 36137 : [INF] osd.7 10.177.64.4:6813/8223 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384327 mon.0
> > 10.177.64.4:6789/0 36138 : [INF] osd.44 10.177.64.6:6859/2370 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384353 mon.0
> > 10.177.64.4:6789/0 36139 : [INF] osd.49 10.177.64.6:6865/29878 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384384 mon.0
> > 10.177.64.4:6789/0 36140 : [INF] osd.17 10.177.64.4:6827/5909 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384410 mon.0
> > 10.177.64.4:6789/0 36141 : [INF] osd.12 10.177.64.4:6810/5410 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384435 mon.0
> > 10.177.64.4:6789/0 36142 : [INF] osd.39 10.177.64.6:6843/12733 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384461 mon.0
> > 10.177.64.4:6789/0 36143 : [INF] osd.42 10.177.64.6:6848/13067 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384485 mon.0
> > 10.177.64.4:6789/0 36144 : [INF] osd.31 10.177.64.6:6840/1233 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384513 mon.0
> > 10.177.64.4:6789/0 36145 : [INF] osd.36 10.177.64.6:6830/12573 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384537 mon.0
> > 10.177.64.4:6789/0 36146 : [INF] osd.38 10.177.64.6:6833/32587 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384567 mon.0
> > 10.177.64.4:6789/0 36147 : [INF] osd.5 10.177.64.4:6873/7842 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384596 mon.0
> > 10.177.64.4:6789/0 36148 : [INF] osd.21 10.177.64.4:6844/11607 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384622 mon.0
> > 10.177.64.4:6789/0 36149 : [INF] osd.23 10.177.64.4:6853/6826 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384661 mon.0
> > 10.177.64.4:6789/0 36150 : [INF] osd.51 10.177.64.6:6858/15894 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384693 mon.0
> > 10.177.64.4:6789/0 36151 : [INF] osd.48 10.177.64.6:6862/13476 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384723 mon.0
> > 10.177.64.4:6789/0 36152 : [INF] osd.32 10.177.64.6:6815/3701 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384759 mon.0
> > 10.177.64.4:6789/0 36153 : [INF] osd.41 10.177.64.6:6847/1861 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384790 mon.0
> > 10.177.64.4:6789/0 36154 : [INF] osd.0 10.177.64.4:6800/5230 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384814 mon.0
> > 10.177.64.4:6789/0 36155 : [INF] osd.3 10.177.64.4:6865/7242 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384838 mon.0
> > 10.177.64.4:6789/0 36156 : [INF] osd.1 10.177.64.4:6804/9729 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384864 mon.0
> > 10.177.64.4:6789/0 36157 : [INF] osd.47 10.177.64.6:6866/13924 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384896 mon.0
> > 10.177.64.4:6789/0 36158 : [INF] osd.45 10.177.64.6:6857/4401 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384928 mon.0
> > 10.177.64.4:6789/0 36159 : [INF] osd.20 10.177.64.4:6842/6246 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384952 mon.0
> > 10.177.64.4:6789/0 36160 : [INF] osd.16 10.177.64.4:6821/5833 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.384982 mon.0
> > 10.177.64.4:6789/0 36161 : [INF] osd.35 10.177.64.6:6824/3877 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.385007 mon.0
> > 10.177.64.4:6789/0 36162 : [INF] osd.3 10.177.64.4:6865/7242 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.385032 mon.0
> > 10.177.64.4:6789/0 36163 : [INF] osd.7 10.177.64.4:6813/8223 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.688085 =A0 log 2012-02-20 20:06:09.385059 mon.0
> > 10.177.64.4:6789/0 36164 : [INF] osd.19 10.177.64.4:6831/10499 failed
> > (by osd.55 10.177.64.8:6809/28642)
> > 2012-02-20 20:06:10.851483 =A0 =A0pg v172582: 10548 pgs: 92 creating, 1
> > active, 9713 active+clean, 3 active+degraded+backfill, 657 peering, 77
> > down+peering, 5 active+degraded; 59744 MB data, 218 GB used, 18773 GB
> > / 20008 GB avail; 8071/237184 degraded (3.403%)
> > 2012-02-20 20:06:10.967491 =A0 osd e7436: 78 osds: 70 up, 73 in
> > 2012-02-20 20:06:10.990903 =A0 log 2012-02-20 20:05:56.448227 mon.2
> > 10.177.64.8:6789/0 134 : [INF] mon.2 calling new monitor election
> > 2012-02-20 20:06:10.990903 =A0 log 2012-02-20 20:05:58.252635 mon.1
> > 10.177.64.6:6789/0 3929 : [INF] mon.1 calling new monitor election
> > 2012-02-20 20:06:11.034669 =A0 =A0pg v172583: 10548 pgs: 92 creating, 1
> > active, 9713 active+clean, 3 active+degraded+backfill, 657 peering, 77
> > down+peering, 5 active+degraded; 59744 MB data, 218 GB used, 18773 GB
> > / 20008 GB avail; 8071/237184 degraded (3.403%)
> > 2012-02-20 20:06:11.958126 =A0 osd e7437: 78 osds: 70 up, 73 in
> > 2012-02-20 20:06:12.068650 =A0 =A0pg v172584: 10548 pgs: 92 creating, 1
> > active, 9711 active+clean, 3 active+degraded+backfill, 659 peering, 77
> > down+peering, 5 active+degraded; 59744 MB data, 218 GB used, 18773 GB
> > / 20008 GB avail; 8067/237184 degraded (3.401%)
> > 2012-02-20 20:06:12.947997 =A0 osd e7438: 78 osds: 70 up, 73 in
> > 2012-02-20 20:06:13.770942 =A0 =A0pg v172585: 10548 pgs: 3 inactive, 92
> > creating, 1 active, 9824 active+clean, 3 active+degraded+backfill, 541
> > peering, 77 down+peering, 7 active+degraded; 59744 MB data, 218 GB
> > used, 18773 GB / 20008 GB avail; 8067/237184 degraded (3.401%)
> > 2012-02-20 20:06:14.686248 =A0 =A0pg v172586: 10548 pgs: 3 inactive, 92
> > creating, 1 active, 9894 active+clean, 3 active+degraded+backfill, 471
> > peering, 77 down+peering, 7 active+degraded; 59744 MB data, 218 GB
> > used, 18773 GB / 20008 GB avail; 8067/237184 degraded (3.401%)
> > 2012-02-20 20:06:15.340365 =A0 =A0pg v172587: 10548 pgs: 3 inactive, 92
> > creating, 1 active, 9915 active+clean, 3 active+degraded+backfill, 447
> > peering, 77 down+peering, 10 active+degraded; 59744 MB data, 218 GB
> > used, 18773 GB / 20008 GB avail; 8067/237184 degraded (3.401%)
> > 2012-02-20 20:06:16.852264 =A0 =A0pg v172588: 10548 pgs: 3 inactive, 92
> > creating, 84 active, 10094 active+clean, 3 active+degraded+backfill,
> > 179 peering, 77 down+peering, 16 active+degraded; 59744 MB data, 218
> > GB used, 18773 GB / 20008 GB avail; 8067/237184 degraded (3.401%)
> >
> > osds is going to fail, again, and again, another going to fail. Number
> > of up osd changing from 62, to 70-72, and going down, ang again going
> > up.
> >
> > 2012-02-20 20:09:47.305016 7f816009e700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.64 since 2012-02-20 20:09:30.286408 (cutoff
> > 2012-02-20 20:09:42.304975)
> > 2012-02-20 20:09:47.410159 7f816c9b8700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.61 since 2012-02-20 20:09:29.807115 (cutoff
> > 2012-02-20 20:09:42.410144)
> > 2012-02-20 20:09:47.410177 7f816c9b8700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.64 since 2012-02-20 20:09:30.286408 (cutoff
> > 2012-02-20 20:09:42.410144)
> > 2012-02-20 20:09:47.906661 7f816009e700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.61 since 2012-02-20 20:09:29.807115 (cutoff
> > 2012-02-20 20:09:42.906639)
> > 2012-02-20 20:09:47.906685 7f816009e700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.64 since 2012-02-20 20:09:30.286408 (cutoff
> > 2012-02-20 20:09:42.906639)
> > 2012-02-20 20:09:48.114431 7f815660b700 -- 10.177.64.4:0/6389 >>
> > 10.177.64.4:6854/5398 pipe(0x1398c500 sd=3D47 pgs=3D26 cs=3D2 l=3D0).co=
nnect
> > claims to be 10.177.64.4:6854/17798 not 10.177.64.4:6854/5398 - wrong
> > node!
> > 2012-02-20 20:09:48.410333 7f816c9b8700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.61 since 2012-02-20 20:09:29.807115 (cutoff
> > 2012-02-20 20:09:43.410313)
> > 2012-02-20 20:09:48.410361 7f816c9b8700 osd.20 7476 heartbeat_check:
> > no heartbeat from osd.64 since 2012-02-20 20:09:30.286408 (cutoff
> > 2012-02-20 20:09:43.410313)
> > 2012-02-20 20:09:51.450127 7f814b75d700 -- 10.177.64.4:0/6389 >>
> > 10.177.64.4:6855/17423 pipe(0xa86e780 sd=3D17 pgs=3D17 cs=3D2 l=3D0).co=
nnect
> > claims to be 10.177.64.4:6855/17798 not 10.177.64.4:6855/17423 - wrong
> > node!
> > 2012-02-20 20:09:54.498949 7f814a248700 -- 10.177.64.4:0/6389 >>
> > 10.177.64.4:6854/19396 pipe(0x38cc780 sd=3D25 pgs=3D8 cs=3D2 l=3D0).con=
nect
> > claims to be 10.177.64.4:6854/17798 not 10.177.64.4:6854/19396 - wrong
> > node!
> >
> > Some of them is going down with this:
> >
> > 2012-02-20 18:22:15.824992 7fe3ec1c97a0 ceph version 0.41
> > (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d), process ceph-osd,
> > pid 31379
> > 2012-02-20 18:22:15.826476 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount FIEMAP ioctl is supported
> > 2012-02-20 18:22:15.826514 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount did NOT detect btrfs
> > 2012-02-20 18:22:15.826613 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount found snaps <>
> > 2012-02-20 18:22:15.826650 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount: WRITEAHEAD journal mode explicitly enabled in conf
> > 2012-02-20 18:22:16.415671 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount FIEMAP ioctl is supported
> > 2012-02-20 18:22:16.415703 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount did NOT detect btrfs
> > 2012-02-20 18:22:16.415744 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount found snaps <>
> > 2012-02-20 18:22:16.415758 7fe3ec1c97a0 filestore(/vol0/data/osd.24)
> > mount: WRITEAHEAD journal mode explicitly enabled in conf
> > osd/OSD.cc: In function 'void OSD::split_pg(PG*, std::map<pg_t, PG*>&,
> > ObjectStore::Transaction&)' thread 7fe3df8c4700 time 2012-02-20
> > 18:22:19.900886
> > osd/OSD.cc: 4066: FAILED assert(child)
> > =A0ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d)
> > =A01: (OSD::split_pg(PG*, std::map<pg_t, PG*, std::less<pg_t>,
> > std::allocator<std::pair<pg_t const, PG*> > >&,
> > ObjectStore::Transaction&)+0x23e0) [0x54cd20]
> > =A02: (OSD::kick_pg_split_queue()+0x880) [0x556d90]
> > =A03: (OSD::handle_pg_notify(MOSDPGNotify*)+0x4b6) [0x559546]
> > =A04: (OSD::_dispatch(Message*)+0x608) [0x560e58]
> > =A05: (OSD::ms_dispatch(Message*)+0x11e) [0x561b7e]
> > =A06: (SimpleMessenger::dispatch_entry()+0x76b) [0x5c844b]
> > =A07: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4b5cfc]
> > =A08: (()+0x7efc) [0x7fe3ebda3efc]
> > =A09: (clone()+0x6d) [0x7fe3ea3d489d]
> > =A0ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d)
> > =A01: (OSD::split_pg(PG*, std::map<pg_t, PG*, std::less<pg_t>,
> > std::allocator<std::pair<pg_t const, PG*> > >&,
> > ObjectStore::Transaction&)+0x23e0) [0x54cd20]
> > =A02: (OSD::kick_pg_split_queue()+0x880) [0x556d90]
> > =A03: (OSD::handle_pg_notify(MOSDPGNotify*)+0x4b6) [0x559546]
> > =A04: (OSD::_dispatch(Message*)+0x608) [0x560e58]
> > =A05: (OSD::ms_dispatch(Message*)+0x11e) [0x561b7e]
> > =A06: (SimpleMessenger::dispatch_entry()+0x76b) [0x5c844b]
> > =A07: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4b5cfc]
> > =A08: (()+0x7efc) [0x7fe3ebda3efc]
> > =A09: (clone()+0x6d) [0x7fe3ea3d489d]
> > *** Caught signal (Aborted) **
> > =A0in thread 7fe3df8c4700
> > =A0ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d)
> > =A01: /usr/bin/ceph-osd() [0x6099f6]
> > =A02: (()+0x10060) [0x7fe3ebdac060]
> > =A03: (gsignal()+0x35) [0x7fe3ea3293a5]
> > =A04: (abort()+0x17b) [0x7fe3ea32cb0b]
> > =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fe3eabe7d7d]
> > =A06: (()+0xb9f26) [0x7fe3eabe5f26]
> > =A07: (()+0xb9f53) [0x7fe3eabe5f53]
> > =A08: (()+0xba04e) [0x7fe3eabe604e]
> > =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x200) [0x5dc6b0]
> > =A010: (OSD::split_pg(PG*, std::map<pg_t, PG*, std::less<pg_t>,
> > std::allocator<std::pair<pg_t const, PG*> > >&,
> > ObjectStore::Transaction&)+0x23e0) [0x54cd20]
> > =A011: (OSD::kick_pg_split_queue()+0x880) [0x556d90]
> > =A012: (OSD::handle_pg_notify(MOSDPGNotify*)+0x4b6) [0x559546]
> > =A013: (OSD::_dispatch(Message*)+0x608) [0x560e58]
> > =A014: (OSD::ms_dispatch(Message*)+0x11e) [0x561b7e]
> > =A015: (SimpleMessenger::dispatch_entry()+0x76b) [0x5c844b]
> > =A016: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4b5cfc]
> > =A017: (()+0x7efc) [0x7fe3ebda3efc]
> > =A018: (clone()+0x6d) [0x7fe3ea3d489d]
> > 2012-02-20 18:23:57.915653 7fa818e3e7a0 ceph version 0.41
> > (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d), process ceph-osd,
> > pid 6596
> >
> > Do you have any ideas ?? if you need some data from cluster, or a core
> > dumps from osd i have a lot of them, but they are large.
> >
> > --
> > -----
> > Pozdrawiam
> >
> > S?awek "sZiBis" Skowron
>=20
>=20
>=20
> --=20
> -----
> Pozdrawiam
>=20
> S?awek "sZiBis" Skowron
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1314844950-1329769180=:19182--
