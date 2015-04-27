From: Loic Dachary <loic@dachary.org>
Subject: Re: Firefly integration branch : OK
Date: Mon, 27 Apr 2015 13:21:08 +0200
Message-ID: <553E1BA4.7070604@dachary.org>
References: <553DEDD3.2030202@dachary.org> <75674D092A819E4189E91166C74CB90D015333B1@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UvtRx61Dvqnq66oGGrDn1mRNdjjUNeNcX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53460 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965070AbbD0VsN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 17:48:13 -0400
In-Reply-To: <75674D092A819E4189E91166C74CB90D015333B1@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UvtRx61Dvqnq66oGGrDn1mRNdjjUNeNcX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/04/2015 11:19, Shu, Xinxin wrote:
> Hi loic, can we merge PR (4414 ~ 4416) into integration branch now

As soon as the pull requests 4385, 4384, 4382 are merged we can reset the=
 integration branch will all pending firefly pull requests and start anot=
her round :-)

Cheers

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Monday, April 27, 2015 4:06 PM
> To: Shu, Xinxin
> Cc: Ceph Development
> Subject: Firefly integration branch : OK
>=20
> Hi,
>=20
> I saw this morning the firefly integration branch passed rados and rbd =
suites :-)=20
>=20
> http://tracker.ceph.com/issues/11090#rados
> http://tracker.ceph.com/issues/11090#rbd
>=20
> The issue has been updated accordingly. It means the following pull req=
uests passed:
>=20
> $ git log --merges --oneline 12143ff9b25fdd96f8d1a9cecb1329c7f354d414..=
b91bbb434e6363a99a632cf3841f70f1f2549f79
> b91bbb4 Merge 4245: librbd: snap_remove should ignore -ENOENT errors 62=
45bed Merge 4206: librbd: acquire cache_lock before refreshing parent
> ef08aa9 Merge 4185: FAILED assert(soid < scrubber.start || soid >=3D sc=
rubber.end) ae1b18a Merge 3963: Rados.shutdown() dies with Illegal instru=
ction (core dumped) 056db0f Merge 4385: osd: ENOENT on clone
> e4b1fd1 Merge 4384: pg stuck stale after create with activation delay 5=
97124b Merge 4383: erasure-code-profile set races with erasure-code-profi=
le rm
> b7bbd43 Merge 4382: osd/PGLog.h: 279: FAILED assert(log.log.size() =3D=3D=
 log_keys_debug.size())
>=20
> Ouf ot these, three are backports ready to be reviewed by their origina=
l authors:
>=20
> 056db0f Merge 4385: osd: ENOENT on clone https://github.com/ceph/ceph/p=
ull/4385
> e4b1fd1 Merge 4384: pg stuck stale after create with activation delay h=
ttps://github.com/ceph/ceph/pull/4384
> b7bbd43 Merge 4382: osd/PGLog.h: 279: FAILED assert(log.log.size() =3D=3D=
 log_keys_debug.size())
>=20
> The simplest way would be to ask for their review with a comment in the=
 pull request, with a reference to the test suite results so they know it=
 passed the suites. Will you have time to do this today ? If you don't ha=
ve time, just let me know and I'll do it for you.
>=20
> Cheers
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=
=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=
=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UvtRx61Dvqnq66oGGrDn1mRNdjjUNeNcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU+G6QACgkQ8dLMyEl6F21chgCglC95yNJuoXTnAMxfMWMRbZQt
KOgAnA1+R7E44FNVFPws4bjtMDp2aCPs
=eWfj
-----END PGP SIGNATURE-----

--UvtRx61Dvqnq66oGGrDn1mRNdjjUNeNcX--
