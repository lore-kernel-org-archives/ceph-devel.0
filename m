From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in
 teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Sat, 14 Feb 2015 17:20:19 -0500 (EST)
Message-ID: <1926075077.18550266.1423952419329.JavaMail.zimbra@redhat.com>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com> <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com> <54DEEC5C.4030605@dachary.org> <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com> <1611171464.18352749.1423930970636.JavaMail.zimbra@redhat.com> <54DFC3C3.7030701@dachary.org> <54DFC835.8080901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:32998 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbbBNWVW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 17:21:22 -0500
In-Reply-To: <54DFC835.8080901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

+1 - I like the way you're discussing:

v0.87.1-rc2
v0.87.1-rcX =3D> v0.87.1 - is it easy to make this look like this after=
 the validation is completed?

BTW:  When I re-run suites now for validation I use "-s <named_branch>"=
 arg in the command line.   Maybe I should be using SHA ref instead?  I=
 never tried this way, but guessing it should work, what do you think?

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Saturday, February 14, 2015 2:12:05 PM
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13=
:01-samba-giant-distro-basic-multi



On 14/02/2015 22:53, Loic Dachary wrote:
> Hi Yuri,
>=20
> On 14/02/2015 17:22, Yuri Weinstein wrote:
>>> Yeah. Well, the last run alone isn't so important; we want to see a
>>> string of clean runs because a lot of issues aren't reproduced in
>>> every run.
>>
>> My hope was that we can see all "green" results for say this giant r=
elease/backport, but I agree that we would need to make our go/no-go de=
cision based on multiple run results, as I am not sure if we can get th=
em all "green" due to complexity, time needed to execute, environment s=
tate etc..
>>
>> We could thou modify our process a bit:
>> 1. after backport-branch is ready for QE, merge it to the named bran=
ch (say 'giant' in this example) - that what we did now
>> 2. cut a release numbered brach (maybe it's tag, not sure), say "v0.=
87.1"
>> 3. run all QE suites on "v0.87.1" and get it to "all passed" state
>> 4. make sure that commits to "v0.87.1" are committed to the named br=
anch ('giant')=20
>=20
> That makes sense to me, only with s/v0.87.1/78c71b9200da5e7d832ec5876=
5478404d31ae6b5/.
>=20
>> #2 is that we have not done this time.
>=20
> We have not done #2 but we have cut the branch at given SHA ( 78c71b9=
200da5e7d832ec58765478404d31ae6b5 ) instead, which is can be referenced=
 by a tag if and when it is released. In the mail "Re: giant integratio=
n branch for v0.87.1 ready for QE" dated 11th february 2015 I wrote:
>=20
>> The giant-backports pull requests were merged into https://github.co=
m/ceph/ceph/tree/giant which is not ready for testing.
>=20
>> For the record, the head is https://github.com/ceph/ceph/commit/78c7=
1b9200da5e7d832ec58765478404d31ae6b5
>=20
> We cannot add a v0.87.1 tag to the branch before the release process =
is complete because we won't be able to change it afterwards (people re=
ly on the fact that the history of the giant branch is not rewritten an=
d that tags references are not changed). If during the QE test process =
we discover that a backport must be included (I'm thinking about https:=
//github.com/ceph/ceph/pull/3731 for instance), 78c71b9200da5e7d832ec58=
765478404d31ae6b5 won't be v0.87.1 after all.
>=20
> In a nutshell I think we're having the same view of the process, modu=
lo the timing of the tagging of the release.

We could also have tags like:

v0.87.1-rc1 =3D> 78c71b9200da5e7d832ec58765478404d31ae6b5
v0.87.1-rc2 =3D> whatever SHA includes more backports

and if v0.87.1-rc2 turns out to be good the release notes could be comm=
itted and other non code changes. This naming scheme common, is there a=
 downside to it ? It's easier to talk about v0.87.1-rc1 rather than 78c=
71b9200da5e7d832ec58765478404d31ae6b5 ;-)=20

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
>> Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16=
:13:01-samba-giant-distro-basic-multi
>>
>> On Fri, Feb 13, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>> Hi Greg,
>>>
>>> I'm curious to know how you handle the flow of mails from QA runs. =
Here is a wild guess:
>>>
>>> * from time to time check that the nightlies run the suites that sh=
ould be run
>>
>> Uh, I guess?
>>
>>> * read the ceph-qa reports daily
>>
>> Yeah
>>
>>> * for each failed job, either relate it to an issue or create one o=
r declare it noise
>>
>> Yeah
>>
>>> * if a job fails on an existing ticket store a link to the job if i=
t's rare occurrence and the cause is not yet known
>>
>> Yeah, or just to make clear it's still happening or whatever
>>
>>> * bi-weekly bug scrub makes sure no issue, old or new, is forgotten
>>
>> Hopefully!
>>
>>> * at release time you decide that it is ready based on:
>>> ** the list of urgent/immediate issues that you can browse to ensur=
e no issue is a blocker
>>> ** the last run of each suite to ensure they are recent enough and =
environmental noise did not permanently shadow anything
>>
>> Yeah. Well, the last run alone isn't so important; we want to see a
>> string of clean runs because a lot of issues aren't reproduced in
>> every run.
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
