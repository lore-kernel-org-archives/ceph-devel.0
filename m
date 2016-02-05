From: Loic Dachary <loic@dachary.org>
Subject: upgrade/infernalis 26 jobs vs 10 jobs
Date: Fri, 5 Feb 2016 14:15:31 +0700
Message-ID: <56B44C13.9080708@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36807 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcBEHPm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 02:15:42 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Yuri,

When running teuthology-suite --verbose --suite upgrade/infernalis --su=
ite-branch infernalis --ceph infernalis --machine-type vps --priority 1=
000 --dry-run it shows 10 jobs:

2016-02-05 14:13:26,673.673 INFO:teuthology.suite:Suite upgrade:inferna=
lis in /home/loic/src/ceph-qa-suite_infernalis/suites/upgrade/infernali=
s scheduled 10 jobs.

however, looking at http://pulpito.ceph.com/?branch=3Dinfernalis&suite=3D=
upgrade%3Ainfernalis shows each run has 26 jobs. Would you be so kind a=
s to let me know the command line you're using to get that result ?

Thanks in advance :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
