From: Loic Dachary <loic@dachary.org>
Subject: Re: Throttle::wait use case clarification
Date: Tue, 05 Feb 2013 20:10:24 +0100
Message-ID: <51115920.2000306@dachary.org>
References: <50FBF3A4.4010200@dachary.org> <6AF9B5AC8C404CFBB78E54BA8C7FA1D2@inktank.com> <50FD4635.9040301@dachary.org> <CAPYLRzjy+5=Ui+C5b5d4QFttOSYz-n6nm+ObPibeTqMF7EmFdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C41C2F0DDA50EBF887121ED"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:60470 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562Ab3BETK1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 14:10:27 -0500
In-Reply-To: <CAPYLRzjy+5=Ui+C5b5d4QFttOSYz-n6nm+ObPibeTqMF7EmFdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C41C2F0DDA50EBF887121ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a new pull request containing the patch and the associated unit t=
ests, all together. Thanks a lot for reviewing them :-)

https://github.com/ceph/ceph/pull/39

Cheers

On 02/05/2013 01:22 AM, Gregory Farnum wrote:
> Loic,
> Sorry for the delay in getting back to you about these patches. :( I
> finally got some time to look over them, and in general it's all good!
> I do have some comments, though.
>=20
> On Mon, Jan 21, 2013 at 5:44 AM, Loic Dachary <loic@dachary.org> wrote:=

>>> Looking through the history of that test (in _reset_max), I think it'=
s an accident and we actually want to be waking up the front if the maxim=
um increases (or possibly in all cases, in case the front is a very large=
 request we're going to let through anyway). Want to submit a patch? :)
>> :-) Here it is. "make check" does not complain. I've not run teutholog=
y + qa-suite though. I figured out how to run teuthology but did not yet =
try qa-suite.
>>
>> http://marc.info/?l=3Dceph-devel&m=3D135877502606311&w=3D4
>=20
> This patch to reverse the conditional is obviously fine.
>=20
>>> The other possibility I was trying to investigate is that it had some=
thing to do with handling get() requests larger than the max correctly, b=
ut I can't find any evidence of that one...
>> I've run the Throttle unit tests after uncommenting
>> https://github.com/ceph/ceph/pull/34/files#L3R269
>> and commenting out
>> https://github.com/ceph/ceph/pull/34/files#L3R266
>> and it passes.
>=20
> Regarding these unit tests, I have a few questions which I left on
> Github. Can you address them and then give a single pull request which
> includes both the Throttle fix and the tests? :)
> Thanks!
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig9C41C2F0DDA50EBF887121ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlERWSAACgkQ8dLMyEl6F21pkgCeNuuqVr3s7T/CD7P8mAORw7vx
hgQAnRtwAg5+kxj+MFoBkrPBVeN26l2L
=MY88
-----END PGP SIGNATURE-----

--------------enig9C41C2F0DDA50EBF887121ED--
