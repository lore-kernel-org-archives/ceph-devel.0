From: Loic Dachary <loic@dachary.org>
Subject: What crush ruleset for a given SHEC configuration ?
Date: Tue, 19 May 2015 08:38:39 +0200
Message-ID: <555ADA6F.7000702@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5FlRTtDqngwcccTPM4VRV0w37eIVdCQwM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37590 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755205AbbESGip (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 02:38:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5FlRTtDqngwcccTPM4VRV0w37eIVdCQwM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takeshi,

In the context of http://ceph.com/docs/master/rados/operations/erasure-co=
de-shec/ it would be useful to have a more detailed explanation of why SH=
EC is more efficient during recovery (in the introduction).=20

Am I correct to assume that SHEC does not provide a way to control the lo=
cality of the chunks ? For instance in the following scenario:

rack 1 has 10 OSDs
rack 2 has 10 OSDs

a crush ruleset is made to provide 15 OSDs with 7 in the first rack, 8 in=
 the last rack: the first 7 are in rack 1, the last 8 in rack 2. When SHE=
C is used with such a crush ruleset, it cannot guarantee that the loss of=
 one chunk in rack 2 can always be recovered with chunks from rack 2. Whe=
n reading at figure 3 of

https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code_%2=
8SHEC%29

with D1 to D5, P1 and P2 in rack 1 and D6 to D10, P3, P4, P5 in rack 2, m=
y understanding is that to recover D6 which is in rack 2 it may be necess=
ary to use P2 from rack 1. And to recover D5 which is in rack 1 it may be=
 necessary to use P3 from rack 2.

Maybe I'm missing something ? Thanks in advance for your explanations :-)=


Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5FlRTtDqngwcccTPM4VRV0w37eIVdCQwM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVa2m8ACgkQ8dLMyEl6F20SaQCfWFyehRKRDVLQ/nIhTg5vlHGf
jaUAn1uZzwKvhYxpCrwAIqggY3keSoYx
=LT/m
-----END PGP SIGNATURE-----

--5FlRTtDqngwcccTPM4VRV0w37eIVdCQwM--
