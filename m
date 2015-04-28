From: Mark Nelson <mnelson@redhat.com>
Subject: newstore performance update
Date: Tue, 28 Apr 2015 18:25:22 -0500
Message-ID: <554016E2.3000104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33671 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030957AbbD1XZZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 19:25:25 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SNPPGA009676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 19:25:25 -0400
Received: from [10.3.112.75] (ovpn-112-75.phx2.redhat.com [10.3.112.75])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SNPNn8031484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 19:25:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Guys,

Sage has been furiously working away at fixing bugs in newstore and 
improving performance.  Specifically we've been focused on write 
performance as newstore was lagging filestore but quite a bit 
previously.  A lot of work has gone into implementing libaio behind the 
scenes and as a result performance on spinning disks with SSD WAL (and 
SSD backed rocksdb) has improved pretty dramatically. It's now often 
beating filestore:

http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf

On the other hand, sequential writes are slower than random writes when 
the OSD, DB, and WAL are all on the same device be it a spinning disk or 
SSD.  In this situation newstore does better with random writes and 
sometimes beats filestore (such as in the everything-on-spinning disk 
tests, and when IO sizes are small in the everything-on-ssd tests).

Newstore is changing daily so keep in mind that these results are almost 
assuredly going to change.  An interesting area of investigation will be 
why sequential writes are slower than random writes, and whether or not 
we are being limited by rocksdb ingest speed and how.

I've also uploaded a quick perf call-graph I grabbed during the 
"all-SSD" 32KB sequential write test to see if rocksdb was starving one 
of the cores, but found something that looks quite a bit different:

http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf

Mark
