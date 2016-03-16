From: Loic Dachary <loic@dachary.org>
Subject: Re: Publishing development releases
Date: Wed, 16 Mar 2016 08:30:55 +0100
Message-ID: <56E90BAF.8040008@dachary.org>
References: <56E7D22E.2060701@dachary.org> <56E87134.6060206@suse.cz>
 <CAHDn051vzYxzqVUT=4KQc0FBwZK4C-XEBCRsw4+BihCTkvGORQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41360 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbcCPHbG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 03:31:06 -0400
In-Reply-To: <CAHDn051vzYxzqVUT=4KQc0FBwZK4C-XEBCRsw4+BihCTkvGORQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei-Chung Cheng <freeze.bilsted@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Martin Palma <martin@palma.bz>, "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Gaurav Bafna <bafnag@gmail.com>, Rajat Garg <rajatgarg.iitr@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 16/03/2016 03:44, Wei-Chung Cheng wrote:
> Hi loic:
>=20
> agree!
> I think that is a good idea and would be helpful for our formal relea=
se.
> Also glad to accept the extra workload.
>=20
> btw, I could not see the `http://pad.ceph.com/p/development-releases`=
 content.
> would I need to do something?

http://pad.ceph.com/p/development-releases

(there is an extra ` at the end that leads to a different document ;-)

>=20
> thanks!!
> vicente
>=20
>=20
> 2016-03-16 4:31 GMT+08:00 Nathan Cutler <ncutler@suse.cz <mailto:ncut=
ler@suse.cz>>:
>=20
>     Hi Loic:
>=20
>     I, too, think this is a good idea and am willing to accept the ex=
tra workload.
>=20
>     Nathan
>=20
>=20
>     On 03/15/2016 10:13 AM, Loic Dachary wrote:
>=20
>         Hi Abhishek V, Abhishek L, Swami, Nathan, Gaurav, Rajat, Mart=
in, Xiaoxi, Vicente,
>=20
>         A few weeks ago, 10.0.3 was tagged for release, but packages =
were not published and these packages were missed by the Ceph user base=
=2E We, the members of the Stable Releases team, got to thinking how we=
 could help.
>=20
>         This led to an idea that was discussed on the mailing list[1]=
 and during CDM[2]. Since we were already building packages as a side e=
ffect of running teuthology suites on OpenStack, this could be extended=
 into a full-fledged release process that would:
>=20
>         1. ensure that the community's demand for development release=
s is met
>         2. complement, not replace, the existing package publication =
workflow
>         3. be automated.
>=20
>         So I added a "release" subcommand to the ceph-workbench[3] to=
ol we are already using to automate various backporting tasks. The new =
subcommand is included in the latest ceph-workbench release, and works =
like this:
>=20
>                       ceph-workbench release --suite buildpackages/an=
y \
>                                   --ceph jewel \
>                                   --version 10.0.5 \
>                                   --filter ubuntu_14.04,centos_7.2
>=20
>         When it completes the packages can be uploaded to a permanent=
 mirror similar to downloads.ceph.com <http://downloads.ceph.com>.
>=20
>         I believe we can commit to publish Ceph development releases =
with this process. The "release" subcommand is relatively small (around=
 300 lines of code) and there are integration tests to help with its ma=
intenance. There are enough of us to rotate the release duties so that =
it does not become too much of a burden for anyone.
>=20
>         Since it's a decision that changes our focus and our workload=
, are you OK with adding this activity to the scope of our team?
>=20
>         Cheers
>=20
>         [1] (Un)Stable release team http://www.spinics.net/lists/ceph=
-devel/msg28887.html
>         [2] publishing development and unsupported releases http://tr=
acker.ceph.com/projects/ceph/wiki/CDM_02-MAR-2016
>         [3] ceph-workbench release merge request http://ceph-workbenc=
h.dachary.org/root/ceph-workbench/merge_requests/43/diffs#9f3ebf1fc3850=
6b66593397f3baac514d515c496_231_232
>=20
>=20
>=20
>     --=20
>     Nathan Cutler
>     Software Engineer Distributed Storage
>     SUSE LINUX, s.r.o.
>     Tel.: +420 284 084 037 <tel:%2B420%20284%20084%20037>
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
