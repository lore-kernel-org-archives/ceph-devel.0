From: Sage Weil <sage@inktank.com>
Subject: Re: GCC -msse2 portability question
Date: Sun, 23 Mar 2014 18:40:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403231840070.26602@cobra.newdream.net>
References: <532F3B0E.2050204@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1566250523-1395625240=:26602"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41063 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaCXBkl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Mar 2014 21:40:41 -0400
In-Reply-To: <532F3B0E.2050204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Laurent Guerby <laurent@guerby.net>, Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1566250523-1395625240=:26602
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Loic,

FWIW something with the build or feature detection seems to be off, as I=20
just got an Illegal Instruction signal on the current master:

	http://tracker.ceph.com/issues/7826

sage



On Sun, 23 Mar 2014, Loic Dachary wrote:

> Hi Laurent,
>=20
> In the context of optimizing erasure code functions implemented by Kevi=
n Greenan (cc'ed) and James Plank at https://bitbucket.org/jimplank/gf-co=
mplete/ we ran accross a question you may have the answer to: can gcc -ms=
se2 (or -msse* for that matter ) have a negative impact on the portabilit=
y of the compiled binary code ?=20
>=20
> In other words, if a code is compiled without -msse* and runs fine on a=
ll intel processors it targets, could it be that adding -msse* to the com=
pilation of the same source code generate a binary that would fail on som=
e processors ? This is assuming no sse specific functions were used in th=
e source code.
>=20
> In gf-complete, all sse specific instructions are carefully protected t=
o not be run on a CPU that does not support them. The runtime detection i=
s done by checking CPU id bits ( see https://bitbucket.org/jimplank/gf-co=
mplete/pull-request/7/probe-intel-sse-features-at-runtime/diff#Lsrc/gf_in=
tel.cT28 )
>=20
> The corresponding thread is at:
>=20
> https://bitbucket.org/jimplank/gf-complete/pull-request/4/defer-the-dec=
ision-to-use-a-given-sse/diff#comment-1479296
>=20
> Cheers
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
--557981400-1566250523-1395625240=:26602--
