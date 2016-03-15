From: Loic Dachary <loic@dachary.org>
Subject: Publishing development releases
Date: Tue, 15 Mar 2016 10:13:18 +0100
Message-ID: <56E7D22E.2060701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54219 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964881AbcCOJN3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2016 05:13:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>, Martin Palma <martin@palma.bz>, "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Vicente Cheng <freeze.bilsted@gmail.com>, Gaurav Bafna <bafnag@gmail.com>, Rajat Garg <rajatgarg.iitr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Abhishek V, Abhishek L, Swami, Nathan, Gaurav, Rajat, Martin, Xiaoxi=
, Vicente,

A few weeks ago, 10.0.3 was tagged for release, but packages were not p=
ublished and these packages were missed by the Ceph user base. We, the =
members of the Stable Releases team, got to thinking how we could help.

This led to an idea that was discussed on the mailing list[1] and durin=
g CDM[2]. Since we were already building packages as a side effect of r=
unning teuthology suites on OpenStack, this could be extended into a fu=
ll-fledged release process that would:

1. ensure that the community's demand for development releases is met
2. complement, not replace, the existing package publication workflow
3. be automated.

So I added a "release" subcommand to the ceph-workbench[3] tool we are =
already using to automate various backporting tasks. The new subcommand=
 is included in the latest ceph-workbench release, and works like this:

             ceph-workbench release --suite buildpackages/any \
                         --ceph jewel \
                         --version 10.0.5 \
                         --filter ubuntu_14.04,centos_7.2

When it completes the packages can be uploaded to a permanent mirror si=
milar to downloads.ceph.com.

I believe we can commit to publish Ceph development releases with this =
process. The "release" subcommand is relatively small (around 300 lines=
 of code) and there are integration tests to help with its maintenance.=
 There are enough of us to rotate the release duties so that it does no=
t become too much of a burden for anyone.

Since it's a decision that changes our focus and our workload, are you =
OK with adding this activity to the scope of our team?

Cheers

[1] (Un)Stable release team http://www.spinics.net/lists/ceph-devel/msg=
28887.html
[2] publishing development and unsupported releases http://tracker.ceph=
=2Ecom/projects/ceph/wiki/CDM_02-MAR-2016
[3] ceph-workbench release merge request http://ceph-workbench.dachary.=
org/root/ceph-workbench/merge_requests/43/diffs#9f3ebf1fc38506b66593397=
f3baac514d515c496_231_232

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
