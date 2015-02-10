From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 19:33:24 +0100
Message-ID: <54DA4EF4.8020304@dachary.org>
References: <54DA3A5B.5050509@dachary.org>	<54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>	<54DA3E72.9010600@dachary.org>	<867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com>	<54DA4843.10901@dachary.org> <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="emIDFVr3dNAqpt02mnq4AwuM3rS6Kwfxm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41931 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbbBJSd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 13:33:27 -0500
In-Reply-To: <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--emIDFVr3dNAqpt02mnq4AwuM3rS6Kwfxm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/02/2015 19:25, Gregory Farnum wrote:
> On Tue, Feb 10, 2015 at 10:04 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>>
>> On 10/02/2015 18:29, Yuri Weinstein wrote:>
>>> On 10/02/2015 18:19, Yuri Weinstein wrote:>
>>>> Loic,
>>>>
>>>> The only difference between options if we run suits on merged dumpli=
ng vs dumpling-backports first - is time.
>>>> We will have to run suites on the final branch after the merge anywa=
y.
>>>
>>> Could you explain why ? After merging dumpling and dumpling-backports=
 will be exactly the same.
>>>
>>> Loic - I feel that finial QE validation should be done on the code th=
at gets actually released to customers, e.g. dumpling branch after the me=
rge.  I do see your point about branches being identical and ready to cha=
nge my mind if you insist.  Does my reasoning make sense?  Please advice,=
 how we should proceed.
>>
>> The dumpling-backports branch currently is at
>>
>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4=
f20410
>>
>> after a successful test run from QE and a merge into dumpling, the dum=
pling branch will be at
>>
>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4=
f20410
>>
>> as well. In other words they are identical and there is no point in ru=
nning a test again. The only reason why they could be different is if a c=
ommit is inadvertently added to the dumpling branch while testing happens=
 on the dumpling-backport branc. In this case the presence of this new co=
mmit would be reason enough to run another round of test indeed. So the p=
rocess could be:
>>
>> If tests are ok and merge can fast forward, then release.
>> If tests are ok and merge cannot fast forward, send back to loic becau=
se a commit was added by accident and needs to be approved by the leads.
>>
>> If testing happens on the dumpling branch, adding a commit to the dump=
ling branch would have side effects that could taint the results of the t=
ests or, even worse, go unnoticed. There is zero chance that someone adds=
 a commit to the dumpling-backports branch and that gives us something st=
able. On the contrary, the odds that someone adds a commit to the dumplin=
g branch are high, specially if the tests take a few weeks to complete.
>>
>> As Greg mentioned, merging in dumpling does not matter much for this r=
ound because it is what has been done in the past. And to be honest, I wo=
uld not mind if an additional commit taints the process by accident. Howe=
ver, unless there is a reason not to, it would be good to establish a pro=
cess that is solid if we can.
>>
>> I've witnessed Alfredo's pain on each release and an additional benefi=
t of having a dumpling-backports branch that nobody tampers with just occ=
ured to me. When and if QE finds that dumpling-backports is fit for relea=
se, instead of merging it into dumpling it could be handed over to Alfred=
o for release. And he would be able to proceed knowing it is stable and w=
on't be moving forward. Once the release is done and the tag set to the p=
roper commit, the dumpling branch can be reset to dumpling-backports. If =
commits were added during the process, their authors could be notified th=
at they were discarded and need to be merge again. That would not work fo=
r the master branch but it would definitely be possible for the stable br=
anches because such "out of process" commits are rarely added.
>>
>> I've not thought this through, but the more I think about it the more =
I like the idea of using dumpling-backports as a staging area until the r=
elease is final.
>=20
> What's the purpose of even having a dumpling branch at that point?
> We're not using it for anything under your model.

The dumpling branch is where the point release are published. The dumplin=
g-backports branch is where the point release are developed and tested.

>=20
> Now, as it happens there are some reasons to maintain a dumpling
> branch that isn't part of backports. We've been doing a lot of work
> lately to make the nightlies behave well under RHEL and in various
> other environments, which sometimes involve changing the tests
> themselves. That can mean updating the ceph.git/qa/workunits in our
> LTS branches, which I've done a few times over the last couple of
> months. Since they're used for testing they aren't suitable for going
> through a backports workflow, we just want them to get into the
> nightlies as fast as possible. Tossing out any such work every time a
> point release appears would be irritating, to say the least.
> (We could also pull the workunits out of ceph.git, but that's a
> different discussion.)

This is a good point. I'm assuming backports rely on the dumpling branch =
of ceph-qa-suite. And if a change needs to be done in ceph-qa-suite for t=
he benefit of an ongoing backport effort to publish a point release, it w=
ill have to be done in such a way that it can work for both the current d=
umpling and the future point release.

Am I understanding you correctly ?=20

Cheers


> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--emIDFVr3dNAqpt02mnq4AwuM3rS6Kwfxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaTvQACgkQ8dLMyEl6F21U1wCgo9T5iDZWl6kn5JBhaTi6zJ54
etcAoKds1UStHXy5k8eYlZhpJ6De/38U
=6COt
-----END PGP SIGNATURE-----

--emIDFVr3dNAqpt02mnq4AwuM3rS6Kwfxm--
