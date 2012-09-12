From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: Quick CentOS/RHEL question ...
Date: Wed, 12 Sep 2012 16:42:18 +0100
Message-ID: <20120912154218.GA14887@tchpc.tcd.ie>
References: <50185964.3010803@scalableinformatics.com> <sfid-H20120801-021007-+045.02-1@marduk.tchpc.tcd.ie> <CAC-hyiF3jkA_VnPM8Ty9B+GnzH2xDbun9RQs+CE4yHgAp5OfnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:42239 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab2ILPmY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 11:42:24 -0400
Content-Disposition: inline
In-Reply-To: <CAC-hyiF3jkA_VnPM8Ty9B+GnzH2xDbun9RQs+CE4yHgAp5OfnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: landman@scalableinformatics.com, ceph-devel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 06:09:59PM -0700, Yehuda Sadeh wrote:
> On Tue, Jul 31, 2012 at 3:17 PM, Joe Landman
> <landman@scalableinformatics.com> wrote:
> > Hi folks
> >
> >   I was struggling and failing to get Ceph properly built/installed for
> > CentOS 6 (and 5) last week.  Is this simply not a recommended platform?
> > Please advise.  Thanks!
>=20
> As mentioned by the other responses, it is possible to get Ceph built
> for RHEL/CentOS even though it's probably not trivial. Getting proper
> packaging for these distributions is pretty high on our list. We'd
> love to hear about specific the issues that you have had.
>=20

Will there also be backports of the kernel modules for cephfs and rbd?
That's probably a make or break feature for anyone using RHEL based
distros as they are not likely to want to upgrade their kernels
manually and maintain them for security fixes. I guess if there are no
kernel modules for cephfs and rbd RHEL could still be used as a osd,
mon or mds.

Jimmy.

--=20
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAlBQrVgACgkQmRvHlXBDSynl5ACgz9e8gfjbyp3rGHzjRcJbKdDv
u0kAoLkj5PnBHU7Qi0qG+6B7LO5yl84q
=kWHZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
