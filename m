From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC pull request (2nd challenge)
Date: Fri, 30 Jan 2015 12:28:40 +0100
Message-ID: <54CB6AE8.20905@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA68A90@g01jpexmbyt24> <54CA45B3.7030309@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA68DCF@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F4VBTlxGnxsaoxT4rpkLrnAtAgaG7XmRH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49697 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752498AbbA3L2p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 06:28:45 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA68DCF@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F4VBTlxGnxsaoxT4rpkLrnAtAgaG7XmRH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

On 30/01/2015 11:28, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> Thank you for your cooperation !
> If we could do something to reduce your burdens, please let us know.

Hopefully tests come out clean, let see :-)

There was originally two files for tests and the one with 364 or somethin=
g at the end was removed if I'm not mistaken. Is there a reason for that =
?

Cheers

>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Thursday, January 29, 2015 11:38 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Kawaguchi,=
 Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=E5=A4=AA=E6=9C=97; Kaga, Yoshihiro/=
=E5=8A=A0=E8=B3=80 =E8=8A=B3=E5=AE=8F; Paul Von-Stamwitz (PVonStamwitz@us=
=2Efujitsu.com)
> Subject: Re: mSHEC pull request (2nd challenge)
>=20
> Hi,
>=20
> It looks good and ready for integration testing :-) I just created http=
://tracker.ceph.com/issues/10686 to track this feature. Since we are late=
 in development cycle and unless someone has a different opinion, I will =
mark the SHEC plugin as experimental so people know it's new. I will howe=
ver do that after it is merged in master.
>=20
> Cheers
>=20
> On 29/01/2015 15:24, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>> When I reset our commits on our fork repository, the 1st pull request =
was automatically closed.
>> So, I have issued another pull request of mSHEC.
>>
>> mSHEC : multiple Shingled Erasure Code #3534
>> https://github.com/ceph/ceph/pull/3534
>>
>> As a result, I believe I have squashed our commits into one.
>> I'm grad if you could restart the review.
>>
>> (You already noticed that and gave us labels, thank you!)
>>
>> Best regards,
>> Takeshi Miyamae
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--F4VBTlxGnxsaoxT4rpkLrnAtAgaG7XmRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTLaugACgkQ8dLMyEl6F23XMwCcDQPcu//Putn/V+AU+rPuGCGj
h00AnRfNVBhRjpfiOb8JVFpSK8YMUMtH
=GJzH
-----END PGP SIGNATURE-----

--F4VBTlxGnxsaoxT4rpkLrnAtAgaG7XmRH--
