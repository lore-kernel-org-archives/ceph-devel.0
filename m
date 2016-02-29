From: Loic Dachary <loic@dachary.org>
Subject: Re: (Un)Stable release team
Date: Mon, 29 Feb 2016 21:47:48 +0700
Message-ID: <56D45A14.2060906@dachary.org>
References: <56D001C6.5080804@dachary.org>
 <CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
 <56D3F913.8020008@dachary.org> <56D42F0B.9050304@dachary.org>
 <CAP3mxSy+VODD72z0LtZ0iJ5YMDqAnLOtV3p460yg9_QuW63Q2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:32883 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcB2OsD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 09:48:03 -0500
In-Reply-To: <CAP3mxSy+VODD72z0LtZ0iJ5YMDqAnLOtV3p460yg9_QuW63Q2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 29/02/2016 19:46, Abhishek Varshney wrote:
> Hi Loic,
>=20
> On Mon, Feb 29, 2016 at 5:14 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> To quickly summarize the discussion on IRC, should we decide to go f=
or improving paddles, it would probably make sense to:
>>
>> * Implement a mirror feature in paddles. A new paddle could query an=
 existing paddle and update its database with what it finds there. The =
issue / comment fields would only be allowed on completed runs which ar=
e immutable in the existing paddles and do not cause problems with sync=
rhonization.
>> * A centralized paddles read/write to the public would mirror inform=
ation from the paddles that are used by http://pulpito.ceph.com/ and ht=
tp://pulpito.ovh.sepia.ceph.com:8081/
>> * A pulpito would run from this centralized paddles and implement ne=
w features, with no risk to disrupt the existing paddles/pulpito, which=
 would be a good testbed to demonstrate pull requests implementing thes=
e new features can be accepted
>> * teuthology-openstack ( or ceph-workbench ceph-qa-suite ) would hav=
e a new --paddles options to use this centralized paddles server instea=
d of creating a new one, so that results are archived in a permanent pl=
ace (that would be the default).
>=20
> This looks good to me. This would mean that paddles+pulpito would
> eventually evolve into more interactive tool :)

Yes. And more plain text if I can help it ;-)

>>
>> On 29/02/2016 14:53, Loic Dachary wrote:
>>> Hi,
>>>
>>> This week-end I updated http://ceph-workbench.dachary.org/root/ceph=
-workbench and got the integration tests to pass again (a few minor iss=
ues broke it in the past two months http://ceph-workbench.dachary.org/r=
oot/ceph-workbench/activity). I suppose the most important item in the =
backlog is to have a convenient way to record the teuthology runs and a=
ssociate them with known issues. I updated http://ceph-workbench.dachar=
y.org/root/ceph-workbench/issues/26 with a short description of what it=
 would look like if we used the redmine wiki for that purpose. But it f=
eels fragile and redundant with paddles (the database that records the =
tests).
>>>
>>> I think we have three options to automate the use case we want (i.e=
=2E what we've been doing at http://tracker.ceph.com/issues/14692 & al)=
=2E
>>>
>>> * Automate the redmine update using issue comments & wiki pages (ht=
tp://ceph-workbench.dachary.org/root/ceph-workbench/issues/26).
>>> * Create a git-notes database with links to issues / pr / test resu=
lts (http://ceph-workbench.dachary.org/root/ceph-workbench/issues/5)
>>> * Improve paddles / pulpito
>>>
>>> We've discussed the first two options extensively over the past yea=
r but not so much the idea of improving paddles / pulpito. Maybe becaus=
e pulpito is too much web and not enough plain text for my taste, at le=
ast that's one of the things that comes to mind. But this can probably =
be improved as well. It could go
>>> like this:
>>>
>>> * Add an "issue" and "comment" field in paddles for each test.
>>> * Add a query to show all jobs that ran against a given SHA1 to pad=
dles (that's the focus we have in the stable release issues)
>>> * Add a query to show all run of a given job (based on the descript=
ion) to paddles
>>> * Add a redmine friendly text output to pulpito so that it can be c=
opy/pasted to a comment (instead of doing what we do with the fail.py s=
cript and maybe more)
>>> * Add the input fields in pulpito to fill the "issue" field and the=
 "comment" field to the pulpito UI (which is what we do when analyzing =
failures).
>>>
>>> What do you think ?
>>>
>>> Cheers
>>>
>>> On 26/02/2016 15:12, Abhishek Varshney wrote:
>>>> Hi Loic,
>>>>
>>>> On Fri, Feb 26, 2016 at 1:11 PM, Loic Dachary <loic@dachary.org> w=
rote:
>>>>> Hi,
>>>>>
>>>>> It's a quiet time in the small world of the stable release team, =
ideal for mentoring the new members who generously answered our call fo=
r participation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng,=
 Martin Palma and Chris Jones :-)
>>>>>
>>>>> I propose that we take advantage of the next few weeks to expand =
our scope in two ways:
>>>>>
>>>>> * test Ceph development versions as well as stable versions
>>>>> * publish packages for Ceph development versions
>>>>>
>>>>> Testing Ceph development versions is actually less work than with=
 stable versions because the developers run a lot of tests already and =
fix problems on a daily basis. Our help would likely be needed with a f=
ew teuthology suite runs right before the development release is publis=
hed, once a month. But the development versions tend to be more frequen=
t, therefore it will probably be as much work as for a stable release, =
overall. The workflow would be revisited: there is no cherry-picking. I=
nstead, bug fixes must be against the jewel branch or whatever branch w=
ill be the upcoming stable. And this branch is merged back into master =
on a regular basis (i.e. more frequently than the development releases)=
=2E
>>>>>
>>>>> As you may have noticed, no packages were published for the 10.0.=
3 development release and that's where we could make a real difference.=
 This would be an entirely new part of our workflow, but also an exciti=
ng one because it's the last missing piece of the puzzle. Once we are a=
ble to publish usable packages for development releases, nothing is sto=
pping us to do the same for stable releases. It's a lot easier than it =
seems since the packages are already built for the teuthology jobs. All=
 we need is a public space to archive them and sign them. This is not m=
utually exclusive with the current package publication workflow, it wou=
ld be a community driven alternative that is much needed in some cases.
>>>>>
>>>>> Of course, this is easier said than done :-) What do you think ? =
Are there other important work that we should try to accomplish instead=
 ? Things that would benefit Ceph users and developers more ?
>>>>
>>>> Would it be a good idea to give some focus to ceph-workbench[1] to=
o
>>>> and formalise backport workflows, since we have a bigger Stable
>>>> Releases Team now?
>>>>
>>>> [1] https://pypi.python.org/pypi/ceph-workbench
>>>>
>>>>>
>>>>> Cheers
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>> Thanks
>>>> Abhishek
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
