From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Wed, 27 May 2015 23:16:18 +0200
Message-ID: <55663422.1000900@dachary.org>
References: <5559DE24.4010601@dachary.org> <694044148.7711595.1432761176105.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OJhAPbTQiMjoiud7JijuSp7opwvdUbRnM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52022 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064AbbE0VQV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 17:16:21 -0400
In-Reply-To: <694044148.7711595.1432761176105.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OJhAPbTQiMjoiud7JijuSp7opwvdUbRnM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27/05/2015 23:12, Yuri Weinstein wrote:
> QE validation status.
>=20
> All detailed information is summarized in http://tracker.ceph.com/issue=
s/11492
>=20
> Team leads pls review for do "go"-"no-go" decision.
>=20
> Issues to be considered:
>=20
> rados - passed ~2.8K jobs, listed issues (#11660, #11661) are not block=
ers=20
> (NOTE: we also agreed to use the "0/7th" rule for future point releases=
, e.g. passing "--subset 0/7" will be sufficient for release)
>=20
> knfs - #11789, #11790 - per Sage - not blockers; Greg, John - agreed?
>=20
> samba - I assumed that failured in http://pulpito.ceph.com/teuthology-2=
015-05-18_13:46:55-samba-hammer-testing-basic-multi/ due to #6613, Greg p=
ls confirm.
>=20
> upgrade/client-upgrade - blocked by #11546 (3 jobs passed)
> upgrade/firefly-x - blocked by #11546
> upgrade/dumpling-firefly-x - blocked by #11546
>=20
> Sage, Loic are you willing to push this release out without upgrade sui=
tes run due to packaging issues (NOTE: upgrade/giant-x -> hammer passed o=
n all distros)?

IMHO there should at least be a run that involves installing packages on =
all distributions for which #11546 is a blocker (all debs).

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


--OJhAPbTQiMjoiud7JijuSp7opwvdUbRnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVmNCIACgkQ8dLMyEl6F21OHwCfRDwUXNiqFG0evEw+/xByN20m
sDoAoLRkAIIOqONNBCg9d+/7maaQKMsi
=j9xe
-----END PGP SIGNATURE-----

--OJhAPbTQiMjoiud7JijuSp7opwvdUbRnM--
