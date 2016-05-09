From: Josh Durgin <jdurgin@redhat.com>
Subject: teuthology multi-cluster support
Date: Mon, 9 May 2016 15:31:08 -0700
Message-ID: <57310FAC.2070507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbcEIWbK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2016 18:31:10 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 328F8C049D4F
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2016 22:31:09 +0000 (UTC)
Received: from [10.17.97.32] (dhcp-10-17-97-32.lax.redhat.com [10.17.97.32])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u49MV8hs023549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 9 May 2016 18:31:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey folks, I just wanted to give a heads up that two large changes just
merged to teuthology and ceph-qa-suite to support testing multiple ceph
clusters (or just clusters with a non-default name). If you notice
anything failing due to this, let me know!

More details here:

https://github.com/ceph/teuthology/pull/841
https://github.com/ceph/ceph-qa-suite/pull/937
