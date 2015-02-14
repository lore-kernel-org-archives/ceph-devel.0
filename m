From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Sat, 14 Feb 2015 23:12:05 +0100
Message-ID: <54DFC835.8080901@dachary.org>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com> <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com> <54DEEC5C.4030605@dachary.org> <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com> <1611171464.18352749.1423930970636.JavaMail.zimbra@redhat.com> <54DFC3C3.7030701@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1siS8P6gN77obWnF037gHbl4AMm08g4mw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44129 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754361AbbBNWMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 17:12:08 -0500
In-Reply-To: <54DFC3C3.7030701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1siS8P6gN77obWnF037gHbl4AMm08g4mw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14/02/2015 22:53, Loic Dachary wrote:
> Hi Yuri,
>=20
> On 14/02/2015 17:22, Yuri Weinstein wrote:
>>> Yeah. Well, the last run alone isn't so important; we want to see a
>>> string of clean runs because a lot of issues aren't reproduced in
>>> every run.
>>
>> My hope was that we can see all "green" results for say this giant rel=
ease/backport, but I agree that we would need to make our go/no-go decisi=
on based on multiple run results, as I am not sure if we can get them all=
 "green" due to complexity, time needed to execute, environment state etc=
=2E.
>>
>> We could thou modify our process a bit:
>> 1. after backport-branch is ready for QE, merge it to the named branch=
 (say 'giant' in this example) - that what we did now
>> 2. cut a release numbered brach (maybe it's tag, not sure), say "v0.87=
=2E1"
>> 3. run all QE suites on "v0.87.1" and get it to "all passed" state
>> 4. make sure that commits to "v0.87.1" are committed to the named bran=
ch ('giant')=20
>=20
> That makes sense to me, only with s/v0.87.1/78c71b9200da5e7d832ec587654=
78404d31ae6b5/.
>=20
>> #2 is that we have not done this time.
>=20
> We have not done #2 but we have cut the branch at given SHA ( 78c71b920=
0da5e7d832ec58765478404d31ae6b5 ) instead, which is can be referenced by =
a tag if and when it is released. In the mail "Re: giant integration bran=
ch for v0.87.1 ready for QE" dated 11th february 2015 I wrote:
>=20
>> The giant-backports pull requests were merged into https://github.com/=
ceph/ceph/tree/giant which is not ready for testing.
>=20
>> For the record, the head is https://github.com/ceph/ceph/commit/78c71b=
9200da5e7d832ec58765478404d31ae6b5
>=20
> We cannot add a v0.87.1 tag to the branch before the release process is=
 complete because we won't be able to change it afterwards (people rely o=
n the fact that the history of the giant branch is not rewritten and that=
 tags references are not changed). If during the QE test process we disco=
ver that a backport must be included (I'm thinking about https://github.c=
om/ceph/ceph/pull/3731 for instance), 78c71b9200da5e7d832ec58765478404d31=
ae6b5 won't be v0.87.1 after all.
>=20
> In a nutshell I think we're having the same view of the process, modulo=
 the timing of the tagging of the release.

We could also have tags like:

v0.87.1-rc1 =3D> 78c71b9200da5e7d832ec58765478404d31ae6b5
v0.87.1-rc2 =3D> whatever SHA includes more backports

and if v0.87.1-rc2 turns out to be good the release notes could be commit=
ted and other non code changes. This naming scheme common, is there a dow=
nside to it ? It's easier to talk about v0.87.1-rc1 rather than 78c71b920=
0da5e7d832ec58765478404d31ae6b5 ;-)=20

Cheers

>=20
> Cheers
>=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Gregory Farnum" <greg@gregs42.com>
>> To: "Loic Dachary" <loic@dachary.org>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Friday, February 13, 2015 11:56:18 PM
>> Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:1=
3:01-samba-giant-distro-basic-multi
>>
>> On Fri, Feb 13, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> Hi Greg,
>>>
>>> I'm curious to know how you handle the flow of mails from QA runs. He=
re is a wild guess:
>>>
>>> * from time to time check that the nightlies run the suites that shou=
ld be run
>>
>> Uh, I guess?
>>
>>> * read the ceph-qa reports daily
>>
>> Yeah
>>
>>> * for each failed job, either relate it to an issue or create one or =
declare it noise
>>
>> Yeah
>>
>>> * if a job fails on an existing ticket store a link to the job if it'=
s rare occurrence and the cause is not yet known
>>
>> Yeah, or just to make clear it's still happening or whatever
>>
>>> * bi-weekly bug scrub makes sure no issue, old or new, is forgotten
>>
>> Hopefully!
>>
>>> * at release time you decide that it is ready based on:
>>> ** the list of urgent/immediate issues that you can browse to ensure =
no issue is a blocker
>>> ** the last run of each suite to ensure they are recent enough and en=
vironmental noise did not permanently shadow anything
>>
>> Yeah. Well, the last run alone isn't so important; we want to see a
>> string of clean runs because a lot of issues aren't reproduced in
>> every run.
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1siS8P6gN77obWnF037gHbl4AMm08g4mw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTfyDUACgkQ8dLMyEl6F22pwgCgjeSEdMLIp6DuYPRh653xBEMr
sTwAnjPEMNtHrfpY74lmLnfks/HCdJVJ
=mKE6
-----END PGP SIGNATURE-----

--1siS8P6gN77obWnF037gHbl4AMm08g4mw--
