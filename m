From: Sage Weil <sweil@redhat.com>
Subject: rocksdb wal proposed improvement
Date: Fri, 4 Nov 2016 16:06:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611041605190.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932299AbcKDQGM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 12:06:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: somnath.roy@sandisk.com
Cc: ceph-devel@vger.kernel.org, g.marripudi@samsung.com

Here's a quick write-up of what I think we should improve in rocksdb:

	http://pad.ceph.com/p/rocksdb-wal-improvement

sage
