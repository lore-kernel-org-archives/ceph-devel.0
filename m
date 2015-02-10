From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 14:11:58 -0500 (EST)
Message-ID: <438607014.14983802.1423595518302.JavaMail.zimbra@redhat.com>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com> <54DA3E72.9010600@dachary.org> <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com> <54DA4843.10901@dachary.org> <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com> <alpine.DEB.2.00.1502101028380.1652@cobra.newdream.net> <54DA56C3.9030305@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:45675 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbBJTND convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 14:13:03 -0500
In-Reply-To: <54DA56C3.9030305@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>

Great!

As soon as it's merged I will schedule suite to run as listed somewhere=
 below ...

dumpling with higher priority and then giant.

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Sage Weil" <sage@newdream.net>, "Gregory Farnum" <greg@gregs42.com=
>
Cc: "Yuri Weinstein" <yweinste@redhat.com>, "Ceph Development" <ceph-de=
vel@vger.kernel.org>
Sent: Tuesday, February 10, 2015 11:06:43 AM
Subject: Re: dumpling integration branch for v0.67.12 ready for QE

Hi,

That's too much information for me to digest quickly. Instead of stalli=
ng I will go ahead and merge the dumpling pull requests into the dumpli=
ng branch so that Yuri can proceed. And I'll take time to revise my und=
erstanding of the backport workflow with your input.

Cheers

On 10/02/2015 19:37, Sage Weil wrote:
> On Tue, 10 Feb 2015, Gregory Farnum wrote:
>> On Tue, Feb 10, 2015 at 10:04 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>
>>>
>>> On 10/02/2015 18:29, Yuri Weinstein wrote:>
>>>> On 10/02/2015 18:19, Yuri Weinstein wrote:>
>>>>> Loic,
>>>>>
>>>>> The only difference between options if we run suits on merged dum=
pling vs dumpling-backports first - is time.
>>>>> We will have to run suites on the final branch after the merge an=
yway.
>>>>
>>>> Could you explain why ? After merging dumpling and dumpling-backpo=
rts will be exactly the same.
>>>>
>>>> Loic - I feel that finial QE validation should be done on the code=
 that gets actually released to customers, e.g. dumpling branch after t=
he merge.  I do see your point about branches being identical and ready=
 to change my mind if you insist.  Does my reasoning make sense?  Pleas=
e advice, how we should proceed.
>>>
>>> The dumpling-backports branch currently is at
>>>
>>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd=
7e4f20410
>>>
>>> after a successful test run from QE and a merge into dumpling, the =
dumpling branch will be at
>>>
>>> https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd=
7e4f20410
>>>
>>> as well. In other words they are identical and there is no point in=
 running a test again. The only reason why they could be different is i=
f a commit is inadvertently added to the dumpling branch while testing =
happens on the dumpling-backport branc. In this case the presence of th=
is new commit would be reason enough to run another round of test indee=
d. So the process could be:
>>>
>>> If tests are ok and merge can fast forward, then release.
>>> If tests are ok and merge cannot fast forward, send back to loic be=
cause a commit was added by accident and needs to be approved by the le=
ads.
>>>
>>> If testing happens on the dumpling branch, adding a commit to the d=
umpling branch would have side effects that could taint the results of =
the tests or, even worse, go unnoticed. There is zero chance that someo=
ne adds a commit to the dumpling-backports branch and that gives us som=
ething stable. On the contrary, the odds that someone adds a commit to =
the dumpling branch are high, specially if the tests take a few weeks t=
o complete.
>>>
>>> As Greg mentioned, merging in dumpling does not matter much for thi=
s round because it is what has been done in the past. And to be honest,=
 I would not mind if an additional commit taints the process by acciden=
t. However, unless there is a reason not to, it would be good to establ=
ish a process that is solid if we can.
>>>
>>> I've witnessed Alfredo's pain on each release and an additional ben=
efit of having a dumpling-backports branch that nobody tampers with jus=
t occured to me. When and if QE finds that dumpling-backports is fit fo=
r release, instead of merging it into dumpling it could be handed over =
to Alfredo for release. And he would be able to proceed knowing it is s=
table and won't be moving forward. Once the release is done and the tag=
 set to the proper commit, the dumpling branch can be reset to dumpling=
-backports. If commits were added during the process, their authors cou=
ld be notified that they were discarded and need to be merge again. Tha=
t would not work for the master branch but it would definitely be possi=
ble for the stable branches because such "out of process" commits are r=
arely added.
>>>
>>> I've not thought this through, but the more I think about it the mo=
re I like the idea of using dumpling-backports as a staging area until =
the release is final.
>>
>> What's the purpose of even having a dumpling branch at that point?
>> We're not using it for anything under your model.
>=20
> Yeah, it seems to me like the same general process we use for 'next' =
and=20
> 'master' would work here:
>=20
>  - prepare a batch of backports, say dumpling-rgw-next
>  - run it through the rgw suite
>  - if that is okay, merge to dumpling
>  - run regular tests on dumpling (all suites)
>=20
> so that dumpling acts as in integration branch the same way the other=
s do.  =20
> This is reasonably lightweight on process and means that our periodic=
=20
> scheduled runs are doing double duty for the integration testing and=20
> catching long-tail bugs.
>=20
> After talking through the last release vs 'next' branch race with Alf=
redo=20
> I think (?) we've established that it is a non-issue.  If a release b=
uild=20
> races with a branch update it shows up as a merge commit in the histo=
ry=20
> (just like a regular 'git pull').
>=20
> Unless we're specifically concerned about things landing in dumpling =
(or=20
> whatever) just prior to a release?
>=20
> sage
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
