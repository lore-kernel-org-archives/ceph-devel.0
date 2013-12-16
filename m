From: Loic Dachary <loic@dachary.org>
Subject: Re: creation of the puppet-ceph repository
Date: Mon, 16 Dec 2013 20:39:05 +0100
Message-ID: <52AF56D9.9040005@dachary.org>
References: <52AC97E2.8080907@dachary.org> <CED3B77C.1F7CF%ian.colle@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NEJPPXNHT1He3fI46hfMpWNH5gq866M3J"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41968 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab3LPTkB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 14:40:01 -0500
In-Reply-To: <CED3B77C.1F7CF%ian.colle@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Colle <ian.colle@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NEJPPXNHT1He3fI46hfMpWNH5gq866M3J
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ian,

It looks like nothing at all was created after all, not even the reposito=
ry. Or maybe I don't understand how github works.

$ git push puppet-ceph master
ERROR: Permission to ceph/puppet-ceph.git denied to dachary.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

Could you please re-create it and add a README ? I should be able to get =
rid of it afterwards.

Thank you for your patience

On 16/12/2013 04:46, Ian Colle wrote:
>=20
>=20
> On 12/14/13, 9:39 AM, "Loic Dachary" <loic@dachary.org> wrote:
>=20
>> Hi,
>>
>> Could someone with sufficient permission please create the puppet-ceph=

>> repository (empty, no README or .gitignore) at http://github.com/ceph/=
 ?
>=20
> Done.
>=20
> https://github.com/ceph/puppet-ceph
>=20
>=20
>>
>> A few weeks ago it was decided to host the development of the module o=
n
>> stackforge ( https://github.com/stackforge/puppet-ceph ) and also to
>> establish a mirror under the ceph github namespace.
>>
>> Cheers
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NEJPPXNHT1He3fI46hfMpWNH5gq866M3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKvVtkACgkQ8dLMyEl6F22lTQCfRBGTS7CrZu+UcI4eNqBE2UXf
BjEAnilBFttqC3ZhcwtrGYDGcBhlvGjL
=bme/
-----END PGP SIGNATURE-----

--NEJPPXNHT1He3fI46hfMpWNH5gq866M3J--
