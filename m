From: John Spray <john.spray@redhat.com>
Subject: Negative stats on lab cluster
Date: Tue, 24 Feb 2015 11:41:01 +0000
Message-ID: <54EC634D.9050104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35303 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbBXLlD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Feb 2015 06:41:03 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1OBf3Lg021002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 06:41:03 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org


The lab cluster hosting teuthology logs is currently exhibiting negative 
statistics (#5884, #7737).  Could be a good time for someone with more 
low-level RADOS expertise than me to take a look at the status and see 
if they can work out why it's happening.

Cheers,
John
