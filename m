From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] osd/erasurecode: Fix memory leak in jerasure_matrix_to_bitmatrix()
Date: Sat, 02 Nov 2013 10:16:33 +0100
Message-ID: <5274C2F1.3000406@dachary.org>
References: <1383375493-2895-1-git-send-email-xinglin@cs.utah.edu> <alpine.DEB.2.00.1311020002280.32481@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s09P4ibTsN39wQd0mXd3vvABfprOSXGjR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:53498 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3KBJQi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Nov 2013 05:16:38 -0400
In-Reply-To: <alpine.DEB.2.00.1311020002280.32481@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Xing Lin <xinglin@cs.utah.edu>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s09P4ibTsN39wQd0mXd3vvABfprOSXGjR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/11/2013 08:03, Sage Weil wrote:
> Hi!
>=20
> On Sat, 2 Nov 2013, Xing Lin wrote:
>> Free allocated memory before return because of NULL input
>>
>> Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
>> ---
>>  src/osd/ErasureCodePluginJerasure/jerasure.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c b/src/osd/Er=
asureCodePluginJerasure/jerasure.c
>> index 9efae02..1bb4b1d 100755
>> --- a/src/osd/ErasureCodePluginJerasure/jerasure.c
>> +++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
>> @@ -276,7 +276,10 @@ int *jerasure_matrix_to_bitmatrix(int k, int m, i=
nt w, int *matrix)
>>    int rowelts, rowindex, colindex, elt, i, j, l, x;
>> =20
>>    bitmatrix =3D talloc(int, k*m*w*w);
>> -  if (matrix =3D=3D NULL) { return NULL; }
>> +  if (matrix =3D=3D NULL) {
>> +    free(bitmatrix);
>> +    return NULL;=20
>> +  }
>=20
> I have a feeling the author meant to say if (bitmatrix =3D=3D NULL), si=
nce all=20
> the other talloc calls in this file tend to be followed by a NULL check=
?

Yes. Good catch Xing Lin :-)

Cheers

>=20
> sage
>=20
>=20
>> =20
>>    rowelts =3D k * w;
>>    rowindex =3D 0;
>> --=20
>> 1.8.3.4 (Apple Git-47)
>>
>> --
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


--s09P4ibTsN39wQd0mXd3vvABfprOSXGjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ0wvQACgkQ8dLMyEl6F22IEACffhOp1gTLPwZowtCeSIL+AH5G
eKYAoI7TFDingAWznWxf3z8tMO4WRENr
=LTv5
-----END PGP SIGNATURE-----

--s09P4ibTsN39wQd0mXd3vvABfprOSXGjR--
