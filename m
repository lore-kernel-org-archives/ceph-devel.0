From: Loic Dachary <loic@dachary.org>
Subject: Re: Jerasure & Ceph
Date: Thu, 22 Aug 2013 18:32:59 +0200
Message-ID: <52163D3B.5050900@dachary.org>
References: <5214893A.2020005@dachary.org> <52163BD5.1040509@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBFF82E7A9C70E9AA7EC2ECAC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56836 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab3HVQdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 12:33:03 -0400
In-Reply-To: <52163BD5.1040509@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James S. Plank" <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBFF82E7A9C70E9AA7EC2ECAC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi James,

Thanks for the news and the manual :-)

https://bitbucket.org/allenmcbride/gf-complete-summer redirects to
https://bitbucket.org/allenmcbride/gf-complete-summer/wiki/Home which see=
ms empty. Am I missing something ?

If you are curious I started the jerasure ceph plugin based on jerasure-1=
=2E2A at

https://github.com/dachary/ceph/tree/wip-5879
https://github.com/dachary/ceph/commit/83845a66ae1cba63c122c0ef7658b97b47=
4c2bd2

and I should be done by the end of next week.

Cheers

On 22/08/2013 18:27, Loic Dachary wrote:
> James Plank reply:
>=20
> My new GF library called GF-complete is weeks away from being done.  Th=
e most recent version is https://bitbucket.org/allenmcbride/gf-complete-s=
ummer, and I doubt much of it will change between now and "release."  I'm=
 including the PDF of the manual, which I have edited up to section 7.7, =
so again, it's largely good to go -- the remaining changes are esoteric. =

>=20
> On 21/08/2013 11:32, Loic Dachary wrote:
>> Hi James,
>>
>> I'm working on adding jerasure as a plugin to Ceph. If I remember corr=
ectly the next version of jerasure was scheduled to be released this mont=
h. Although using jerasure-1.2 ( as found at http://web.eecs.utk.edu/~pla=
nk/plank/papers/CS-08-627.html ) would be perfectly fine, it may be worth=
 waiting for a few days if a release is imminent.
>>
>> Do you advise to wait for the next version of jerasure ?
>>
>> Cheers
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigBFF82E7A9C70E9AA7EC2ECAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIWPTsACgkQ8dLMyEl6F20goQCglhWzlFlDOxuAq/TFWyFJEyK+
hsMAnjot1yw052xItUtoqnNnnqpA3D0j
=qWEJ
-----END PGP SIGNATURE-----

--------------enigBFF82E7A9C70E9AA7EC2ECAC--
