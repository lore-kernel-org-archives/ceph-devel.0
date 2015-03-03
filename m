From: Loic Dachary <loic@dachary.org>
Subject: Re: paddles query
Date: Tue, 03 Mar 2015 02:17:59 +0100
Message-ID: <54F50BC7.2080903@dachary.org>
References: <54F1DD70.2000909@dachary.org> <1382449859.14137686.1425326349225.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UxMQe0P28NU2iACBPOVQrUgNrij9iPmea"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51767 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753730AbbCCBSB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 20:18:01 -0500
In-Reply-To: <1382449859.14137686.1425326349225.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UxMQe0P28NU2iACBPOVQrUgNrij9iPmea
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/03/2015 20:59, Zack Cerza wrote:
> Hey Loic,
>=20
> I gave an example in the ticket you filed (http://tracker.ceph.com/issu=
es/10945#note-3) , but here it is again for posterity:
> http://paddles.front.sepia.ceph.com/runs/teuthology-2015-03-01_23:18:01=
-multimds-hammer-testing-basic-multi/jobs/?status=3Dfail

Great. I'll figure out the jq expression to create a onliner. We're getti=
ng close !

Cheers

>=20
> Zack
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Zack Cerza" <zack@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 28, 2015 8:23:28 AM
> Subject: paddles query
>=20
> Hi Zack,
>=20
> Is there a way to ask paddles / pulpito ( http://pulpito.ceph.com/ ) fo=
r the list of failed/dead jobs in a given suite ? Here is a fiction examp=
le:
>=20
> $ paddles --failed-or-dead http://pulpito.ceph.com/loic-2015-02-28_11:4=
5:50-fs-firefly-backports---basic-multi/
> http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports--=
-basic-multi/783076
> http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports--=
-basic-multi/783102
> http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports--=
-basic-multi/783093
>=20
> I would like to then grep 'description:' from the corresponding teuthol=
ogy.log and re-schedule those corresponding to environment failures with =
teuthology-suite --filter ( as in http://tracker.ceph.com/issues/10945#no=
te-1 ). If you have a better way to achieve that, please let me know ;-)
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UxMQe0P28NU2iACBPOVQrUgNrij9iPmea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT1C8cACgkQ8dLMyEl6F21UpgCgvHqjA4c6cKt3WCL2pP1kSpSl
qLsAoIHeQY92pHo45Lzc9VPYAslEuxU1
=dehv
-----END PGP SIGNATURE-----

--UxMQe0P28NU2iACBPOVQrUgNrij9iPmea--
