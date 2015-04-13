From: Loic Dachary <loic@dachary.org>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 22:04:38 +0200
Message-ID: <552C2156.8090406@dachary.org>
References: <552BF349.50909@redhat.com>	<CAC6JEv8BqBkispnR7xZmC66p8YO4ckHH2mQFy_vt6MB+U=u-ZA@mail.gmail.com>	<552BFCBA.2010201@dachary.org> <CAC6JEv8DTj2mdJspfe8Xo9VOFaRgH6egz3Uh2V_wo-UcwdXfSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aoHqotMLnNX2NfHC798NaBw7T0VNvQ5cm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46003 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751669AbbDMUEl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 16:04:41 -0400
In-Reply-To: <CAC6JEv8DTj2mdJspfe8Xo9VOFaRgH6egz3Uh2V_wo-UcwdXfSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aoHqotMLnNX2NfHC798NaBw7T0VNvQ5cm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/04/2015 20:53, Gregory Farnum wrote:
> On Mon, Apr 13, 2015 at 10:28 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>> Hi Greg,
>>
>> On 13/04/2015 19:04, Gregory Farnum wrote:
>>> On Mon, Apr 13, 2015 at 9:48 AM, Ken Dreyer <kdreyer@redhat.com> wrot=
e:
>>>> A while ago this came up in #ceph-devel and I wanted to bring it to =
a
>>>> wider audience.
>>>>
>>>> Should we stop the convention of adding the "backport: " tags in Git=
?
>>>>
>>>> Loic brought up the point that this data is essentially immutable af=
ter
>>>> we merge it, and it's better to point at a Redmine tracker where we =
can
>>>> alter the "backport" field.
>>>>
>>>> This makes it easier to adjust the "backport" data after the code's =
been
>>>> merged to master. It also makes it easier for whoever is corralling =
the
>>>> backport efforts, because the person only have one place to look
>>>> (Redmine) instead of two (Redmine + git commit logs).
>>>>
>>>> For what it's worth I agree with Loic on this.
>>>>
>>>> Any objections?
>>>
>>> Why don't we just treat the backport commit tag as an expected value,=

>>> and any corresponding redmine data as the canonical one?
>>
>> That's what we currently do, I think.
>>
>>> I find the
>>> backport tags to be useful when reviewing commits and I think the
>>> authorial intention matters.
>>
>> A git-notes could be added for that purpose instead.
>=20
> Huh, I'm not previously familiar with that mechanism. Is there any
> particular reason you didn't use that for tracking backport states to
> begin with? It looks like it's sort of designed for this purpose.

My thoughts exactly. But I figure that out only recently. The cross refer=
encing script  which currently creates a web page should be changed to up=
date / verify git notes in a namespace dedicated to backporting, in a jso=
n format that is rigid and meant to be consistent and reliable. And the w=
eb page should be a display of these git notes instead of what it current=
ly is. The default git notes name space could be used by developers to st=
ore human edited notes about commits such as the Backport field etc. beca=
use there is value in loosely maintained information.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--aoHqotMLnNX2NfHC798NaBw7T0VNvQ5cm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUsIVYACgkQ8dLMyEl6F20Y/QCfTOON9/1MmH4be9mH4SGbxkNh
o6QAn3OfpZ3xO6kJDmKaE2heZuQg4hy/
=M5ls
-----END PGP SIGNATURE-----

--aoHqotMLnNX2NfHC798NaBw7T0VNvQ5cm--
