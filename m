From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure coding (sorry)
Date: Mon, 22 Apr 2013 10:10:55 +0200
Message-ID: <5174F08F.2070001@dachary.org>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com> <51706120.2060702@inktank.com> <20130418173113.74a53769@dieter-t420s> <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1DEE4B606D6057C370EA3FA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:48082 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3DVIK6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 04:10:58 -0400
In-Reply-To: <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher LILJENSTOLPE <cdl@asgaard.org>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1DEE4B606D6057C370EA3FA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

You wrote "A modified client/library could be used to store objects that =
should be sharded, vs "standard" ceph treatment.  In this model, each sha=
rd would be written to a seperate PG, and each PG would we stored on exac=
tly one OSD.  " but there is no way for a client to enforce the fact that=
 two objects are stored in separate PG.

Am I missing something ?

On 04/22/2013 09:23 AM, Christopher LILJENSTOLPE wrote:
> Supposedly, on 2013-Apr-18, at 14.31 PDT(-0700), someone claiming to be=
 Plaetinck, Dieter scribed:
>=20
>> On Thu, 18 Apr 2013 16:09:52 -0500
>> Mark Nelson <mark.nelson@inktank.com> wrote:
>=20
>>>
>>
>> @Bryan: I did come across cleversafe.  all the articles around it seem=
ed promising,
>> but unfortunately it seems everything related to the cleversafe open s=
ource project
>> somehow vanished from the internet.  (e.g. http://www.cleversafe.org/)=
 quite weird...
>>
>> @Sage: interesting. I thought it would be more relatively simple if on=
e assumes
>> the restriction of immutable files.  I'm not familiar with those ceph =
specifics you're mentioning.
>> When building an erasure codes-based system, maybe there's ways to reu=
se existing ceph
>> code and/or allow some integration with replication based objects, wit=
hout aiming for full integration or
>> full support of the rados api, based on some tradeoffs.
>>
>> @Josh, that sounds like an interesting approach.  Too bad that page do=
esn't contain any information yet :)
>=20
> Greetings - it does now - see what you all think=E2=80=A6
>=20
> 	Christopher
>=20
>>
>> Dieter
>=20
>=20
> --
> =E6=9D=8E=E6=9F=AF=E7=9D=BF
> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
> Check my calendar availability: https://tungle.me/cdl

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--------------enigA1DEE4B606D6057C370EA3FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF08I8ACgkQ8dLMyEl6F21d+wCfVNDilO8V1DIptLCWFTZHjrcx
fn4AnRNUn1qjTYjKnLlNQ4Vu83vRDHUH
=elts
-----END PGP SIGNATURE-----

--------------enigA1DEE4B606D6057C370EA3FA--
