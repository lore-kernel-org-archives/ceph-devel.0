From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/3] mds:Interval tree
Date: Fri, 14 Oct 2011 08:11:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110140806030.3720@cobra.newdream.net>
References: <CAJD3hpWY0F-qg05Tgzy5twpcqJSQXAcAEs_yv7qTzFTxAWW33w@mail.gmail.com>
 <CAJD3hpXCO2uut-ftpFgOr7=vnE60g6_oeT2hmDy9QDo1d6n6Xw@mail.gmail.com>
 <Pine.LNX.4.64.1110132034120.16643@cobra.newdream.net>
 <CAJD3hpXq3E9QismM2rbrYozxwBkTV8TfGg8ziY9FZLpXrUxZ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-406031649-1318605100=:3720"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46986 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348Ab1JNPLk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2011 11:11:40 -0400
In-Reply-To: <CAJD3hpXq3E9QismM2rbrYozxwBkTV8TfGg8ziY9FZLpXrUxZ7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-406031649-1318605100=:3720
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Oct 2011, Jojy Varghese wrote:
> Great. Are there any unit test cases for the lock subsytem?

Currently there are only tests that exercise locks from a mounted fs.  See=
=20
teuthology.git/teuthology/tasks/lockfile.py and locktest.py.

A set of unit tests that exercise ceph_lock_state_t would probably be=20
a good addition...

sage


>=20
>=20
> thanks
> Jojy
>=20
>=20
> On Thu, Oct 13, 2011 at 8:35 PM, Sage Weil <sage@newdream.net> wrote:
> > Hi Jojy-
> >
> > I merged this into the tree. =A0The next step is to redo the flock code=
 to
> > use this. =A0Should be much cleaner...
> >
> > Thanks!
> > sage
> >
> >
> > On Tue, 11 Oct 2011, Jojy Varghese wrote:
> >
> >> Hi
> >> =A0 I am resending the patch series for interval set. This time I have
> >> integrated the unit test cases to the existing suite.
> >>
> >> =A0 This patch-series of 3 patches has following changes:
> >> =A0 =A0 =A0 =A0- Interval tree implementation
> >> =A0 =A0 =A0 =A0- Unit test cases for the implementation
> >> =A0 =A0 =A0 =A0- Makefile changes for unit test integration
> >>
> >>
> >> Interval tree is an optimized data structure for =A0representing and
> >> querying intervals. Elementary intervals are
> >> represented as nodes of an avl tree and the corresponding data =A0is
> >> stored on these nodes based on a concept of span.
> >> =A0 =A0 =A0 =A0 This representation allows log(n) (where n is the numb=
er of
> >> data) storage. The balanced avl tree allows a log(n) query.
> >>
> >> =A0 =A0 =A0 =A0 The implementation is a template class that is instant=
iated
> >> based on parameters :
> >> =A0 =A0 =A0 =A0 - Interval type
> >> =A0 =A0 =A0 =A0 - Data type
> >>
> >> =A0 This is a basic component which can be used to store byte range lo=
cks.
> >>
> >>
> >> thanks
> >> -Jojy
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-406031649-1318605100=:3720--
