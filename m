From: Loic Dachary <loic@dachary.org>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 19:28:26 +0200
Message-ID: <552BFCBA.2010201@dachary.org>
References: <552BF349.50909@redhat.com> <CAC6JEv8BqBkispnR7xZmC66p8YO4ckHH2mQFy_vt6MB+U=u-ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="txxEKIcGVFvdbWS6w93jpcXBH1xTIUUMc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45962 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932758AbbDMR2a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 13:28:30 -0400
In-Reply-To: <CAC6JEv8BqBkispnR7xZmC66p8YO4ckHH2mQFy_vt6MB+U=u-ZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--txxEKIcGVFvdbWS6w93jpcXBH1xTIUUMc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Greg,

On 13/04/2015 19:04, Gregory Farnum wrote:
> On Mon, Apr 13, 2015 at 9:48 AM, Ken Dreyer <kdreyer@redhat.com> wrote:=

>> A while ago this came up in #ceph-devel and I wanted to bring it to a
>> wider audience.
>>
>> Should we stop the convention of adding the "backport: " tags in Git?
>>
>> Loic brought up the point that this data is essentially immutable afte=
r
>> we merge it, and it's better to point at a Redmine tracker where we ca=
n
>> alter the "backport" field.
>>
>> This makes it easier to adjust the "backport" data after the code's be=
en
>> merged to master. It also makes it easier for whoever is corralling th=
e
>> backport efforts, because the person only have one place to look
>> (Redmine) instead of two (Redmine + git commit logs).
>>
>> For what it's worth I agree with Loic on this.
>>
>> Any objections?
>=20
> Why don't we just treat the backport commit tag as an expected value,
> and any corresponding redmine data as the canonical one?=20

That's what we currently do, I think.

> I find the
> backport tags to be useful when reviewing commits and I think the
> authorial intention matters.=20

A git-notes could be added for that purpose instead.=20

> For instance, it's not uncommon in some
> parts of the codebase to discover and fix bugs as part of a feature
> branch (because it's doing new things that weren't previously
> exercised), tag the bug fix as a backport, and then generate tickets
> later (assuming we're behaving).

Cheers

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--txxEKIcGVFvdbWS6w93jpcXBH1xTIUUMc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUr/LoACgkQ8dLMyEl6F22lhACfesuxioeS5wb+YUaOKpiokjO7
F4AAoLLamJHhKEcKxZNKK10HG7k1FhFi
=vzpN
-----END PGP SIGNATURE-----

--txxEKIcGVFvdbWS6w93jpcXBH1xTIUUMc--
