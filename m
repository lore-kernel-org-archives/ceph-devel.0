From: Loic Dachary <loic@dachary.org>
Subject: fixing inconsistent merge messages & release notes
Date: Wed, 10 Feb 2016 16:16:09 +0700
Message-ID: <56BAFFD9.6050108@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34964 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcBJJQU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 04:16:20 -0500
Received: from mfilter43-d.gandi.net (mfilter43-d.gandi.net [217.70.178.174])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 05D7141C0CE
	for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 10:16:19 +0100 (CET)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter43-d.gandi.net (mfilter43-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Y4kUQHobsESQ for <ceph-devel@vger.kernel.org>;
	Wed, 10 Feb 2016 10:16:16 +0100 (CET)
Received: from [10.7.10.93] (node-ar0.pool-118-172.dynamic.totbb.net [118.172.54.108])
	(Authenticated sender: loic@dachary.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3C0EF41C104
	for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 10:16:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

TL;DR: Fix the PR title via the GitHub web interface, not in the merge =
message.=20
       Use the merge message to write a user readable paragraph that wi=
ll show in the release notes.

A few month ago it was proposed that merge messages are improved to hel=
p write better release notes, but that did not quite succeed. Yet :-)

When using the GitHub web interface, the default merge message looks li=
ke that:

    Merge pull request #7037 from mathslinux/rgw-add-missing-error-code
    rgw: add missing error code for admin op API
    Reviewed-by: Yehuda Sadeh <yehuda@redhat.com>

Where the first two lines (Merge and rgw: ...) are automatically genera=
ted by GitHub using the title of the pull request. And the Reviewed-By:=
 is added manually by the reviewer.

If the title of the pull request needs fixing, it can also be done via =
the GitHub web interface and it will reflect in the merge message templ=
ate. It is convenient because the title of the pull request exactly mat=
ches the title found in the merge message. Fixing the title in the merg=
e message leaves us with an unnecessary inconsistency between the merge=
 message and the title of the pull request. I manually fixed a few doze=
ns of such inconsistencies by copying the merge message back to the pul=
l request title for the 10.0.3 release.

The script used to list the notable changes for the release notes[1] wi=
ll assume merge messages that are not the default (see above) are writt=
en for inclusion in the release notes. For instance https://github.com/=
ceph/ceph/pull/6926 title is ceph-disk: fix failures when preparing dis=
ks with udev > 214 and the merge message is:

    Merge pull request #6926 from dachary/wip-14080-ceph-disk-udevadm
    ceph-disk: fix failures when preparing disks with udev > 214

    On CentOS 7.1 and other operating systems with a version of udev gr=
eater or equal to 214,=20
    running ceph-disk prepare triggered unexpected removal and addition=
 of partitions on
    the disk being prepared. That created problems ranging from the OSD=
 not being activated
    to failures because /dev/sdb1 does not exist although it should.

    Reviewed-by: Sage Weil <sage@redhat.com>

The two examples above will show as follows in the release notes:

* rgw: add missing error code for admin op API (`pr#7037 <http://github=
=2Ecom/ceph/ceph/pull/7037>`_, Dunrong Huang)
* ceph-disk: fix failures when preparing disks with udev > 214 (`issue#=
14080 <http://tracker.ceph.com/issues/14080>`_, `issue#14094 <http://tr=
acker.ceph.com/issues/14094>`_, `pr#6926 <http://github.com/ceph/ceph/p=
ull/6926>`_, Loic Dachary, Ilya Dryomov)
    On CentOS 7.1 and other operating systems with a version of udev gr=
eater or equal to 214,
    running ceph-disk prepare triggered unexpected removal and addition=
 of partitions on
    the disk being prepared. That created problems ranging from the OSD=
 not being activated
    to failures because /dev/sdb1 does not exist although it should.


Cheers

[1] https://github.com/ceph/ceph/blob/master/src/script/ceph-release-no=
tes
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
