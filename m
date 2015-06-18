From: Yuri Weinstein <yweinste@redhat.com>
Subject: firefly v0.80.10 QE validation completed
Date: Wed, 17 Jun 2015 21:33:27 -0400 (EDT)
Message-ID: <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:33752 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbFRBd2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 21:33:28 -0400
In-Reply-To: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>, Alfredo Deza <adeza@redhat.com>, Sage Weil <sweil@redhat.com>

firefly v0.80.10 is ready for publishing (Sage, Alfredo, Loic, Xinxin FYI)

All results details were summarized in http://tracker.ceph.com/issues/11090

Note:

- upgrade/dumpling-firefly-x (to hammer)(distros) - runs out of memory on vps and unreliable
- #11957 fixed (thanks Ilya, Zack!) and tested

Thx
YuriW

----- Original Message -----
From: "Yuri Weinstein" <yweinste@redhat.com>
To: "Ceph Development" <ceph-devel@vger.kernel.org>
Cc: "Loic Dachary" <ldachary@redhat.com>, "Xinxin Shu" <xinxin.shu@intel.com>
Sent: Monday, June 15, 2015 9:37:20 AM
Subject: firefly v0.80.10 QE validation status 6/15/2015

QE validation is almost completed (there are a couple of jobs that are still running)

All statis details were summarized in http://tracker.ceph.com/issues/11090

Highlights (by suite/issue):

rados #11914 needs Sam's approval
kcephfs n/a needs Greg's approval
samba #6613 needs Greg's approval

Nice to have fixes (no blockers):
upgrade/firefly(distros) #11957	(env noise)


Thx
YuriW
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
