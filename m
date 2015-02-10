From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 20:15:49 +0100
Message-ID: <54DA58E5.3070205@dachary.org>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com> <54DA3E72.9010600@dachary.org> <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com> <54DA4843.10901@dachary.org> <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com> <alpine.DEB.2.00.1502101028380.1652@cobra.newdream.net> <54DA56C3.9030305@dachary.org> <438607014.14983802.1423595518302.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TXolVbp8js8MS99jaWPeumaDUQh0Qsbui"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41980 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752187AbbBJTPw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 14:15:52 -0500
In-Reply-To: <438607014.14983802.1423595518302.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TXolVbp8js8MS99jaWPeumaDUQh0Qsbui
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The dumpling branch now contains the commits that were in the dumpling-ba=
ckports branch, they have been merged.

https://github.com/ceph/ceph/commit/77dfbbaccfb5074899d02314a26cb9ac46a69=
106

is the head of the dumpling branch I'm refering to.

Cheers

On 10/02/2015 20:11, Yuri Weinstein wrote:
> Great!
>=20
> As soon as it's merged I will schedule suite to run as listed somewhere=
 below ...
>=20
> dumpling with higher priority and then giant.
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Sage Weil" <sage@newdream.net>, "Gregory Farnum" <greg@gregs42.com=
>
> Cc: "Yuri Weinstein" <yweinste@redhat.com>, "Ceph Development" <ceph-de=
vel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 11:06:43 AM
> Subject: Re: dumpling integration branch for v0.67.12 ready for QE
>=20
> Hi,
>=20
> That's too much information for me to digest quickly. Instead of stalli=
ng I will go ahead and merge the dumpling pull requests into the dumpling=
 branch so that Yuri can proceed. And I'll take time to revise my underst=
anding of the backport workflow with your input.
>=20
> Cheers
>=20
> On 10/02/2015 19:37, Sage Weil wrote:
>> On Tue, 10 Feb 2015, Gregory Farnum wrote:
>>> On Tue, Feb 10, 2015 at 10:04 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>>>
>>>>
>>>> On 10/02/2015 18:29, Yuri Weinstein wrote:>
>>>>> On 10/02/2015 18:19, Yuri Weinstein wrote:>
>>>>>> Loic,
>>>>>>
>>>>>> The only difference between options if we run suits on merged dump=
ling vs dumpling-backports first - is time.
>>>>>> We will have to run suites on the final branch after the merge any=
way.
>>>>>
>>>>> Could you explain why ? After merging dumpling and dumpling-backpor=
ts will be exactly the same.
>>>>>
>>>>> Loic - I feel that finial QE validation should be done on the code =
that gets actually released to customers, e.g. dumpling branch after the =
merge.  I do see your point about branches being identical and ready to c=
hange my mind if you insist.  Does my reasoning make sense?  Please advic=
e, how we should proceed.
>>>>
>>>> The dumpling-backports branch currently is at
>>>>
>>>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7=
e4f20410
>>>>
>>>> after a successful test run from QE and a merge into dumpling, the d=
umpling branch will be at
>>>>
>>>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7=
e4f20410
>>>>
>>>> as well. In other words they are identical and there is no point in =
running a test again. The only reason why they could be different is if a=
 commit is inadvertently added to the dumpling branch while testing happe=
ns on the dumpling-backport branc. In this case the presence of this new =
commit would be reason enough to run another round of test indeed. So the=
 process could be:
>>>>
>>>> If tests are ok and merge can fast forward, then release.
>>>> If tests are ok and merge cannot fast forward, send back to loic bec=
ause a commit was added by accident and needs to be approved by the leads=
=2E
>>>>
>>>> If testing happens on the dumpling branch, adding a commit to the du=
mpling branch would have side effects that could taint the results of the=
 tests or, even worse, go unnoticed. There is zero chance that someone ad=
ds a commit to the dumpling-backports branch and that gives us something =
stable. On the contrary, the odds that someone adds a commit to the dumpl=
ing branch are high, specially if the tests take a few weeks to complete.=

>>>>
>>>> As Greg mentioned, merging in dumpling does not matter much for this=
 round because it is what has been done in the past. And to be honest, I =
would not mind if an additional commit taints the process by accident. Ho=
wever, unless there is a reason not to, it would be good to establish a p=
rocess that is solid if we can.
>>>>
>>>> I've witnessed Alfredo's pain on each release and an additional bene=
fit of having a dumpling-backports branch that nobody tampers with just o=
ccured to me. When and if QE finds that dumpling-backports is fit for rel=
ease, instead of merging it into dumpling it could be handed over to Alfr=
edo for release. And he would be able to proceed knowing it is stable and=
 won't be moving forward. Once the release is done and the tag set to the=
 proper commit, the dumpling branch can be reset to dumpling-backports. I=
f commits were added during the process, their authors could be notified =
that they were discarded and need to be merge again. That would not work =
for the master branch but it would definitely be possible for the stable =
branches because such "out of process" commits are rarely added.
>>>>
>>>> I've not thought this through, but the more I think about it the mor=
e I like the idea of using dumpling-backports as a staging area until the=
 release is final.
>>>
>>> What's the purpose of even having a dumpling branch at that point?
>>> We're not using it for anything under your model.
>>
>> Yeah, it seems to me like the same general process we use for 'next' a=
nd=20
>> 'master' would work here:
>>
>>  - prepare a batch of backports, say dumpling-rgw-next
>>  - run it through the rgw suite
>>  - if that is okay, merge to dumpling
>>  - run regular tests on dumpling (all suites)
>>
>> so that dumpling acts as in integration branch the same way the others=
 do.  =20
>> This is reasonably lightweight on process and means that our periodic =

>> scheduled runs are doing double duty for the integration testing and=20
>> catching long-tail bugs.
>>
>> After talking through the last release vs 'next' branch race with Alfr=
edo=20
>> I think (?) we've established that it is a non-issue.  If a release bu=
ild=20
>> races with a branch update it shows up as a merge commit in the histor=
y=20
>> (just like a regular 'git pull').
>>
>> Unless we're specifically concerned about things landing in dumpling (=
or=20
>> whatever) just prior to a release?
>>
>> sage
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TXolVbp8js8MS99jaWPeumaDUQh0Qsbui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaWOUACgkQ8dLMyEl6F22z2ACeMDCZf16+RiNlMpsaI2FRgVfJ
EGwAmgKltA7wL9l/rEBTnVFjGTgibWCl
=6DBV
-----END PGP SIGNATURE-----

--TXolVbp8js8MS99jaWPeumaDUQh0Qsbui--
