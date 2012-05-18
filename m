From: Sage Weil <sage@inktank.com>
Subject: Re: Release/branch naming; input requested
Date: Fri, 18 May 2012 10:06:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205181001470.8006@cobra.newdream.net>
References: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
 <CAC-hyiFdGudQSfby7QkJZRBhGDBQeWGiA7LwtFWhmevUMa_2bw@mail.gmail.com>
 <Pine.LNX.4.64.1205180918190.8006@cobra.newdream.net>
 <CAC-hyiFQ7M9Y61uc4CfbWRAaMb_ovC-NG5snkPR2HEfYjVNbKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-572813619-1337360795=:8006"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab2ERRGq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 13:06:46 -0400
In-Reply-To: <CAC-hyiFQ7M9Y61uc4CfbWRAaMb_ovC-NG5snkPR2HEfYjVNbKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Tommi Virtanen <tommi.virtanen@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-572813619-1337360795=:8006
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 18 May 2012, Yehuda Sadeh wrote:
> On Fri, May 18, 2012 at 9:32 AM, Sage Weil <sage@inktank.com> wrote:
> > On Thu, 26 Apr 2012, Yehuda Sadeh Weinraub wrote:
> >> > Now, here are my actual questions:
> >> >
> >> > 1. What should the "relative" names of the branches be? "stable" vs
> >> > "latest" etc. I especially don't like "integration", but I do see a
> >> > time where it is not ready for "stable" but still needs to branch of=
f
> >> > of "latest".
> >>
> >> reallyold
> >> old
> >> current
> >> next
> >> latest/experimental
> >
> > I think we can limit the relative branches to:
> >
> > =A0master =3D integration, unstable, tip, bleeding edge (same as now)
> > =A0[next] =3D next upcoming release (same as now)
>=20
> However, now a release means a dev cycle, which is different than
> having a few iterations on a single release. So should 'next' be the
> next release, or the next output of the current dev cycle?

I think we can keep the current 'release each cycle' plan (which would=20
make 'the next release' and 'the output of the current dev cycle' be the=20
same thing).  There are still people who will want the bloody (if not=20
bleeding) edge of the last sprint output instead of a months-old stable=20
release.

And in general, next or current will pretty closely approximate a 'next'=20
that means 'the next stable release'.

> > =A0current =3D most recent release
> > =A0stable =3D most recent stable release
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-572813619-1337360795=:8006--
