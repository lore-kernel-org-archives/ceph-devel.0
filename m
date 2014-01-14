From: Loic Dachary <loic@dachary.org>
Subject: Re: EC API to expose locality
Date: Wed, 15 Jan 2014 00:02:24 +0100
Message-ID: <52D5C200.8040604@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE6B0BE8@PLOXCHG03.cern.ch> <alpine.DEB.2.00.1401140658120.10628@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0Kna0hlUm9LoUb1m3CImQCih2vIIfE1bL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:43517 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaANXCb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jan 2014 18:02:31 -0500
In-Reply-To: <alpine.DEB.2.00.1401140658120.10628@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Kna0hlUm9LoUb1m3CImQCih2vIIfE1bL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 14/01/2014 16:39, Sage Weil wrote:
> Hi Andreas,
>=20
> On Tue, 14 Jan 2014, Andreas Joachim Peters wrote:
>> After some exchange with Loic and the recent list discussion,=20
>> the API of the EC plugin might need some clarification/extension in th=
e ::encode method:
>>
>> Currently ::encode returns a map of bufferlists where the key is the i=
ndex of [ 0 .. (m+k) ]=20
>> and the value is the encoded buffer belonging to that stripe index:
>>
>> map<int, bufferlist> *encoded
>>
>> If a pyramid code is used the index would be [ 0 .. (m+k+(l*l_k)) ] wh=
ere l is the number of local=20
>> parity subgroups and l_k are the number of parity stripes per subgroup=
=2E The pyramid code would just
>> chunk the input into the requested number of subgroups and compute loc=
al parity for them according=20
>> to the configuration.
>>
>> With this API the caller has actually no clue how to group stripes tog=
ether for intelligent
>> placement allowing to keep subgroups with local parities together to m=
inimize traffic=20
>> during remapping and reconstruction.
>=20
> This is a bit awkward, it's true.  I'm not sure there is a 'magic' way =
to=20
> accomplish this.  In the end, the CRUSH rule needs to have the required=
=20
> width *and* should group nodes accordingly, but this mapping happens at=
 a=20
> very different layer in Ceph than the low-level plugin, so even if call=
ers=20
> had this information they wouldn't be able to do anything about it.
>=20
> Currently, what we need to do is make sure the EC plugin maps onto a=20
> linear array of devices the same way that CRUSH does.  For a pyramid co=
de,=20
> the CRUSH rule will be something like=20
>=20
>  step take root
>  step choose 3 rack
>  step choose 5 osd
>  emit
>=20
> to get 3 groups of 5 devices as an array of size 15.  That means the EC=

> plugin needs to map onto ranks that go something like
>=20
>  0-3 data
>  4 local parity
>  5-8 data
>  9 local parity
>  10-11 data
>  12-13 global parity
>  14 local parity
>=20
> (or whatever).
>=20
> Getting this to line up is a bit fragile, unfortunately.  We could make=

> a plugin method that describes the subgrouping, but even then I'm not
> sure how easy it is to programmatically validate that an arbitrary CRUS=
H
> rule will behave well.  Maybe it is enough to
>=20
> - have some way to query the layout of the EC plugin (e.g, 3 groups of =
5).
> - add a new 'osd crush rule create-pyramid ...' command to supplement=20
>   'create-simple'.
>=20
> and document it well...=20
>=20
> sage

I created http://tracker.ceph.com/issues/7146 to keep track of this featu=
re.

Cheers
>=20
>>
>> Either there is an additional function returning the location sub-grou=
p [ 0 .. l ] for each created=20
>> chunk or the ::encode function returns the chunks already grouped like=
:
>>
>> vector<int, map<int, bufferlist> *encoded
>>
>> Probably it would be good to have both.
>>
>> However it is not clear, if you can actually remap/recover an OSD with=
out destroying the locality=20
>> of pyramid encoding and if you can at all define CRUSH rules honoring =
the idea of chunk locality where
>> shrinking/extension of pools keeps the locality.
>>
>> Last question is, if a remapping/recovery action is only possible with=
 the traffic going through the primary OSD.
>>
>> If locality cannot be supported sufficiently now or in the future, sho=
uld the API stay as it is?
>>
>> The ::decode function is fine, since the plugin knows about the locali=
ty of the available chunks and will
>> select the cheapest decoding possible.
>>
>> Cheers Andreas.--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--0Kna0hlUm9LoUb1m3CImQCih2vIIfE1bL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLVwgAACgkQ8dLMyEl6F23U4wCeNRPUDGDxwbh4nNGoqF4uUJSe
rPkAn3OCfwlrO7m0zzpSUkUhvUsqWk1Y
=aeFp
-----END PGP SIGNATURE-----

--0Kna0hlUm9LoUb1m3CImQCih2vIIfE1bL--
