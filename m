From: Loic Dachary <loic@dachary.org>
Subject: Re: (Un)Stable release team
Date: Mon, 29 Feb 2016 14:53:55 +0700
Message-ID: <56D3F913.8020008@dachary.org>
References: <56D001C6.5080804@dachary.org>
 <CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39586 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcB2HyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 02:54:08 -0500
In-Reply-To: <CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

This week-end I updated http://ceph-workbench.dachary.org/root/ceph-wor=
kbench and got the integration tests to pass again (a few minor issues =
broke it in the past two months http://ceph-workbench.dachary.org/root/=
ceph-workbench/activity). I suppose the most important item in the back=
log is to have a convenient way to record the teuthology runs and assoc=
iate them with known issues. I updated http://ceph-workbench.dachary.or=
g/root/ceph-workbench/issues/26 with a short description of what it wou=
ld look like if we used the redmine wiki for that purpose. But it feels=
 fragile and redundant with paddles (the database that records the test=
s).=20

I think we have three options to automate the use case we want (i.e. wh=
at we've been doing at http://tracker.ceph.com/issues/14692 & al).

* Automate the redmine update using issue comments & wiki pages (http:/=
/ceph-workbench.dachary.org/root/ceph-workbench/issues/26).
* Create a git-notes database with links to issues / pr / test results =
(http://ceph-workbench.dachary.org/root/ceph-workbench/issues/5)
* Improve paddles / pulpito

We've discussed the first two options extensively over the past year bu=
t not so much the idea of improving paddles / pulpito. Maybe because pu=
lpito is too much web and not enough plain text for my taste, at least =
that's one of the things that comes to mind. But this can probably be i=
mproved as well. It could go=20
like this:

* Add an "issue" and "comment" field in paddles for each test.
* Add a query to show all jobs that ran against a given SHA1 to paddles=
 (that's the focus we have in the stable release issues)
* Add a query to show all run of a given job (based on the description)=
 to paddles
* Add a redmine friendly text output to pulpito so that it can be copy/=
pasted to a comment (instead of doing what we do with the fail.py scrip=
t and maybe more)
* Add the input fields in pulpito to fill the "issue" field and the "co=
mment" field to the pulpito UI (which is what we do when analyzing fail=
ures).

What do you think ?

Cheers

On 26/02/2016 15:12, Abhishek Varshney wrote:
> Hi Loic,
>=20
> On Fri, Feb 26, 2016 at 1:11 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi,
>>
>> It's a quiet time in the small world of the stable release team, ide=
al for mentoring the new members who generously answered our call for p=
articipation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, Ma=
rtin Palma and Chris Jones :-)
>>
>> I propose that we take advantage of the next few weeks to expand our=
 scope in two ways:
>>
>> * test Ceph development versions as well as stable versions
>> * publish packages for Ceph development versions
>>
>> Testing Ceph development versions is actually less work than with st=
able versions because the developers run a lot of tests already and fix=
 problems on a daily basis. Our help would likely be needed with a few =
teuthology suite runs right before the development release is published=
, once a month. But the development versions tend to be more frequent, =
therefore it will probably be as much work as for a stable release, ove=
rall. The workflow would be revisited: there is no cherry-picking. Inst=
ead, bug fixes must be against the jewel branch or whatever branch will=
 be the upcoming stable. And this branch is merged back into master on =
a regular basis (i.e. more frequently than the development releases).
>>
>> As you may have noticed, no packages were published for the 10.0.3 d=
evelopment release and that's where we could make a real difference. Th=
is would be an entirely new part of our workflow, but also an exciting =
one because it's the last missing piece of the puzzle. Once we are able=
 to publish usable packages for development releases, nothing is stoppi=
ng us to do the same for stable releases. It's a lot easier than it see=
ms since the packages are already built for the teuthology jobs. All we=
 need is a public space to archive them and sign them. This is not mutu=
ally exclusive with the current package publication workflow, it would =
be a community driven alternative that is much needed in some cases.
>>
>> Of course, this is easier said than done :-) What do you think ? Are=
 there other important work that we should try to accomplish instead ? =
Things that would benefit Ceph users and developers more ?
>=20
> Would it be a good idea to give some focus to ceph-workbench[1] too
> and formalise backport workflows, since we have a bigger Stable
> Releases Team now?
>=20
> [1] https://pypi.python.org/pypi/ceph-workbench
>=20
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> Thanks
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
