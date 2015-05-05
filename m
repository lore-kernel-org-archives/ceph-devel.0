From: Loic Dachary <loic@dachary.org>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Tue, 05 May 2015 11:25:36 +0200
Message-ID: <55488C90.5090302@dachary.org>
References: <55362279.5060105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jvXJUoC3JVMJorRJHLqwTb7bQSt9Udnfi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57614 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031381AbbEEJZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 05:25:39 -0400
In-Reply-To: <55362279.5060105@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvXJUoC3JVMJorRJHLqwTb7bQSt9Udnfi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Unless I'm mistaken it looks like

http://tracker.ceph.com/issues/11429 OSD::load_pgs: we need to handle the=
 case where an upgrade from earlier versions which ignored non-existent p=
gs resurrects a pg with a prehistoric osdmap

deserves to be in the next release. With this one, do you think v0.80.10 =
should be published ? There was concerns about ceph_objectstore_tools and=
 thrashing but my understanding is that the nightlies ran enough tests in=
 the past two weeks to clear that.

If there is not enough incentive to publish v0.80.10 at the moment we can=
 proceed with another batch of backports (about 10 of them pending) and t=
est them.

Cheers

On 21/04/2015 12:12, Loic Dachary wrote:
> Hi Sage,
>=20
> The firefly branch has a number of fixes ( http://tracker.ceph.com/issu=
es/11090#Release-information ) and has been used for upgrade tests in the=
 past few weeks. A few other issues have been backported since and are be=
ing tested in the integration branch ( http://tracker.ceph.com/issues/110=
90#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f79-integrat=
ion-branch-april-2015 ).=20
>=20
> Do you think these changes deserve a firefly v0.80.10 release ? Should =
we ask each lead for their approval ? Or is it better to keep backporting=
 what needs to be and wait a few weeks ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--jvXJUoC3JVMJorRJHLqwTb7bQSt9Udnfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVIjJAACgkQ8dLMyEl6F23zwQCgvqKI6gL9vrOexSTaOSFxTqxM
V44Ani+yRYBetettyx/QC6jposaCmK9/
=ecF4
-----END PGP SIGNATURE-----

--jvXJUoC3JVMJorRJHLqwTb7bQSt9Udnfi--
