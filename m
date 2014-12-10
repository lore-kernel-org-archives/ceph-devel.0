From: Ken Dreyer <kdreyer@redhat.com>
Subject: force pushes disabled for master in ceph.git and ceph-deploy.git
Date: Wed, 10 Dec 2014 15:20:55 -0700
Message-ID: <5488C747.2000003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44218 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbaLJWU4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Dec 2014 17:20:56 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBAMKuas029276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 10 Dec 2014 17:20:56 -0500
Received: from mbp.ktdreyer.com (vpn-59-132.rdu2.redhat.com [10.10.59.132])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sBAMKteA014001
	for <ceph-devel@vger.kernel.org>; Wed, 10 Dec 2014 17:20:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thanks to GitHub Support, force-pushes are now disabled for master in
ceph.git and ceph-deploy.git. This should save us from accidentally
deleting history with a bad force-push to the wrong branch. (Not that
any of us were going to do that, of course! :)

- Ken
