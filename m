From: Loic Dachary <loic@dachary.org>
Subject: Re: About the Ceph erasure pool with ISA plugin on Intel xeon CPU
Date: Thu, 06 Aug 2015 14:31:02 +0200
Message-ID: <55C35386.6070602@dachary.org>
References: <CAKEOLWVxuURSgYP3FLRhHs=THuYK0Qy084hNxZAqERyAYy2J4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KagFVWc8VV0qeEPMvLa2OK09pdg9J5UtU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34321 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755500AbbHFMbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 08:31:07 -0400
In-Reply-To: <CAKEOLWVxuURSgYP3FLRhHs=THuYK0Qy084hNxZAqERyAYy2J4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Su <dereksu@qnap.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KagFVWc8VV0qeEPMvLa2OK09pdg9J5UtU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Could you please publish the benchmark results somewhere ? I should be ab=
le to figure out why you don't see a difference.

Cheers

On 06/08/2015 13:25, Derek Su wrote:
> Dear Mr. Dachary and all,
>=20
> Recently, I found your blog show the performance tests of erasure
> pools (http://dachary.org/?p=3D3042 , http://dachary.org/?p=3D3665).
> The results indicates the write throughput can be enhanced
> significantly using Intel xeon CPU.
>=20
> I tried to create an erasure pool with isa plugin, reed_sol_van
> technique, and k/m=3D4/2 on the Intel(R) Xeon(R) CPU E3-1245 v3 @
> 3.40GHz machines.
>=20
> However, the results of the rados benchmark showed that there was no
> any difference between the jerasure and isa plugins. It seems very
> strange.
>=20
> Do I need to do other configurations in addition to only setting the
> erasure profile?
> In addition, how can I know the erasure pool is accelerated by ISA
> plugin exactly? Is there any command I can use?
>=20
> Thanks, :)
>=20
> Derek Su.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--KagFVWc8VV0qeEPMvLa2OK09pdg9J5UtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXDU4YACgkQ8dLMyEl6F23qswCgtZu9Bx9RJO1ZGzYjdjM6SnhY
f4QAn0vAgzuFxrjXxhzL8MUbuTDNN4fG
=SmTD
-----END PGP SIGNATURE-----

--KagFVWc8VV0qeEPMvLa2OK09pdg9J5UtU--
