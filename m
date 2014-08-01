From: Loic Dachary <loic@dachary.org>
Subject: Re: Simplified LRC in CEPH
Date: Fri, 01 Aug 2014 18:59:49 +0545
Message-ID: <53DB92C9.5040302@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE753328@CERNXCHG44.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE75333D@CERNXCHG44.cern.ch>,<53DB88EC.4050209@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE7534F1@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2JDDEdwpJqRVeMw0hK23gWOSBmm9G8PaV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52176 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754881AbaHANQB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 09:16:01 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7534F1@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2JDDEdwpJqRVeMw0hK23gWOSBmm9G8PaV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

It probably is just what we need. Although https://github.com/ceph/ceph/p=
ull/1921 is more flexible in terms of chunk placement, I can't think of a=
 use case where it would actually be useful. Maybe it's just me being bac=
k from hollidays but it smells like a solution to a non existent problem =
;-) The other difference is that your proposal does not allow for nested =
locality. I.e. datacenter locality and rack locality within a datacenter,=
 for instance. What do you think ?

Cheers

On 01/08/2014 18:29, Andreas Joachim Peters wrote:
> Hi Loic,=20
>=20
>> It would, definitely. How would you control where data / parity chunks=
 are located ?
>=20
> I ordered the chunks after encoding in this way:
>=20
> ( 1 2 3 4 LP1 ) ( 5 6 7 8 LP2 ) ( 9 10 11 12 LP3 ) ( 13 14 15 16 LP4 ) =
( R2 R3 R4 LP5 )
>=20
> Always (k/l)+1 consecutive chunks belong location-wise together ...  an=
d I demand that (k/l) <=3D m
>=20
> That is probably straight forward to express in a crush rule.
>=20
> Cheers Andreas.
>=20
> PS: just one correction, I wrote 'degree' but it is called the 'distanc=
e' of the code=20
> =20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 01 August 2014 14:32
> To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
> Subject: Re: Simplified LRC in CEPH
>=20
> Hi Andreas,
>=20
> Enlightening explanation, thank you !
>=20
> On 01/08/2014 13:45, Andreas Joachim Peters wrote:
>> Hi Loic et. al.
>>
>> I managed to prototype (and understand) LRC encoding similiar to Xorba=
s in the ISA plug-in.
>>
>> As an example take a (16,4) code (which gives nice alignment for 4k bl=
ocks) :
>>
>> For 4 sub groups of the data chunks you build e.g. local parities LP1-=
LP4
>>
>> LP1 =3D 1 ^ 2 ^ 3 ^ 4
>>
>> LP2 =3D 5 ^ 6 ^ 7 ^ 8
>>
>> LP3 =3D 9 ^ 10 ^ 11 ^ 12
>>
>> LP4 =3D 13 ^ 14 ^ 15 ^ 16
>>
>> You do normal erasure encoding with 4 RS chunks:
>>
>> RS(1..16) =3D (R1, R2, R3, R4)
>>
>> You compute the local parity LP5 for the erasure chunks:
>>
>> LP5 =3D R1 ^ R2 ^ R3 ^ R4
>>
>> The relation which holds for Vandermonde matrices (because the first m=
atrix row contains only 1's)
>>
>> LP1 ^ LP2 ^ LP3 ^ LP4 =3D R1
>>
>> So you need to store only 24 chunks (not 25):
>>
>> (1 .. 16) (R2,R3,R4) (LP1,LP2,LP3,LP4,LP5)
>>
>> Side remark: in this simplified explanation I imply R1, not LP5 as des=
cribed in the Xorbas paper
>=20
> Does it make a difference or is it equivalent ?
>=20
>> The degree of the code is 5 e.g. you can construct a failure with 5 lo=
sses where you loose data, while if you are 'lucky' the code can even rep=
air up to 8 failures (one loss in each sub group + LP5,R2,R3,R4).
>>
>> The reconstruction traffic for single failures is:
>>
>> [(20 x 4) + (4 x 8)]/24 =3D~ 4.66 x [disk size] instead of 16 x [disk =
size]
>>
>> There are three repair scenarios:
>>
>> 1) only single failures in any of the local groups using LRC repair (s=
imple parities)
>> 2) multiple failures which can be reconstructed with RS parities witho=
ut LRC repair
>> 3) multiple failures which can be reconstructed with RS parities after=
 LRC repair
>>
>> [ 4) reconstruction impossible  ]
>>
>> Having your proposed LRC layer (decoding) model in mind there is a cer=
tain contradiction here because there are cases where it is not required =
to use LRC since you can resolve all the failures with RS alone.
>>
>> In the end I think, it is sufficient if we introduce a parameter l in =
the EC parameter list which defines the number of subgroups in the data c=
hunks and imply to use always one local parity for all RS chunks. So you =
can specify an LRC easily with three simple parameters:
>>
>> k=3D16 m=3D4 l=3D4
>>
>> The Xorbas configuration would be written as k=3D10 m=3D4 l=3D2
>>
>> Wouldn't that be much simpler and sufficient? What do you think?
>=20
> It would, definitely. How would you control where data / parity chunks =
are located ?
>=20
> Cheers
>>
>> Cheers Andreas.
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--2JDDEdwpJqRVeMw0hK23gWOSBmm9G8PaV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPbkskACgkQ8dLMyEl6F20ZdQCgg4jXB9JRLDw2nG7OC1ORdoqJ
yz8An3akp9XDuEZJin4iUoKS8T5LuKiL
=RqbI
-----END PGP SIGNATURE-----

--2JDDEdwpJqRVeMw0hK23gWOSBmm9G8PaV--
