From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer integration tests for v0.94.4
Date: Thu, 20 Aug 2015 15:31:05 +0200
Message-ID: <55D5D699.7000005@dachary.org>
References: <CAP3mxSw7B0HA7iTB+Fr8sF3bxL2V2KKoq7LdWER9kuVr_XZ4FQ@mail.gmail.com>	<55D4AD0F.1080908@dachary.org> <CAP3mxSyyXwpJL8VFrsGZ6E7Bdckh1gLTi33PzeNdG8AccxrYKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NRjWjUkMAxQhM6vsBQSl9WN5SaMp6iiP8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41209 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752690AbbHTNbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 09:31:10 -0400
In-Reply-To: <CAP3mxSyyXwpJL8VFrsGZ6E7Bdckh1gLTi33PzeNdG8AccxrYKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRjWjUkMAxQhM6vsBQSl9WN5SaMp6iiP8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/08/2015 08:42, Abhishek Varshney wrote:
> Hi Loic,
>=20
> I see that the failures in rgw suite are either related to s3 or swift =
clients. Out of all the PRs merged in this backports branch which are rel=
ated to rgw, the PR that I backported ( https://github.com/ceph/ceph/pull=
/5482 and https://github.com/ceph/ceph/pull/5496 ) look like candidates f=
or these failures?

I'm not sure... Abhishek Lekshmanan knows more than I do about rgw.

> Thanks
> Abhishek
>=20
> On Wed, Aug 19, 2015 at 9:51 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Abhishek,
>=20
>     The tests for your integration branch completed and I updated http:=
//tracker.ceph.com/issues/12701#teuthology-run-commit-e1dadd3da9e39daf669=
f94715c7833d2b280bbed-HAMMER-BACKPORTS-August-14 to reflect the results.
>=20
>     The general idea is that if there are a few failed jobs, I just re-=
scheduled them assuming this is noise (fs, rados, rbd). The rgw suite how=
ever had a number of failures and I just updated http://tracker.ceph.com/=
issues/12701#rgw to group the same error together. There seems to be only=
 two types of error.
>=20
>     Can you make sense of them ?
>=20
>     Cheers
>=20
>     On 19/08/2015 17:37, Abhishek Varshney wrote:
>     > Hey Loic,
>     >
>     > I saw that there was a PR which was probably causing all the upgr=
ade tests to hang. What about other tests which failed in other suites?
>     >
>     > Also let me know how should I proceed now or any other task that =
I can take?
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


--NRjWjUkMAxQhM6vsBQSl9WN5SaMp6iiP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXV1pkACgkQ8dLMyEl6F22LfwCfSZ+xPFLn0It2LL31rLxjxrFk
HrsAnjdiu+YXhyihHBC0q+oqLHyYI7j7
=09q9
-----END PGP SIGNATURE-----

--NRjWjUkMAxQhM6vsBQSl9WN5SaMp6iiP8--
