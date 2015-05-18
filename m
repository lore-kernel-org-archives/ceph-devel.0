From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Mon, 18 May 2015 17:33:32 +0200
Message-ID: <555A064C.9070905@dachary.org>
References: <5559DE24.4010601@dachary.org> <792948484.778464.1431962588587.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PX77knbJnCnIsPiSKkilC1afqonJI1Dhq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37175 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932184AbbERPdf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 11:33:35 -0400
In-Reply-To: <792948484.778464.1431962588587.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PX77knbJnCnIsPiSKkilC1afqonJI1Dhq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 18/05/2015 17:23, Yuri Weinstein wrote:
> Loic
>=20
> Thanks for the update.
>=20
> There were some issues logged over weekend that were not noted in http:=
//tracker.ceph.com/issues/11492
>=20
> http://tracker.ceph.com/issues/11661
> http://tracker.ceph.com/issues/11660

Are they specific to hammer ?

> environment related:
>=20
> http://tracker.ceph.com/issues/11546
> http://tracker.ceph.com/issues/11659
> http://tracker.ceph.com/issues/11662
>=20
> Also, I see rgw latest run with 27 failures http://pulpito.ceph.com/teu=
thology-2015-05-12_17:42:50-rgw-hammer-distro-basic-multi/

All of which because of environmental problems:

 Failed to fetch package version from http://gitbuilder.ceph.com/ceph-deb=
-precise-x86_64-notcmalloc/sha1/b69fb89122d6f989152a29124cc7ed54b5e4d43b/=
version

Cheers

>=20
> I will continue QE validation meanwhile.
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <abhi=
shek.lekshmanan@gmail.com>
> Sent: Monday, May 18, 2015 5:42:12 AM
> Subject: hammer branch for v0.94.2 ready for QE
>=20
> Hi Yuri,
>=20
> The hammer branch for v0.94.2 as found at https://github.com/ceph/ceph/=
commits/hammer has been approved by Greg, Yehuda, Josh and Sam and is rea=
dy for QE. For the record, the head is https://github.com/ceph/ceph/commi=
t/63832d4039889b6b704b88b86eaba4aadcfceb2e and the details of the tests r=
un are at http://tracker.ceph.com/issues/11492
>=20
> Note that it has two more commits compared to what you tested before:
>=20
> https://github.com/ceph/ceph/commit/293affe992118ed6e04f685030b2d83a794=
ca624 fixing http://tracker.ceph.com/issues/11622
> https://github.com/ceph/ceph/commit/a43d24861089a02f3b42061e482e05016a0=
021f6 fixing http://tracker.ceph.com/issues/11604
>=20
> which address two blockers that you listed at http://tracker.ceph.com/i=
ssues/11492#QE-Validation
>=20
> These two new commits only have influence, directly or indirectly, on r=
gw. They do not require or deserve a new run of the rados, fs or rbd suit=
e because none of them depend on rgw, directly or indirectly.
>=20
> The other two issues listed as blockers are
>=20
> http://tracker.ceph.com/issues/11613#note-4 do not need a backport to h=
ammer
> http://tracker.ceph.com/issues/11591 is a teuthology related issue that=
 can be worked around and does not need to be a blocker for hammer
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--PX77knbJnCnIsPiSKkilC1afqonJI1Dhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVaBkwACgkQ8dLMyEl6F23Y6QCcDcPiUj0kWotkXKkg9Oi6nP4C
QOAAoKq7f3KeKwXNqEGGRhvKSIbgya2A
=bH80
-----END PGP SIGNATURE-----

--PX77knbJnCnIsPiSKkilC1afqonJI1Dhq--
