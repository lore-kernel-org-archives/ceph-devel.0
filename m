From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Thu, 12 Feb 2015 23:17:49 +0100
Message-ID: <54DD268D.7050904@dachary.org>
References: <54DA3A5B.5050509@dachary.org> <1520027977.15929683.1423693473209.JavaMail.zimbra@redhat.com> <1586599856.17187011.1423778777774.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GVAQg6UcKQA9vReXwM7WP7taahnFv1CPV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43366 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751831AbbBLWRx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 17:17:53 -0500
In-Reply-To: <1586599856.17187011.1423778777774.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Tamil Muthamizhan <tmuthami@redhat.com>, Zack Cerza <zack@redhat.com>, Sandon Van Ness <svanness@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GVAQg6UcKQA9vReXwM7WP7taahnFv1CPV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/02/2015 23:06, Yuri Weinstein wrote:
> I linked all issues related to this release testing to the ticket http:=
//tracker.ceph.com/issues/10560
>=20
> After the team leads make a call of those, including environment issues=
, I suggest re-running suites the failed again.
>=20
> Loic, I'd re-run them in the Octo, since we already started there, if y=
ou agree ?

Sure :-)

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Yuri Weinstein" <yweinste@redhat.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sage@=
redhat.com>, "Tamil Muthamizhan" <tmuthami@redhat.com>
> Sent: Wednesday, February 11, 2015 2:24:33 PM
> Subject: Re: dumpling integration branch for v0.67.12 ready for QE
>=20
> I replied to individual suites runs, but just wanted to summarize QE va=
lidation status.
>=20
> The following suites were executed in the Octo lab (we will use Sepia i=
n the future if nobody objects).
>=20
> upgrade:dumpling
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45493']
> http://tracker.ceph.com/issues/10694 - Known "Won't fix"
> "Assertion: osd/Watch.cc: 290: FAILED assert(!cb)"
>=20
> *** Sam - pls confirm the "Won't fix" status.
>=20
> ['45495', '45496', '45498', '45499', '45500']
> http://tracker.ceph.com/issues/10838
> "s3tests failed"
>=20
> *** Yehuda - need your verdict on s3tests.
>=20
> fs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> All green !
>=20
> rados
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45054']
> http://tracker.ceph.com/issues/10841
> "Issued certificate has expired"=20
> *** Sandon pls comment.
>=20
> ['45168', '45169']
> http://tracker.ceph.com/issues/10840
> coredump "ceph_test_filestore_idempotent_sequence"
> *** Sam - pls comment
>=20
> ['45215']
> Missing packages - no ticket FYI
> "Failed to fetch http://apt-mirror.front.sepia.ceph.com/archive.ubuntu.=
com/ubuntu/dists/trusty-updates/universe/binary-i386/Packages  Hash Sum m=
ismatch"
>=20
> *** Zack, Sandon ?
>=20
> ceph-deploy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Travis - pls suggest
> In general I am not sure if we needed to test this - Sage?
>=20
> rbd
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45365', '45366', '45367']
> http://tracker.ceph.com/issues/10842
> "unable to connect to apt-mirror.front.sepia.ceph.com"
>=20
> ['45349', '45350', '45351', '45355', '45356', '45357', '45363']
> http://tracker.ceph.com/issues/10802
> "error: image still has watchers"=20
> (duplicate of 10680)
>=20
> *** Zack, Sandon, Josh - all environment noise, pls comment.=20
>=20
> rgw
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45382', '45390']
> http://tracker.ceph.com/issues/10843
> "s3tests failed" - could be related or duplicate of 10838
>=20
> *** Yehuda - same as issues in upgrades?
>=20
> I am standing by for you analysis/replies and recommendations for next =
steps.
>=20
> Loic - let me know is you want to follow specific items in our backport=
 testing process that I missed here.
> PS:  I would think that you could've wanted to assign the release ticke=
t to QE (me) for validation and at this point I could've re-assigned it b=
ack to devel (you), a?
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 9:05:31 AM
> Subject: dumpling integration branch for v0.67.12 ready for QE
>=20
> Hi Yuri,
>=20
> The dumpling integration branch for v0.67.12 as found at https://github=
=2Ecom/ceph/ceph/commits/dumpling-backports has been approved by Yehuda, =
Josh and Sam and is ready for QE.=20
>=20
> For the record, the head is https://github.com/ceph/ceph/commit/3944c77=
c404c4a05886fe8276d5d0dd7e4f20410
>=20
> I think it would be best for the QE tests to use the dumpling-backports=
=2E The alternative would be to merge dumpling-backports into dumpling. H=
owever, since testing may take a long time and require more patches, it p=
robably is better to not do that iterative process on the dumpling branch=
 itself. As it is now, there already are a number of commits in the dumpl=
ing branch that should really be in the dumpling-backports: they do not b=
elong to v0.67.11 and are going to be released in v0.67.12. In the future=
 though, the dumpling branch will only receive commits that have been car=
efully tested and all the integration work will be on the dumpling-backpo=
rts branch exclusively. So that third parties do not have to worry that t=
he dumpling branch contains commits that have not been tested yet.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--GVAQg6UcKQA9vReXwM7WP7taahnFv1CPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTdJo0ACgkQ8dLMyEl6F23I+ACdGdcAqLH4Fb3jYMfQy3R2lQkp
MgAAoJSG6/77u9w6sqvO5W/K8ey63yJv
=yoVV
-----END PGP SIGNATURE-----

--GVAQg6UcKQA9vReXwM7WP7taahnFv1CPV--
