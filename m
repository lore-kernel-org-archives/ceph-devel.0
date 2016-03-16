From: Loic Dachary <loic@dachary.org>
Subject: Re: Publishing development releases
Date: Wed, 16 Mar 2016 14:20:52 +0100
Message-ID: <56E95DB4.20006@dachary.org>
References: <56E7D22E.2060701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38564 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965993AbcCPNU6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 09:20:58 -0400
In-Reply-To: <56E7D22E.2060701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>, Martin Palma <martin@palma.bz>, "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Vicente Cheng <freeze.bilsted@gmail.com>, Gaurav Bafna <bafnag@gmail.com>, Rajat Garg <rajatgarg.iitr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

It looks like we have a majority in favor, let's do it :-)

I took the first round with the publication of 10.0.5. Our rotation sch=
edule was updated to add 10.1.0 (the next development release) http://t=
racker.ceph.com/projects/ceph-releases/wiki/HOWTO#Whos-who and I set my=
self as a backup. If someone is willing to learn how to publish a dev r=
elease, I'll be happy to explain. It is now documented at http://tracke=
r.ceph.com/projects/ceph-releases/wiki/HOWTO_publish_a_release. There i=
s no doubt things are missing but they can be fixed / documented as we =
make progress.

Cheers

On 15/03/2016 10:13, Loic Dachary wrote:
> Hi Abhishek V, Abhishek L, Swami, Nathan, Gaurav, Rajat, Martin, Xiao=
xi, Vicente,
>=20
> A few weeks ago, 10.0.3 was tagged for release, but packages were not=
 published and these packages were missed by the Ceph user base. We, th=
e members of the Stable Releases team, got to thinking how we could hel=
p.
>=20
> This led to an idea that was discussed on the mailing list[1] and dur=
ing CDM[2]. Since we were already building packages as a side effect of=
 running teuthology suites on OpenStack, this could be extended into a =
full-fledged release process that would:
>=20
> 1. ensure that the community's demand for development releases is met
> 2. complement, not replace, the existing package publication workflow
> 3. be automated.
>=20
> So I added a "release" subcommand to the ceph-workbench[3] tool we ar=
e already using to automate various backporting tasks. The new subcomma=
nd is included in the latest ceph-workbench release, and works like thi=
s:
>=20
>              ceph-workbench release --suite buildpackages/any \
>                          --ceph jewel \
>                          --version 10.0.5 \
>                          --filter ubuntu_14.04,centos_7.2
>=20
> When it completes the packages can be uploaded to a permanent mirror =
similar to downloads.ceph.com.
>=20
> I believe we can commit to publish Ceph development releases with thi=
s process. The "release" subcommand is relatively small (around 300 lin=
es of code) and there are integration tests to help with its maintenanc=
e. There are enough of us to rotate the release duties so that it does =
not become too much of a burden for anyone.
>=20
> Since it's a decision that changes our focus and our workload, are yo=
u OK with adding this activity to the scope of our team?
>=20
> Cheers
>=20
> [1] (Un)Stable release team http://www.spinics.net/lists/ceph-devel/m=
sg28887.html
> [2] publishing development and unsupported releases http://tracker.ce=
ph.com/projects/ceph/wiki/CDM_02-MAR-2016
> [3] ceph-workbench release merge request http://ceph-workbench.dachar=
y.org/root/ceph-workbench/merge_requests/43/diffs#9f3ebf1fc38506b665933=
97f3baac514d515c496_231_232

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
