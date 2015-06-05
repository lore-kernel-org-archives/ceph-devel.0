From: Loic Dachary <loic@dachary.org>
Subject: Re: Substriping support in ErasureCodeInterface
Date: Fri, 05 Jun 2015 14:40:07 +0200
Message-ID: <557198A7.5040805@dachary.org>
References: <CAA-SLH9NNinYZO2iev5nYnTfR+va73-UNh7GnwAroSjtxCot0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QfTfoctCst8B3dMAsiD9k380dAfvopa1A"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56882 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751542AbbFEMkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 08:40:09 -0400
In-Reply-To: <CAA-SLH9NNinYZO2iev5nYnTfR+va73-UNh7GnwAroSjtxCot0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sindre Stene <sindrestene@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QfTfoctCst8B3dMAsiD9k380dAfvopa1A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/06/2015 14:02, Sindre Stene wrote:
> Is there, or is there planned support for substriping/subpacket support=
 in ErasureCodeInterface ?

Not at the moment.

> Clarification; I am looking for a way to test a different erasure codin=
g scheme, that (in addition to having multiple stripes) has substripes wi=
thin those stripes, letting us further reduce the amount of chunks retrie=
ved from the HDD. I have an implementation ready in C for the encoder/dec=
oder etc. I am looking to plug that into Ceph through the ErasureCodeInte=
rface.

https://github.com/ceph/ceph/blob/master/src/erasure-code/ErasureCodeInte=
rface.h

> The principles involved (which I am sure you are familiar with) are sim=
ilar to https://research.facebook.com/publications/1445994382319911/a-hit=
chhiker-s-guide-to-fast-and-efficient-data-reconstruction-in-erasure-code=
d-data-centers/ , but with more substripes (>4, < 256).

There is a declaration of intent for an hitchhiker plugin at http://track=
er.ceph.com/issues/11268 but there is no progress yet.

> Can it currently be done without having to modify the Ceph code base ? =
(I am looking at master on ceph/ceph, and it seems to not be possible).
> Could I ask you to link me to the appropriate issue tracker / Jira / fo=
rum, if there is development going on already towards this goal?=20

Why do you think the current interface is insufficient ? What would you n=
eed in addition ?

Cheers

>=20
> Sincerely,
> Sindre B. Stene

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QfTfoctCst8B3dMAsiD9k380dAfvopa1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVxmKcACgkQ8dLMyEl6F22k7gCcDUhRvi3DSlB7g+euLrrNscNF
Tw4An14BQ98pdb+oTOMKwfxERwkmISxp
=h8Q5
-----END PGP SIGNATURE-----

--QfTfoctCst8B3dMAsiD9k380dAfvopa1A--
