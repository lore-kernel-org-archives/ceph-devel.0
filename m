From: Sage Weil <sweil@redhat.com>
Subject: newstore and rocksdb column families
Date: Tue, 21 Apr 2015 13:55:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504211350460.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571AbbDUUzb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Apr 2015 16:55:31 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 9D0A78E3E5
	for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2015 20:55:31 +0000 (UTC)
Received: from redhat.com (ovpn-112-67.phx2.redhat.com [10.3.112.67])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3LKtUEx024581
	for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2015 16:55:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dhruba (rocksdb dev) asked if column families might be a good fit for 
controlling the WAL behavior.  I'm not certain it addresses specifically 
the WAL behavior, but it creates a bunch of opportunities for segregating 
the overlay and/or wal records out from the regular metadata (onodes, 
omap).  The short version is that each column family has it's own 
memtable and sstable files, but everything shares the same WAL, so you 
still get the atomicity.

I suspect this would be most helpful for the overlay records, where we'll 
have reasonably large key/value pairs with medium to long lifespans.  I'm 
not sure how helpful it will be with our wal records since if they make it 
out of the log at all we are already losing.  :/

Anyway, something to consider!

https://github.com/facebook/rocksdb/wiki/Column-Families

sage

