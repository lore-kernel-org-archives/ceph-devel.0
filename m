From: Loic Dachary <loic@dachary.org>
Subject: (Un)Stable release team
Date: Fri, 26 Feb 2016 14:41:58 +0700
Message-ID: <56D001C6.5080804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41176 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcBZHmM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 02:42:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

It's a quiet time in the small world of the stable release team, ideal =
for mentoring the new members who generously answered our call for part=
icipation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, Marti=
n Palma and Chris Jones :-)

I propose that we take advantage of the next few weeks to expand our sc=
ope in two ways:=20

* test Ceph development versions as well as stable versions
* publish packages for Ceph development versions

Testing Ceph development versions is actually less work than with stabl=
e versions because the developers run a lot of tests already and fix pr=
oblems on a daily basis. Our help would likely be needed with a few teu=
thology suite runs right before the development release is published, o=
nce a month. But the development versions tend to be more frequent, the=
refore it will probably be as much work as for a stable release, overal=
l. The workflow would be revisited: there is no cherry-picking. Instead=
, bug fixes must be against the jewel branch or whatever branch will be=
 the upcoming stable. And this branch is merged back into master on a r=
egular basis (i.e. more frequently than the development releases).

As you may have noticed, no packages were published for the 10.0.3 deve=
lopment release and that's where we could make a real difference. This =
would be an entirely new part of our workflow, but also an exciting one=
 because it's the last missing piece of the puzzle. Once we are able to=
 publish usable packages for development releases, nothing is stopping =
us to do the same for stable releases. It's a lot easier than it seems =
since the packages are already built for the teuthology jobs. All we ne=
ed is a public space to archive them and sign them. This is not mutuall=
y exclusive with the current package publication workflow, it would be =
a community driven alternative that is much needed in some cases.

Of course, this is easier said than done :-) What do you think ? Are th=
ere other important work that we should try to accomplish instead ? Thi=
ngs that would benefit Ceph users and developers more ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
