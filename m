From: Loic Dachary <loic@dachary.org>
Subject: Re: (Un)Stable release team
Date: Fri, 26 Feb 2016 17:11:46 +0700
Message-ID: <56D024E2.1040300@dachary.org>
References: <56D001C6.5080804@dachary.org>
 <CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59174 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcBZKMA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 05:12:00 -0500
In-Reply-To: <CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>



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

Yes, we need that. Today Wei-Chung Cheng installed it and stumbled on t=
wo minor issues that need fixing. Which part of the workflow seems most=
 important to automate right now ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
