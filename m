From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/3] mds:Interval tree
Date: Thu, 13 Oct 2011 20:35:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110132034120.16643@cobra.newdream.net>
References: <CAJD3hpWY0F-qg05Tgzy5twpcqJSQXAcAEs_yv7qTzFTxAWW33w@mail.gmail.com>
 <CAJD3hpXCO2uut-ftpFgOr7=vnE60g6_oeT2hmDy9QDo1d6n6Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1363107950-1318563301=:16643"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51011 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab1JNDfD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2011 23:35:03 -0400
In-Reply-To: <CAJD3hpXCO2uut-ftpFgOr7=vnE60g6_oeT2hmDy9QDo1d6n6Xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1363107950-1318563301=:16643
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jojy-

I merged this into the tree.  The next step is to redo the flock code to=20
use this.  Should be much cleaner...

Thanks!
sage


On Tue, 11 Oct 2011, Jojy Varghese wrote:

> Hi
>   I am resending the patch series for interval set. This time I have
> integrated the unit test cases to the existing suite.
>=20
> =A0 This patch-series of 3 patches has following changes:
> =A0 =A0 =A0 =A0- Interval tree implementation
> =A0 =A0 =A0 =A0- Unit test cases for the implementation
>        - Makefile changes for unit test integration
>=20
>=20
> Interval tree is an optimized data structure for =A0representing and
> querying intervals. Elementary intervals are
> represented as nodes of an avl tree and the corresponding data =A0is
> stored on these nodes based on a concept of span.
> =A0 =A0 =A0 =A0 This representation allows log(n) (where n is the number =
of
> data) storage. The balanced avl tree allows a log(n) query.
>=20
> =A0 =A0 =A0 =A0 The implementation is a template class that is instantiat=
ed
> based on parameters :
> =A0 =A0 =A0 =A0 - Interval type
> =A0 =A0 =A0 =A0 - Data type
>=20
> =A0 This is a basic component which can be used to store byte range locks=
=2E
>=20
>=20
> thanks
> -Jojy
>=20
--557981400-1363107950-1318563301=:16643--
