From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Mon, 16 Feb 2015 10:35:42 +0100
Message-ID: <54E1B9EE.1030902@dachary.org>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com> <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com> <54DEEC5C.4030605@dachary.org> <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com> <1611171464.18352749.1423930970636.JavaMail.zimbra@redhat.com> <54DFC3C3.7030701@dachary.org> <54DFC835.8080901@dachary.org> <1926075077.18550266.1423952419329.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bb936uCaleMnRBpITjNJM9G26FG5CHw7K"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44561 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754774AbbBPJfq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Feb 2015 04:35:46 -0500
In-Reply-To: <1926075077.18550266.1423952419329.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bb936uCaleMnRBpITjNJM9G26FG5CHw7K
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14/02/2015 23:20, Yuri Weinstein wrote:
> Loic,
>=20
> +1 - I like the way you're discussing:
>=20
> v0.87.1-rc2
> v0.87.1-rcX =3D> v0.87.1 - is it easy to make this look like this after=
 the validation is completed?

Actually (Alfredo can confirm) it is the release process that sets the ta=
g. From a higher level the process could be described as:

* All developer leads agree that v0.87.1-rcX is ready for release
* QE tests v0.87.1-rcX and
** return it to the developers if issues are found
** gives v0.87.1-rcX to the release team if no issues are found
* the release team publishes v0.87.1

Cheers

> BTW:  When I re-run suites now for validation I use "-s <named_branch>"=
 arg in the command line.   Maybe I should be using SHA ref instead?  I n=
ever tried this way, but guessing it should work, what do you think?
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 14, 2015 2:12:05 PM
> Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13=
:01-samba-giant-distro-basic-multi
>=20
>=20
>=20
> On 14/02/2015 22:53, Loic Dachary wrote:
>> Hi Yuri,
>>
>> On 14/02/2015 17:22, Yuri Weinstein wrote:
>>>> Yeah. Well, the last run alone isn't so important; we want to see a
>>>> string of clean runs because a lot of issues aren't reproduced in
>>>> every run.
>>>
>>> My hope was that we can see all "green" results for say this giant re=
lease/backport, but I agree that we would need to make our go/no-go decis=
ion based on multiple run results, as I am not sure if we can get them al=
l "green" due to complexity, time needed to execute, environment state et=
c..
>>>
>>> We could thou modify our process a bit:
>>> 1. after backport-branch is ready for QE, merge it to the named branc=
h (say 'giant' in this example) - that what we did now
>>> 2. cut a release numbered brach (maybe it's tag, not sure), say "v0.8=
7.1"
>>> 3. run all QE suites on "v0.87.1" and get it to "all passed" state
>>> 4. make sure that commits to "v0.87.1" are committed to the named bra=
nch ('giant')=20
>>
>> That makes sense to me, only with s/v0.87.1/78c71b9200da5e7d832ec58765=
478404d31ae6b5/.
>>
>>> #2 is that we have not done this time.
>>
>> We have not done #2 but we have cut the branch at given SHA ( 78c71b92=
00da5e7d832ec58765478404d31ae6b5 ) instead, which is can be referenced by=
 a tag if and when it is released. In the mail "Re: giant integration bra=
nch for v0.87.1 ready for QE" dated 11th february 2015 I wrote:
>>
>>> The giant-backports pull requests were merged into https://github.com=
/ceph/ceph/tree/giant which is not ready for testing.
>>
>>> For the record, the head is https://github.com/ceph/ceph/commit/78c71=
b9200da5e7d832ec58765478404d31ae6b5
>>
>> We cannot add a v0.87.1 tag to the branch before the release process i=
s complete because we won't be able to change it afterwards (people rely =
on the fact that the history of the giant branch is not rewritten and tha=
t tags references are not changed). If during the QE test process we disc=
over that a backport must be included (I'm thinking about https://github.=
com/ceph/ceph/pull/3731 for instance), 78c71b9200da5e7d832ec58765478404d3=
1ae6b5 won't be v0.87.1 after all.
>>
>> In a nutshell I think we're having the same view of the process, modul=
o the timing of the tagging of the release.
>=20
> We could also have tags like:
>=20
> v0.87.1-rc1 =3D> 78c71b9200da5e7d832ec58765478404d31ae6b5
> v0.87.1-rc2 =3D> whatever SHA includes more backports
>=20
> and if v0.87.1-rc2 turns out to be good the release notes could be comm=
itted and other non code changes. This naming scheme common, is there a d=
ownside to it ? It's easier to talk about v0.87.1-rc1 rather than 78c71b9=
200da5e7d832ec58765478404d31ae6b5 ;-)=20
>=20
> Cheers
>=20
>>
>> Cheers
>>
>>>
>>> Thx
>>> YuriW
>>>
>>> ----- Original Message -----
>>> From: "Gregory Farnum" <greg@gregs42.com>
>>> To: "Loic Dachary" <loic@dachary.org>
>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Friday, February 13, 2015 11:56:18 PM
>>> Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:=
13:01-samba-giant-distro-basic-multi
>>>
>>> On Fri, Feb 13, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>> Hi Greg,
>>>>
>>>> I'm curious to know how you handle the flow of mails from QA runs. H=
ere is a wild guess:
>>>>
>>>> * from time to time check that the nightlies run the suites that sho=
uld be run
>>>
>>> Uh, I guess?
>>>
>>>> * read the ceph-qa reports daily
>>>
>>> Yeah
>>>
>>>> * for each failed job, either relate it to an issue or create one or=
 declare it noise
>>>
>>> Yeah
>>>
>>>> * if a job fails on an existing ticket store a link to the job if it=
's rare occurrence and the cause is not yet known
>>>
>>> Yeah, or just to make clear it's still happening or whatever
>>>
>>>> * bi-weekly bug scrub makes sure no issue, old or new, is forgotten
>>>
>>> Hopefully!
>>>
>>>> * at release time you decide that it is ready based on:
>>>> ** the list of urgent/immediate issues that you can browse to ensure=
 no issue is a blocker
>>>> ** the last run of each suite to ensure they are recent enough and e=
nvironmental noise did not permanently shadow anything
>>>
>>> Yeah. Well, the last run alone isn't so important; we want to see a
>>> string of clean runs because a lot of issues aren't reproduced in
>>> every run.
>>> -Greg
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--bb936uCaleMnRBpITjNJM9G26FG5CHw7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlThue4ACgkQ8dLMyEl6F200DACfaaEwOGEQtGSXb3kFhK9Tz17t
9VoAoJ6N9gtNML/VupX2MRro8YJh+xT/
=noEO
-----END PGP SIGNATURE-----

--bb936uCaleMnRBpITjNJM9G26FG5CHw7K--
