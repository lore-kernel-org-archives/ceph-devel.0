From: Loic Dachary <loic@dachary.org>
Subject: Re: creation of the puppet-ceph repository
Date: Mon, 16 Dec 2013 20:47:39 +0100
Message-ID: <52AF58DB.4070502@dachary.org>
References: <52AC97E2.8080907@dachary.org> <CED3B77C.1F7CF%ian.colle@inktank.com> <52AF56D9.9040005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0Dm8eJuT4In4BVqWsKQf4CwUqB8MLQ0UF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41973 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704Ab3LPTrm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 14:47:42 -0500
In-Reply-To: <52AF56D9.9040005@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Colle <ian.colle@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Dm8eJuT4In4BVqWsKQf4CwUqB8MLQ0UF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 16/12/2013 20:39, Loic Dachary wrote:
> Hi Ian,
>=20
> It looks like nothing at all was created after all, not even the reposi=
tory. Or maybe I don't understand how github works.
>=20
> $ git push puppet-ceph master
> ERROR: Permission to ceph/puppet-ceph.git denied to dachary.
> fatal: Could not read from remote repository.

$ git remote -v
gerrit	ssh://dachary@review.openstack.org:29418/stackforge/puppet-ceph.gi=
t (fetch)
gerrit	ssh://dachary@review.openstack.org:29418/stackforge/puppet-ceph.gi=
t (push)
origin	https://github.com/stackforge/puppet-ceph.git (fetch)
origin	https://github.com/stackforge/puppet-ceph.git (push)
puppet-ceph	git@github.com:ceph/puppet-ceph.git (fetch)
puppet-ceph	git@github.com:ceph/puppet-ceph.git (push)

>=20
> Please make sure you have the correct access rights
> and the repository exists.
>=20
> Could you please re-create it and add a README ? I should be able to ge=
t rid of it afterwards.
>=20
> Thank you for your patience
>=20
> On 16/12/2013 04:46, Ian Colle wrote:
>>
>>
>> On 12/14/13, 9:39 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>
>>> Hi,
>>>
>>> Could someone with sufficient permission please create the puppet-cep=
h
>>> repository (empty, no README or .gitignore) at http://github.com/ceph=
/ ?
>>
>> Done.
>>
>> https://github.com/ceph/puppet-ceph
>>
>>
>>>
>>> A few weeks ago it was decided to host the development of the module =
on
>>> stackforge ( https://github.com/stackforge/puppet-ceph ) and also to
>>> establish a mirror under the ceph github namespace.
>>>
>>> Cheers
>>>
>>> --=20
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--0Dm8eJuT4In4BVqWsKQf4CwUqB8MLQ0UF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKvWNsACgkQ8dLMyEl6F23yDQCgoXpJxpSc6J2R3zU7aDPOh0Qk
kCoAoJHskNXMpeBE5GhNo05A1XuKAUYK
=YxmS
-----END PGP SIGNATURE-----

--0Dm8eJuT4In4BVqWsKQf4CwUqB8MLQ0UF--
