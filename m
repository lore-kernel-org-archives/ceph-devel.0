From: Loic Dachary <loic@dachary.org>
Subject: Re: (Un)Stable release team
Date: Mon, 29 Feb 2016 18:44:11 +0700
Message-ID: <56D42F0B.9050304@dachary.org>
References: <56D001C6.5080804@dachary.org>
 <CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
 <56D3F913.8020008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44849 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcB2LoW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 06:44:22 -0500
In-Reply-To: <56D3F913.8020008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

To quickly summarize the discussion on IRC, should we decide to go for =
improving paddles, it would probably make sense to:

* Implement a mirror feature in paddles. A new paddle could query an ex=
isting paddle and update its database with what it finds there. The iss=
ue / comment fields would only be allowed on completed runs which are i=
mmutable in the existing paddles and do not cause problems with syncrho=
nization.
* A centralized paddles read/write to the public would mirror informati=
on from the paddles that are used by http://pulpito.ceph.com/ and http:=
//pulpito.ovh.sepia.ceph.com:8081/
* A pulpito would run from this centralized paddles and implement new f=
eatures, with no risk to disrupt the existing paddles/pulpito, which wo=
uld be a good testbed to demonstrate pull requests implementing these n=
ew features can be accepted
* teuthology-openstack ( or ceph-workbench ceph-qa-suite ) would have a=
 new --paddles options to use this centralized paddles server instead o=
f creating a new one, so that results are archived in a permanent place=
 (that would be the default).

On 29/02/2016 14:53, Loic Dachary wrote:
> Hi,
>=20
> This week-end I updated http://ceph-workbench.dachary.org/root/ceph-w=
orkbench and got the integration tests to pass again (a few minor issue=
s broke it in the past two months http://ceph-workbench.dachary.org/roo=
t/ceph-workbench/activity). I suppose the most important item in the ba=
cklog is to have a convenient way to record the teuthology runs and ass=
ociate them with known issues. I updated http://ceph-workbench.dachary.=
org/root/ceph-workbench/issues/26 with a short description of what it w=
ould look like if we used the redmine wiki for that purpose. But it fee=
ls fragile and redundant with paddles (the database that records the te=
sts).=20
>=20
> I think we have three options to automate the use case we want (i.e. =
what we've been doing at http://tracker.ceph.com/issues/14692 & al).
>=20
> * Automate the redmine update using issue comments & wiki pages (http=
://ceph-workbench.dachary.org/root/ceph-workbench/issues/26).
> * Create a git-notes database with links to issues / pr / test result=
s (http://ceph-workbench.dachary.org/root/ceph-workbench/issues/5)
> * Improve paddles / pulpito
>=20
> We've discussed the first two options extensively over the past year =
but not so much the idea of improving paddles / pulpito. Maybe because =
pulpito is too much web and not enough plain text for my taste, at leas=
t that's one of the things that comes to mind. But this can probably be=
 improved as well. It could go=20
> like this:
>=20
> * Add an "issue" and "comment" field in paddles for each test.
> * Add a query to show all jobs that ran against a given SHA1 to paddl=
es (that's the focus we have in the stable release issues)
> * Add a query to show all run of a given job (based on the descriptio=
n) to paddles
> * Add a redmine friendly text output to pulpito so that it can be cop=
y/pasted to a comment (instead of doing what we do with the fail.py scr=
ipt and maybe more)
> * Add the input fields in pulpito to fill the "issue" field and the "=
comment" field to the pulpito UI (which is what we do when analyzing fa=
ilures).
>=20
> What do you think ?
>=20
> Cheers
>=20
> On 26/02/2016 15:12, Abhishek Varshney wrote:
>> Hi Loic,
>>
>> On Fri, Feb 26, 2016 at 1:11 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi,
>>>
>>> It's a quiet time in the small world of the stable release team, id=
eal for mentoring the new members who generously answered our call for =
participation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, M=
artin Palma and Chris Jones :-)
>>>
>>> I propose that we take advantage of the next few weeks to expand ou=
r scope in two ways:
>>>
>>> * test Ceph development versions as well as stable versions
>>> * publish packages for Ceph development versions
>>>
>>> Testing Ceph development versions is actually less work than with s=
table versions because the developers run a lot of tests already and fi=
x problems on a daily basis. Our help would likely be needed with a few=
 teuthology suite runs right before the development release is publishe=
d, once a month. But the development versions tend to be more frequent,=
 therefore it will probably be as much work as for a stable release, ov=
erall. The workflow would be revisited: there is no cherry-picking. Ins=
tead, bug fixes must be against the jewel branch or whatever branch wil=
l be the upcoming stable. And this branch is merged back into master on=
 a regular basis (i.e. more frequently than the development releases).
>>>
>>> As you may have noticed, no packages were published for the 10.0.3 =
development release and that's where we could make a real difference. T=
his would be an entirely new part of our workflow, but also an exciting=
 one because it's the last missing piece of the puzzle. Once we are abl=
e to publish usable packages for development releases, nothing is stopp=
ing us to do the same for stable releases. It's a lot easier than it se=
ems since the packages are already built for the teuthology jobs. All w=
e need is a public space to archive them and sign them. This is not mut=
ually exclusive with the current package publication workflow, it would=
 be a community driven alternative that is much needed in some cases.
>>>
>>> Of course, this is easier said than done :-) What do you think ? Ar=
e there other important work that we should try to accomplish instead ?=
 Things that would benefit Ceph users and developers more ?
>>
>> Would it be a good idea to give some focus to ceph-workbench[1] too
>> and formalise backport workflows, since we have a bigger Stable
>> Releases Team now?
>>
>> [1] https://pypi.python.org/pypi/ceph-workbench
>>
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>> Thanks
>> Abhishek
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
