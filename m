From: Loic Dachary <loic@dachary.org>
Subject: Re: Teuthology Integration to native openstack
Date: Sun, 27 Sep 2015 22:17:34 +0200
Message-ID: <56084EDE.9050005@dachary.org>
References: <D22E3F64.15AF%bkrishna@walmartlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7RDpnfedNbagNpJQo6L3uXLwX0kmEpMuB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33657 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750991AbbI0URl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Sep 2015 16:17:41 -0400
In-Reply-To: <D22E3F64.15AF%bkrishna@walmartlabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bharath Krishna <BKrishna@walmartlabs.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7RDpnfedNbagNpJQo6L3uXLwX0kmEpMuB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

[moving to ceph-devel]

Hi,

On 27/09/2015 21:20, Bharath Krishna wrote:
> Hi,
>=20
> We have an openstack deployment in place with CEPH as CINDER backend.
>=20
> We would like to perform functional testing for CEPH and found teutholo=
gy as recommended option.
>=20
> Have successfully installed teuthology. Now to integrate it with Openst=
ack, I could see that the possible providers could be either OVH, REDHAT =
or ENTERCLOUDSITE.
>=20
> Is there any option where in we can source openstack deployment of our =
own and test CEPH using teuthology?

The documentation mentions these providers because they have been tested.=
 But there should be no blocker to run teuthology against a regular OpenS=
tack provider. Should you run into troubles, please let me know and I'll =
help.

Cheers

>=20
> If NO, please suggest on how to test CEPH in such scenarios?
>=20
> Please help.
>=20
> Thank you.
> Bharath Krishna
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--7RDpnfedNbagNpJQo6L3uXLwX0kmEpMuB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYITt4ACgkQ8dLMyEl6F239dwCgpBpLrvqjoZE8fEfceaFRRqkM
w9IAoKTD95nKJSmG5i5xyklr279ktCti
=yIQb
-----END PGP SIGNATURE-----

--7RDpnfedNbagNpJQo6L3uXLwX0kmEpMuB--
