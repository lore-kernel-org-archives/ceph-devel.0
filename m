From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Sat, 14 Feb 2015 22:53:07 +0100
Message-ID: <54DFC3C3.7030701@dachary.org>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com> <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com> <54DEEC5C.4030605@dachary.org> <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com> <1611171464.18352749.1423930970636.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AQ72r87W4P3hbvPaSgR9X7WRAjapE7E3l"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44123 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754382AbbBNVxN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 16:53:13 -0500
In-Reply-To: <1611171464.18352749.1423930970636.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQ72r87W4P3hbvPaSgR9X7WRAjapE7E3l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On 14/02/2015 17:22, Yuri Weinstein wrote:
>> Yeah. Well, the last run alone isn't so important; we want to see a
>> string of clean runs because a lot of issues aren't reproduced in
>> every run.
>=20
> My hope was that we can see all "green" results for say this giant rele=
ase/backport, but I agree that we would need to make our go/no-go decisio=
n based on multiple run results, as I am not sure if we can get them all =
"green" due to complexity, time needed to execute, environment state etc.=
=2E
>=20
> We could thou modify our process a bit:
> 1. after backport-branch is ready for QE, merge it to the named branch =
(say 'giant' in this example) - that what we did now
> 2. cut a release numbered brach (maybe it's tag, not sure), say "v0.87.=
1"
> 3. run all QE suites on "v0.87.1" and get it to "all passed" state
> 4. make sure that commits to "v0.87.1" are committed to the named branc=
h ('giant')=20

That makes sense to me, only with s/v0.87.1/78c71b9200da5e7d832ec58765478=
404d31ae6b5/.

> #2 is that we have not done this time.

We have not done #2 but we have cut the branch at given SHA ( 78c71b9200d=
a5e7d832ec58765478404d31ae6b5 ) instead, which is can be referenced by a =
tag if and when it is released. In the mail "Re: giant integration branch=
 for v0.87.1 ready for QE" dated 11th february 2015 I wrote:

> The giant-backports pull requests were merged into https://github.com/c=
eph/ceph/tree/giant which is not ready for testing.

> For the record, the head is https://github.com/ceph/ceph/commit/78c71b9=
200da5e7d832ec58765478404d31ae6b5

We cannot add a v0.87.1 tag to the branch before the release process is c=
omplete because we won't be able to change it afterwards (people rely on =
the fact that the history of the giant branch is not rewritten and that t=
ags references are not changed). If during the QE test process we discove=
r that a backport must be included (I'm thinking about https://github.com=
/ceph/ceph/pull/3731 for instance), 78c71b9200da5e7d832ec58765478404d31ae=
6b5 won't be v0.87.1 after all.

In a nutshell I think we're having the same view of the process, modulo t=
he timing of the tagging of the release.

Cheers

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Gregory Farnum" <greg@gregs42.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Friday, February 13, 2015 11:56:18 PM
> Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13=
:01-samba-giant-distro-basic-multi
>=20
> On Fri, Feb 13, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Greg,
>>
>> I'm curious to know how you handle the flow of mails from QA runs. Her=
e is a wild guess:
>>
>> * from time to time check that the nightlies run the suites that shoul=
d be run
>=20
> Uh, I guess?
>=20
>> * read the ceph-qa reports daily
>=20
> Yeah
>=20
>> * for each failed job, either relate it to an issue or create one or d=
eclare it noise
>=20
> Yeah
>=20
>> * if a job fails on an existing ticket store a link to the job if it's=
 rare occurrence and the cause is not yet known
>=20
> Yeah, or just to make clear it's still happening or whatever
>=20
>> * bi-weekly bug scrub makes sure no issue, old or new, is forgotten
>=20
> Hopefully!
>=20
>> * at release time you decide that it is ready based on:
>> ** the list of urgent/immediate issues that you can browse to ensure n=
o issue is a blocker
>> ** the last run of each suite to ensure they are recent enough and env=
ironmental noise did not permanently shadow anything
>=20
> Yeah. Well, the last run alone isn't so important; we want to see a
> string of clean runs because a lot of issues aren't reproduced in
> every run.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--AQ72r87W4P3hbvPaSgR9X7WRAjapE7E3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTfw8MACgkQ8dLMyEl6F226nQCgmYhEWJGowsOm/eFTwv8ZMpdZ
X4UAn1BQ/Q3kJejq7mNAmEte6lO6+qle
=mdSY
-----END PGP SIGNATURE-----

--AQ72r87W4P3hbvPaSgR9X7WRAjapE7E3l--
