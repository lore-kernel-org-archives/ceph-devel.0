From: Loic Dachary <loic@dachary.org>
Subject: Re: timeout 120 teuthology-killl is highly recommended
Date: Tue, 21 Jul 2015 18:42:12 +0200
Message-ID: <55AE7664.5050609@dachary.org>
References: <55AE6F90.3070503@dachary.org> <1312196360.1870726.1437496406379.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AW1jUVVpavB2Pj8SA4ciaaCHktiE4MICM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53798 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755557AbbGUQmQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:42:16 -0400
In-Reply-To: <1312196360.1870726.1437496406379.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AW1jUVVpavB2Pj8SA4ciaaCHktiE4MICM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg & Yuri : I stand corrected, I should have been less affirmative on a=
 topic I know little about. Thanks !

On 21/07/2015 18:33, Yuri Weinstein wrote:
> Loic
>=20
> I don't use teuthology-kill simultaneously only sequentially.
> As far as run time, just as a note, when we use 'stale' arg and it invo=
kes ipmitool interface it does take awhile to finish.=20
>=20
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, July 21, 2015 9:13:04 AM
> Subject: timeout 120 teuthology-killl is highly recommended
>=20
> Hi Ceph,
>=20
> Today I did something wrong and that blocked the lab for a good half ho=
ur.=20
>=20
> a) I ran two teuthology-kill simultaneously and that makes them deadloc=
k each other
> b) I let them run unattended only to come back to the terminal 30 minut=
es later and see them stuck.
>=20
> Sure, two teuthology-kill simultaneously should not deadlock and that n=
eeds to be fixed. But the easy workaround to avoid that trouble is to jus=
t not let it run forever. Even for ~200 jobs it takes at most a minute or=
 two. And if it takes longer it probably means another teuthology-kill co=
mpetes and it should be interrupted and restarted later. From now on I'll=
 do
>=20
> timeout 120 teuthology-kill .... || echo FAIL!
>=20
> as a generic safeguard.
>=20
> Apologies for the troubles.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--AW1jUVVpavB2Pj8SA4ciaaCHktiE4MICM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWudmQACgkQ8dLMyEl6F22wKgCfYFNJnbUQYT0a8PlJlD61Sr4w
x5kAn2PnCMeHaqAmFYlONNtOVXJdJhEH
=5WLb
-----END PGP SIGNATURE-----

--AW1jUVVpavB2Pj8SA4ciaaCHktiE4MICM--
