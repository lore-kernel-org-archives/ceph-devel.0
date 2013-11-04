From: <philippe.raipin@orange.com>
Subject: RE: [PATCH] osd/erasurecode: Fix memory leak in
 jerasure_matrix_to_bitmatrix()
Date: Mon, 4 Nov 2013 10:44:50 +0000
Message-ID: <79B40C35CFBE75499839945586B8480B47F95666@FTRDMB02.rd.francetelecom.fr>
References: <1383375493-2895-1-git-send-email-xinglin@cs.utah.edu>
 <alpine.DEB.2.00.1311020002280.32481@cobra.newdream.net>
 <5274C2F1.3000406@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from p-mail1.rd.orange.com ([195.101.245.15]:55712 "EHLO
	p-mail1.rd.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab3KDKvL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Nov 2013 05:51:11 -0500
In-Reply-To: <5274C2F1.3000406@dachary.org>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic@dachary.org, sage@inktank.com, xinglin@cs.utah.edu
Cc: ceph-devel@vger.kernel.org

Hi !

In this case, it should be more efficient to do the NULL check before t=
he talloc (you'll save the free operation and a useless memory allocati=
on)

Cheers,
Philippe


-----Message d'origine-----
De=A0: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.k=
ernel.org] De la part de Loic Dachary
Envoy=E9=A0: samedi 2 novembre 2013 10:17
=C0=A0: Sage Weil; Xing Lin
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: Re: [PATCH] osd/erasurecode: Fix memory leak in jerasure_matr=
ix_to_bitmatrix()



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
>> diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c=20
>> b/src/osd/ErasureCodePluginJerasure/jerasure.c
>> index 9efae02..1bb4b1d 100755
>> --- a/src/osd/ErasureCodePluginJerasure/jerasure.c
>> +++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
>> @@ -276,7 +276,10 @@ int *jerasure_matrix_to_bitmatrix(int k, int m,=
 int w, int *matrix)
>>    int rowelts, rowindex, colindex, elt, i, j, l, x;
>> =20
>>    bitmatrix =3D talloc(int, k*m*w*w);
>> -  if (matrix =3D=3D NULL) { return NULL; }
>> +  if (matrix =3D=3D NULL) {
>> +    free(bitmatrix);
>> +    return NULL;
>> +  }
>=20
> I have a feeling the author meant to say if (bitmatrix =3D=3D NULL), =
since=20
> all the other talloc calls in this file tend to be followed by a NULL=
 check?

Yes. Good catch Xing Lin :-)

Cheers

>=20
> sage
>=20
>=20
>> =20
>>    rowelts =3D k * w;
>>    rowindex =3D 0;
>> --
>> 1.8.3.4 (Apple Git-47)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
