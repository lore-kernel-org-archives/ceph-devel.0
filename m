From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] mds:Interval tree
Date: Sat, 8 Oct 2011 17:02:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110081700050.26432@cobra.newdream.net>
References: <CAJD3hpWY0F-qg05Tgzy5twpcqJSQXAcAEs_yv7qTzFTxAWW33w@mail.gmail.com>
 <CAJD3hpU=n3E7TU07L4JWUXajaDoZ5bKdo37Q3jNebsomJQd82g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1380903209-1318118577=:26432"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42202 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1JIAC5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2011 20:02:57 -0400
In-Reply-To: <CAJD3hpU=n3E7TU07L4JWUXajaDoZ5bKdo37Q3jNebsomJQd82g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1380903209-1318118577=:26432
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 8 Oct 2011, Jojy Varghese wrote:
> Hi Sage
>   Wondering about the status of this patch.

Oh yeah, I pushed it to a wip-intervaltree branch.  We haven't had time to=
=20
use it for the MDS locking code yet, so it's sitting there waiting for=20
that.

It would also be good to integrate your unit tests to the gtest framework=
=20
(i.e. move it to the src/test/ directory, use gtest to run the tests, and=
=20
add to the check_PROGRAMS list in the Makefile so it runs with 'make=20
check').

sage

>=20
> thanks
> Jojy
>=20
> On Sat, Sep 24, 2011 at 3:23 PM, Jojy Varghese <jojy.varghese@gmail.com> =
wrote:
> > Hi
> > =A0 This patch-set of 2 patches has following changes:
> > =A0 =A0 =A0 =A0- Interval tree implementation
> > =A0 =A0 =A0 =A0- Unit test cases for the implementation
> >
> > Interval tree is an optimized data structure for =A0representing and
> > querying intervals. Elementary intervals are
> > represented as nodes of an avl tree and the corresponding data =A0is
> > stored on these nodes based on a concept of span.
> > =A0 =A0 =A0 =A0 This representation allows log(n) (where n is the numbe=
r of
> > data) storage. The balanced avl tree allows a log(n) query.
> >
> > =A0 =A0 =A0 =A0 The implementation is a template class that is instanti=
ated
> > based on parameters :
> > =A0 =A0 =A0 =A0 - Interval type
> > =A0 =A0 =A0 =A0 - Data type
> >
> > =A0 This is a basic component which can be used to store byte range loc=
ks.
> >
> >
> > -Jojy
> >
>=20
>=20
--557981400-1380903209-1318118577=:26432--
