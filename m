From: Loic Dachary <loic@dachary.org>
Subject: Re: CentOS 7 yum-builddep fails on %if
Date: Wed, 25 Mar 2015 21:51:09 +0100
Message-ID: <55131FBD.40509@dachary.org>
References: <5512F699.3000206@dachary.org> <55130078.4040908@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qFG2aHACoKEVbD9xtmcjSdXmgKxqTcr53"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36665 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750764AbbCYUvN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Mar 2015 16:51:13 -0400
In-Reply-To: <55130078.4040908@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qFG2aHACoKEVbD9xtmcjSdXmgKxqTcr53
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/03/2015 19:37, Ken Dreyer wrote:
> On 03/25/2015 11:55 AM, Loic Dachary wrote:
>> Hi Ken,
>=20
>> yum-builddep fails on CentOS 7 on the latest ceph.spec.in with the
>> following error:
>=20
>> error: parse error in expression error:
>> /tmp/install-deps.52/ceph.spec:50: bad %if condition Bad spec:
>> /tmp/install-deps.52/ceph.spec
>=20
>> which is
>=20
>> %if 0%{_with_systemd}
>=20
>> https://github.com/ceph/ceph/blob/master/ceph.spec.in#L50
>=20
>> It looks good to me though. Any idea why it happens ?
>=20
>> Cheers
>=20
>=20
> As we discussed in #ceph-devel this afternoon, the problem was a
> syntax error in my RPM conditionals. The fix is in
> https://github.com/ceph/ceph/pull/4181

Thanks for the quick fix. I learnt one more thing about spec files today =
;-)

Cheers

>=20
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--qFG2aHACoKEVbD9xtmcjSdXmgKxqTcr53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUTH70ACgkQ8dLMyEl6F20oYQCfcU6TCAyV8gCzxCF6PiWIXyyn
Au0An2ANesvXiNQeS2bKW6ikq7UZsAwD
=oHbT
-----END PGP SIGNATURE-----

--qFG2aHACoKEVbD9xtmcjSdXmgKxqTcr53--
