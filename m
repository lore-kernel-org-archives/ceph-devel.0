From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] osd/erasurecode: Fix memory leak in jerasure_matrix_to_bitmatrix()
Date: Mon, 04 Nov 2013 22:29:32 +0800
Message-ID: <5277AF4C.4080309@dachary.org>
References: <1383375493-2895-1-git-send-email-xinglin@cs.utah.edu> <alpine.DEB.2.00.1311020002280.32481@cobra.newdream.net> <5274C2F1.3000406@dachary.org> <79B40C35CFBE75499839945586B8480B47F95666@FTRDMB02.rd.francetelecom.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hEOVB7IJNqb2spq4oNT3c47VB71bC9jow"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:54812 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab3KDO3i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Nov 2013 09:29:38 -0500
In-Reply-To: <79B40C35CFBE75499839945586B8480B47F95666@FTRDMB02.rd.francetelecom.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: philippe.raipin@orange.com
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEOVB7IJNqb2spq4oNT3c47VB71bC9jow
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 04/11/2013 18:44, philippe.raipin@orange.com wrote:
> Hi !
>=20
> In this case, it should be more efficient to do the NULL check before t=
he talloc (you'll save the free operation and a useless memory allocation=
)
>=20

Hi,

The check is on bitmatrix actually ;-)

Cheers

> Cheers,
> Philippe
>=20
>=20
> -----Message d'origine-----
> De : ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ker=
nel.org] De la part de Loic Dachary
> Envoy=E9 : samedi 2 novembre 2013 10:17
> =C0 : Sage Weil; Xing Lin
> Cc : ceph-devel@vger.kernel.org
> Objet : Re: [PATCH] osd/erasurecode: Fix memory leak in jerasure_matrix=
_to_bitmatrix()
>=20
>=20
>=20
> On 02/11/2013 08:03, Sage Weil wrote:
>> Hi!
>>
>> On Sat, 2 Nov 2013, Xing Lin wrote:
>>> Free allocated memory before return because of NULL input
>>>
>>> Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
>>> ---
>>>  src/osd/ErasureCodePluginJerasure/jerasure.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c=20
>>> b/src/osd/ErasureCodePluginJerasure/jerasure.c
>>> index 9efae02..1bb4b1d 100755
>>> --- a/src/osd/ErasureCodePluginJerasure/jerasure.c
>>> +++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
>>> @@ -276,7 +276,10 @@ int *jerasure_matrix_to_bitmatrix(int k, int m, =
int w, int *matrix)
>>>    int rowelts, rowindex, colindex, elt, i, j, l, x;
>>> =20
>>>    bitmatrix =3D talloc(int, k*m*w*w);
>>> -  if (matrix =3D=3D NULL) { return NULL; }
>>> +  if (matrix =3D=3D NULL) {
>>> +    free(bitmatrix);
>>> +    return NULL;
>>> +  }
>>
>> I have a feeling the author meant to say if (bitmatrix =3D=3D NULL), s=
ince=20
>> all the other talloc calls in this file tend to be followed by a NULL =
check?
>=20
> Yes. Good catch Xing Lin :-)
>=20
> Cheers
>=20
>>
>> sage
>>
>>
>>> =20
>>>    rowelts =3D k * w;
>>>    rowindex =3D 0;
>>> --
>>> 1.8.3.4 (Apple Git-47)
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
>>> in the body of a message to majordomo@vger.kernel.org More majordomo =

>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--hEOVB7IJNqb2spq4oNT3c47VB71bC9jow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ3r0wACgkQ8dLMyEl6F20FHQCfdzXwfN7ybPw6CPYSu+o71IHR
nHoAnjGTPkknNR/7rxabYW2xIPpt9Q/I
=qnmJ
-----END PGP SIGNATURE-----

--hEOVB7IJNqb2spq4oNT3c47VB71bC9jow--
