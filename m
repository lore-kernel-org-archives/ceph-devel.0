From: Loic Dachary <loic@dachary.org>
Subject: Re: (Un)Stable release team
Date: Sat, 5 Mar 2016 08:23:32 +0700
Message-ID: <56DA3514.6060706@dachary.org>
References: <56D001C6.5080804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46861 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759049AbcCEBXo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 20:23:44 -0500
In-Reply-To: <56D001C6.5080804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Here is a draft of the release process for development versions (http:/=
/pad.ceph.com/p/development-releases-draft) which I experimented with m=
anually. Comment and suggestions are welcome.

Cheers

On 26/02/2016 14:41, Loic Dachary wrote:
> Hi,
>=20
> It's a quiet time in the small world of the stable release team, idea=
l for mentoring the new members who generously answered our call for pa=
rticipation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, Mar=
tin Palma and Chris Jones :-)
>=20
> I propose that we take advantage of the next few weeks to expand our =
scope in two ways:=20
>=20
> * test Ceph development versions as well as stable versions
> * publish packages for Ceph development versions
>=20
> Testing Ceph development versions is actually less work than with sta=
ble versions because the developers run a lot of tests already and fix =
problems on a daily basis. Our help would likely be needed with a few t=
euthology suite runs right before the development release is published,=
 once a month. But the development versions tend to be more frequent, t=
herefore it will probably be as much work as for a stable release, over=
all. The workflow would be revisited: there is no cherry-picking. Inste=
ad, bug fixes must be against the jewel branch or whatever branch will =
be the upcoming stable. And this branch is merged back into master on a=
 regular basis (i.e. more frequently than the development releases).
>=20
> As you may have noticed, no packages were published for the 10.0.3 de=
velopment release and that's where we could make a real difference. Thi=
s would be an entirely new part of our workflow, but also an exciting o=
ne because it's the last missing piece of the puzzle. Once we are able =
to publish usable packages for development releases, nothing is stoppin=
g us to do the same for stable releases. It's a lot easier than it seem=
s since the packages are already built for the teuthology jobs. All we =
need is a public space to archive them and sign them. This is not mutua=
lly exclusive with the current package publication workflow, it would b=
e a community driven alternative that is much needed in some cases.
>=20
> Of course, this is easier said than done :-) What do you think ? Are =
there other important work that we should try to accomplish instead ? T=
hings that would benefit Ceph users and developers more ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
