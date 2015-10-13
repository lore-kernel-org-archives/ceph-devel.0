From: Loic Dachary <loic@dachary.org>
Subject: Re: enable rbd on ec pool ?
Date: Tue, 13 Oct 2015 10:36:04 +0200
Message-ID: <561CC274.7070906@dachary.org>
References: <EBFBEFF470372547BAACF06D39FF53A54F5A8665@SACMBXIP02.sdcorp.global.sandisk.com> <561CB009.7090708@dachary.org> <EBFBEFF470372547BAACF06D39FF53A54F5A8823@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uKSW5ifcG8Mnn9NKa354JCTjacthfw9gg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41950 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751086AbbJMIgI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 04:36:08 -0400
In-Reply-To: <EBFBEFF470372547BAACF06D39FF53A54F5A8823@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomy Cheru <Tomy.Cheru@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uKSW5ifcG8Mnn9NKa354JCTjacthfw9gg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 13/10/2015 09:59, Tomy Cheru wrote:
> Hi Loic,
> 		Thanks for your response,=20
>=20
> however am specifically looking for a patch to enable rbd on ec pool(am=
 aware of cache tier option).

Ah :-) I'm not aware of such a patch, even in draft state.

> Thanks,
> tomy
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Tuesday, October 13, 2015 12:47 PM
> To: Tomy Cheru; ceph-devel@vger.kernel.org
> Subject: Re: enable rbd on ec pool ?
>=20
> Hi Tomy,
>=20
> On 13/10/2015 06:13, Tomy Cheru wrote:
>> Is there a patch available to enable rbd over an EC pool ?
>=20
> You have to go through a cache tier instead of using it directly. See h=
ttp://docs.ceph.com/docs/master/rados/operations/cache-tiering/ for more =
information.
>=20
> Cheers
>=20
>>
>> Currently its restricted,
>> 2015-10-12 10:52:23.042085 7f4721ca1840 -1 librbd: error adding image =

>> to directory: (95) Operation not supported
>> rbd: create error: (95) Operation not supported
>>
>> Thanks,
>> tomy
>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above.=
 If the reader of this message is not the intended recipient, you are her=
eby notified that you have received this message in error and that any re=
view, dissemination, distribution, or copying of this message is strictly=
 prohibited. If you have received this communication in error, please not=
ify the sender by telephone or e-mail (as shown above) immediately and de=
stroy any and all copies of this message in your possession (whether hard=
 copies or electronically stored copies).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--uKSW5ifcG8Mnn9NKa354JCTjacthfw9gg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYcwnQACgkQ8dLMyEl6F23q7gCffSca0/vPZumGZQuClQH0akP6
yfYAnAleWRm8+kQAg66QGBsKco+DQLkd
=jqjy
-----END PGP SIGNATURE-----

--uKSW5ifcG8Mnn9NKa354JCTjacthfw9gg--
