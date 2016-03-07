From: Loic Dachary <loic@dachary.org>
Subject: Re: (Un)Stable release team
Date: Mon, 7 Mar 2016 20:15:37 +0700
Message-ID: <56DD7EF9.1060301@dachary.org>
References: <56D001C6.5080804@dachary.org> <56DA3514.6060706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51781 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbcCGNPr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 08:15:47 -0500
In-Reply-To: <56DA3514.6060706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Martin,

Your GPG snippet was integrated in http://ceph-workbench.dachary.org/da=
chary/ceph-workbench/blob/wip-release/ceph_workbench/release.py#L58 and=
 I added a
Copyright line at the top of the file http://ceph-workbench.dachary.org=
/dachary/ceph-workbench/blob/wip-release/ceph_workbench/release.py#L4 .=
 Is it right ?

Cheers

On 05/03/2016 08:23, Loic Dachary wrote:
> Hi,
>=20
> Here is a draft of the release process for development versions (http=
://pad.ceph.com/p/development-releases-draft) which I experimented with=
 manually. Comment and suggestions are welcome.
>=20
> Cheers
>=20
> On 26/02/2016 14:41, Loic Dachary wrote:
>> Hi,
>>
>> It's a quiet time in the small world of the stable release team, ide=
al for mentoring the new members who generously answered our call for p=
articipation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, Ma=
rtin Palma and Chris Jones :-)
>>
>> I propose that we take advantage of the next few weeks to expand our=
 scope in two ways:=20
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
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
