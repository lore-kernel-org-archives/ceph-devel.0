From: Samuel Just <sjust@redhat.com>
Subject: Re: firefly v0.80.10 QE validation status 6/15/2015
Date: Mon, 15 Jun 2015 13:19:57 -0400 (EDT)
Message-ID: <1311836717.22100787.1434388797252.JavaMail.zimbra@redhat.com>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:53280 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbbFORT7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 13:19:59 -0400
In-Reply-To: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>

I do not consider 11914 to be a blocker.
-Sam

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


