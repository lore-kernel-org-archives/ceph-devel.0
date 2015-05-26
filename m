From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Tue, 26 May 2015 18:25:25 +0200
Message-ID: <55649E75.20802@dachary.org>
References: <5559DE24.4010601@dachary.org> <1094270224.6326426.1432656826948.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="k1reWdnFp2gsQsgU13mrol7Eus7NMN021"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51129 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751043AbbEZQZ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 12:25:28 -0400
In-Reply-To: <1094270224.6326426.1432656826948.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k1reWdnFp2gsQsgU13mrol7Eus7NMN021
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

If I'm not mistaken http://tracker.ceph.com/issues/11660 is the last issu=
e blocking v0.94.2. Is there another one I don't see ?

Cheers

On 26/05/2015 18:13, Yuri Weinstein wrote:
> Loic
>=20
> This hammer release QE validation is taking unusually long time and has=
 issues that has to be clarified.=20
>=20
> All test results were summarized in http://tracker.ceph.com/issues/1149=
2
>=20
> There are several reasons contributing to slowness of this validation, =
product related as well as infrastructure related, also high amount of te=
sts make turn around time slower as well.
>=20
> I think some suites, e.g. rados and upgrades for example will have to b=
e re-run after issues had been clarified/fixed.
>=20
> rados, krbd, knfs, samba suite test results need reviews by the team le=
ads.
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


--k1reWdnFp2gsQsgU13mrol7Eus7NMN021
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVknnUACgkQ8dLMyEl6F22KZQCgpZxfjGHV3yUmrF+5KCd2kcUm
p8YAnimAEUNotihkiDVj2qGs1jnD3JZH
=5EqW
-----END PGP SIGNATURE-----

--k1reWdnFp2gsQsgU13mrol7Eus7NMN021--
