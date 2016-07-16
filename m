From: Mark Nelson <mnelson@redhat.com>
Subject: bluestore allocator performance testing
Date: Sat, 16 Jul 2016 09:28:23 -0500
Message-ID: <a42b6dd8-ea3e-a635-7af2-74f024f3ee1a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbcGPO20 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Jul 2016 10:28:26 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9079A63E0E
	for <ceph-devel@vger.kernel.org>; Sat, 16 Jul 2016 14:28:25 +0000 (UTC)
Received: from [10.3.112.5] (ovpn-112-5.phx2.redhat.com [10.3.112.5])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6GESNW1030114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Sat, 16 Jul 2016 10:28:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

Yesterday I ran through some quick tests looking at bluestore with 
stupid allocator and bitmap allocator, then compared with some existing 
jewel filestore benchmark results:

https://drive.google.com/file/d/0B2gTBZrkrnpZRWg2MTFhSk85b2M/view?usp=sharing

Both allocators resulted in similar read performance characteristics 
(not shown as I wanted to focus on writes).  For writes they were quite 
different.  Stupid allocator was faster than bitmap allocator for 
sequential writes, while bitmap allocator was faster than stupid 
allocator for most sizes of random writes.  Bluestore in general was 
faster than filestore for large writes (due to the avoidance of journal 
writes), but was slower to varying degrees at small IO sizes.  bitmap 
allocator appears to result in very good random write behavior down to 
~32K IO sizes, so small IO performance may improve as better locking 
behavior and Allen's encode/decode proposal are implemented.

I think it would probably be worth spending a bit of time to understand 
why the sequential write performance with bitmap allocator is so much 
slower than stupid allocator.

Mark
