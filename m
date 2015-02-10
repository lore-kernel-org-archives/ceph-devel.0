From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 20:06:43 +0100
Message-ID: <54DA56C3.9030305@dachary.org>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com> <54DA3E72.9010600@dachary.org> <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com> <54DA4843.10901@dachary.org> <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com> <alpine.DEB.2.00.1502101028380.1652@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bxesWAI7Ta0bbKLLu5w15hI73dfS1pqQl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41963 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753454AbbBJTGr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 14:06:47 -0500
In-Reply-To: <alpine.DEB.2.00.1502101028380.1652@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bxesWAI7Ta0bbKLLu5w15hI73dfS1pqQl
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

That's too much information for me to digest quickly. Instead of stalling=
 I will go ahead and merge the dumpling pull requests into the dumpling b=
ranch so that Yuri can proceed. And I'll take time to revise my understan=
ding of the backport workflow with your input.

Cheers

On 10/02/2015 19:37, Sage Weil wrote:
> On Tue, 10 Feb 2015, Gregory Farnum wrote:
>> On Tue, Feb 10, 2015 at 10:04 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>
>>>
>>> On 10/02/2015 18:29, Yuri Weinstein wrote:>
>>>> On 10/02/2015 18:19, Yuri Weinstein wrote:>
>>>>> Loic,
>>>>>
>>>>> The only difference between options if we run suits on merged dumpl=
ing vs dumpling-backports first - is time.
>>>>> We will have to run suites on the final branch after the merge anyw=
ay.
>>>>
>>>> Could you explain why ? After merging dumpling and dumpling-backport=
s will be exactly the same.
>>>>
>>>> Loic - I feel that finial QE validation should be done on the code t=
hat gets actually released to customers, e.g. dumpling branch after the m=
erge.  I do see your point about branches being identical and ready to ch=
ange my mind if you insist.  Does my reasoning make sense?  Please advice=
, how we should proceed.
>>>
>>> The dumpling-backports branch currently is at
>>>
>>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e=
4f20410
>>>
>>> after a successful test run from QE and a merge into dumpling, the du=
mpling branch will be at
>>>
>>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e=
4f20410
>>>
>>> as well. In other words they are identical and there is no point in r=
unning a test again. The only reason why they could be different is if a =
commit is inadvertently added to the dumpling branch while testing happen=
s on the dumpling-backport branc. In this case the presence of this new c=
ommit would be reason enough to run another round of test indeed. So the =
process could be:
>>>
>>> If tests are ok and merge can fast forward, then release.
>>> If tests are ok and merge cannot fast forward, send back to loic beca=
use a commit was added by accident and needs to be approved by the leads.=

>>>
>>> If testing happens on the dumpling branch, adding a commit to the dum=
pling branch would have side effects that could taint the results of the =
tests or, even worse, go unnoticed. There is zero chance that someone add=
s a commit to the dumpling-backports branch and that gives us something s=
table. On the contrary, the odds that someone adds a commit to the dumpli=
ng branch are high, specially if the tests take a few weeks to complete.
>>>
>>> As Greg mentioned, merging in dumpling does not matter much for this =
round because it is what has been done in the past. And to be honest, I w=
ould not mind if an additional commit taints the process by accident. How=
ever, unless there is a reason not to, it would be good to establish a pr=
ocess that is solid if we can.
>>>
>>> I've witnessed Alfredo's pain on each release and an additional benef=
it of having a dumpling-backports branch that nobody tampers with just oc=
cured to me. When and if QE finds that dumpling-backports is fit for rele=
ase, instead of merging it into dumpling it could be handed over to Alfre=
do for release. And he would be able to proceed knowing it is stable and =
won't be moving forward. Once the release is done and the tag set to the =
proper commit, the dumpling branch can be reset to dumpling-backports. If=
 commits were added during the process, their authors could be notified t=
hat they were discarded and need to be merge again. That would not work f=
or the master branch but it would definitely be possible for the stable b=
ranches because such "out of process" commits are rarely added.
>>>
>>> I've not thought this through, but the more I think about it the more=
 I like the idea of using dumpling-backports as a staging area until the =
release is final.
>>
>> What's the purpose of even having a dumpling branch at that point?
>> We're not using it for anything under your model.
>=20
> Yeah, it seems to me like the same general process we use for 'next' an=
d=20
> 'master' would work here:
>=20
>  - prepare a batch of backports, say dumpling-rgw-next
>  - run it through the rgw suite
>  - if that is okay, merge to dumpling
>  - run regular tests on dumpling (all suites)
>=20
> so that dumpling acts as in integration branch the same way the others =
do.  =20
> This is reasonably lightweight on process and means that our periodic=20
> scheduled runs are doing double duty for the integration testing and=20
> catching long-tail bugs.
>=20
> After talking through the last release vs 'next' branch race with Alfre=
do=20
> I think (?) we've established that it is a non-issue.  If a release bui=
ld=20
> races with a branch update it shows up as a merge commit in the history=
=20
> (just like a regular 'git pull').
>=20
> Unless we're specifically concerned about things landing in dumpling (o=
r=20
> whatever) just prior to a release?
>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bxesWAI7Ta0bbKLLu5w15hI73dfS1pqQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaVsMACgkQ8dLMyEl6F23lfACfWkvme7kYLaxRM93YydIbDEkz
eg4An0u6D2ZC7vgMU7VuvSNCcy+A3hib
=0K78
-----END PGP SIGNATURE-----

--bxesWAI7Ta0bbKLLu5w15hI73dfS1pqQl--
