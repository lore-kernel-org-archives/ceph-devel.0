From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next hammer release v0.94.4
Date: Tue, 13 Oct 2015 00:56:56 +0200
Message-ID: <561C3AB8.2090808@dachary.org>
References: <560EE98C.5090202@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="diEbO2lXIhqm6FDsfnolQOEv7V55dcRWP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41649 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750834AbbJLW46 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 18:56:58 -0400
In-Reply-To: <560EE98C.5090202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--diEbO2lXIhqm6FDsfnolQOEv7V55dcRWP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After todays private discussion and the merge of https://github.com/ceph/=
ceph/pull/6161, I will assume the current hammer branch (7f485ed5aa620fe9=
82561663bf64356b7e2c38f2) is ready for QE to start their own round of tes=
ting. If I misinterpreted what you wrote, please speak up and I'll do wha=
t's needed ;-)

Cheers

On 02/10/2015 22:31, Loic Dachary wrote:
> Hi Yehuda,
>=20
> The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the rgw suite (http://tracker.ceph.com/issues/12701#note-58)=
=2E=20
> Do you think the hammer branch is ready for QE to start their own round=
 of testing ?
>=20
> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/12701#Release-information has direc=
t links to the pull requests merged into hammer since v0.94.3 in case you=
 need more context about one of them.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--diEbO2lXIhqm6FDsfnolQOEv7V55dcRWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYcOrgACgkQ8dLMyEl6F20bYACdHTHNsNqcIdLtG9dVEDtkYMia
u8kAoIm1r9HuBCxsoN3FmM0urIoYPC/s
=eGvq
-----END PGP SIGNATURE-----

--diEbO2lXIhqm6FDsfnolQOEv7V55dcRWP--
