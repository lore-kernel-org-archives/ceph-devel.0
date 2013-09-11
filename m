From: Loic Dachary <loic@dachary.org>
Subject: Re: Jerasure 1.2A plugin for Ceph
Date: Wed, 11 Sep 2013 17:40:13 +0200
Message-ID: <52308EDD.5020100@dachary.org>
References: <522055BE.2040200@dachary.org> <CFA250A5-F536-4C28-AC69-10C7F2B6DD39@cs.utk.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1CB4E1523728676543FD275F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60028 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834Ab3IKPkO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 11:40:14 -0400
In-Reply-To: <CFA250A5-F536-4C28-AC69-10C7F2B6DD39@cs.utk.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Plank <plank@cs.utk.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CB4E1523728676543FD275F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[cc'ing the devel mailing list]

Hi James,

Thanks for the positive feedback :-) I found the API fairly straightforwa=
rd and I don't see what could be improved. However, I've learnt about era=
sure code and designed the Ceph plugin abstract API mostly by studying je=
rasure. I'm probably biased : let hear what others have to suggest.

Cheers

On 11/09/2013 17:04, James Plank wrote:
> Hi Loic -- I took a scan, and it looks like a nice usage of the library=
=2E  Here's a question -- for the next revision of jerasure, are there an=
y functionalities that you would like to see, that would make your life a=
s a developer easier?  Thanks!  Jim
> ----------
>=20
> On Aug 30, 2013, at 4:20 AM, Loic Dachary wrote:
>=20
>> Hi James,
>>
>> The first version of the jerasure 1.2A plugin for Ceph is complete at
>>
>> https://github.com/ceph/ceph/pull/538#commits-pushed-763275e
>>
>> This commit introduces the main part:
>> ErasureCodeJerasure: base class for jerasure ErasureCodeInterface
>> https://github.com/dachary/ceph/commit/76d2842358465e560a4929d60131762=
f8c93804f
>>
>> and each technique is derived from it in six successive commits, start=
ing from here
>> ErasureCodeJerasure: define technique ReedSolomonVandermonde
>>
>> It would be great if you could take a look and let us know if you see =
anything odd.
>>
>> Cheers
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig1CB4E1523728676543FD275F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIwjt0ACgkQ8dLMyEl6F20ZrQCfRAF1DGN08S35SYfsYGWYx7Qv
nh0An2ifLQUjBVdKUpwD9FET3YLmUxhQ
=dYs9
-----END PGP SIGNATURE-----

--------------enig1CB4E1523728676543FD275F--
