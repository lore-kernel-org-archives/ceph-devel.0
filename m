From: Wido den Hollander <wido@42on.com>
Subject: Inactive PGs should trigger a HEALTH_ERR state
Date: Wed, 22 Jul 2015 12:11:11 +0200
Message-ID: <55AF6C3F.3060505@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:58626 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933154AbbGVKLO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jul 2015 06:11:14 -0400
Received: from [100.65.34.234] (unknown [193.173.216.124])
	by websrv.42on.com (Postfix) with ESMTPSA id C3C38D13FE
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2015 12:11:12 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I was just testing with a cluster on VMs and I noticed that
undersized+degraded+peering PGs do not trigger a HEALTH_ERR state. Why
is that?

In my opinion any PG which is not active+? should trigger a HEALTH_ERR
state since I/O is blocking at that point.

Is that a sane thing to do or am I missing something?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
