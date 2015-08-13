From: Loic Dachary <loic@dachary.org>
Subject: Re: Regarding hammer integration branch
Date: Thu, 13 Aug 2015 13:35:49 +0200
Message-ID: <55CC8115.7030306@dachary.org>
References: <CAP3mxSzDr_m+XBmSTpkn81a518f-tdQzWUsOkVm7C8yPnXBKRw@mail.gmail.com>	<55CBAB03.1050903@dachary.org> <CAP3mxSz_iqFWWf0rBGx1HRumPX2NON__1GMbhw2qj2xDgyGJMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pm7Mw4qWc1JnveacPKuH8pK7xKmLgqVfW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37638 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752590AbbHMLfw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Aug 2015 07:35:52 -0400
In-Reply-To: <CAP3mxSz_iqFWWf0rBGx1HRumPX2NON__1GMbhw2qj2xDgyGJMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: "Giridhar Yasa (Engineering)" <giridhar.yasa@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pm7Mw4qWc1JnveacPKuH8pK7xKmLgqVfW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel for the record]

Hi Abhishek,

The hammer-backports branch at https://github.com/ceph/ceph/tree/hammer-b=
ackports has been reset with your branch and is now building at http://ce=
ph.com/gitbuilder.cgi. When it completes we will be able to schedule teut=
hology suites to verify it behaves well.

Cheers

On 13/08/2015 09:58, Abhishek Varshney wrote:
> Thanks Loic. I have just created a PR with hammer-backports integration=
 branch after it successfully passed make check on my local machine. I gu=
ess I would have to wait for run-make-check bot to report SUCCESS before =
we move ahead with the next step?
>=20
> PR : https://github.com/ceph/ceph/pull/5566
>=20
> ~ Abhishek
>=20
> On Thu, Aug 13, 2015 at 1:52 AM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Done !
>=20
>     On 12/08/2015 18:51, Abhishek Varshney wrote:
>     > Hi Loic,
>     >
>     > I ran run-make-check locally on the integration branch that I mad=
e the other day. It had build failures, which I suspect is because of thi=
s PR : https://github.com/ceph/ceph/pull/5530 . make check bot has report=
ed failure on this PR, but still it doesn't have DNM as prefix in the tit=
le. Can you please update the the title, so that I can again get the PRs =
and run-make-check locally.
>     >
>     > Thanks
>     > Abhishek
>     >
>     > -----------------------------------------------------------------=
-------------------------------------------------------------------------=

>     >
>     > This email and any files transmitted with it are confidential and=
 intended solely for the use of the individual or entity to whom they are=
 addressed. If you have received this email in error please notify the sy=
stem manager. This message contains confidential information and is inten=
ded only for the individual named. If you are not the named addressee you=
 should not disseminate, distribute or copy this e-mail. Please notify th=
e sender immediately by e-mail if you have received this e-mail by mistak=
e and delete this e-mail from your system. If you are not the intended re=
cipient you are notified that disclosing, copying, distributing or taking=
 any action in reliance on the contents of this information is strictly p=
rohibited. Although Flipkart has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibi=
lity for any loss or damage arising from the use of this email or attachm=
ents
>     >
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------
>=20
> This email and any files transmitted with it are confidential and inten=
ded solely for the use of the individual or entity to whom they are addre=
ssed. If you have received this email in error please notify the system m=
anager. This message contains confidential information and is intended on=
ly for the individual named. If you are not the named addressee you shoul=
d not disseminate, distribute or copy this e-mail. Please notify the send=
er immediately by e-mail if you have received this e-mail by mistake and =
delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any a=
ction in reliance on the contents of this information is strictly prohibi=
ted. Although Flipkart has taken reasonable precautions to ensure no viru=
ses are present in this email, the company cannot accept responsibility f=
or any loss or damage arising from the use of this email or attachments
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pm7Mw4qWc1JnveacPKuH8pK7xKmLgqVfW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXMgRUACgkQ8dLMyEl6F23o3gCgpSGNNhqXtF0+q4e7ESpV2Sof
2qwAoLP/yontOE1acsZeLl4apNS4Day5
=yMmy
-----END PGP SIGNATURE-----

--pm7Mw4qWc1JnveacPKuH8pK7xKmLgqVfW--
