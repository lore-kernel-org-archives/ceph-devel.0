From: Loic Dachary <loic@dachary.org>
Subject: Re: Use of YAML for defining complex tests (or Python...?)
Date: Tue, 05 May 2015 14:15:57 +0200
Message-ID: <5548B47D.5000706@dachary.org>
References: <5548AAE9.2000302@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PxHal3UAk8FAjUhejQultar1Fg5NkGG0j"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57778 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422778AbbEEMQA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 08:16:00 -0400
In-Reply-To: <5548AAE9.2000302@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, Samuel Just <sjust@redhat.com>, Zack Cerza <zcerza@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PxHal3UAk8FAjUhejQultar1Fg5NkGG0j
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/05/2015 13:35, John Spray wrote:> Hi,
>=20
> I noted with interest the rather complex .yaml file in this PR:
> https://github.com/ceph/ceph-qa-suite/pull/428/files
>=20
> ...with the accompanying addition of loop constructs in this PR:
> https://github.com/ceph/teuthology/pull/481
>=20
> Teuthology YAML files appear to be at risk of becoming a fully fledged =
scripting language.  Why not write python scripts instead, for the more c=
omplex tests (e.g. anything that would need the full_sequential or loop c=
onstructs)?

I guess we should be careful to not abuse YAML where scripts would be mor=
e appropriate. I tend to agree with you: singleton-nomsgr/all/11429.yaml =
should be a script.

My 2cts

>=20
> On the cephfs side, we hit the point where test procedures were complex=
 enough to need their own mini-framework inside tasks/cephfs -- a similar=
 structure could be useful for people working on other subsystems as well=
=2E
>=20
> Cheers,
> John
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--PxHal3UAk8FAjUhejQultar1Fg5NkGG0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVItH0ACgkQ8dLMyEl6F20ABACgoqgD7woG0YedW1hxvmtjDhEo
gbcAn0RTrf5ong1aXVlpwo+hy/hoNqVa
=ZypV
-----END PGP SIGNATURE-----

--PxHal3UAk8FAjUhejQultar1Fg5NkGG0j--
