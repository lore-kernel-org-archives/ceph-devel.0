From: Mark Nelson <mnelson@redhat.com>
Subject: Ceph Hackathon: More Memory Allocator Testing
Date: Tue, 18 Aug 2015 23:45:36 -0500
Message-ID: <55D409F0.3050802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38626 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbbHSEpi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Aug 2015 00:45:38 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id BFD058E740
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2015 04:45:38 +0000 (UTC)
Received: from [10.3.112.2] ([10.3.112.2])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t7J4jaAX004302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2015 00:45:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Everyone,

One of the goals at the Ceph Hackathon last week was to examine how to 
improve Ceph Small IO performance.  Jian Zhang presented findings 
showing a dramatic improvement in small random IO performance when Ceph 
is used with jemalloc.  His results build upon Sandisk's original 
findings that the default thread cache values are a major bottleneck in 
TCMalloc 2.1.  To further verify these results, we sat down at the 
Hackathon and configured the new performance test cluster that Intel 
generously donated to the Ceph community laboratory to run through a 
variety of tests with different memory allocator configurations.  I've 
since written the results of those tests up in pdf form for folks who 
are interested.

The results are located here:

http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing.pdf

I want to be clear that many other folks have done the heavy lifting 
here.  These results are simply a validation of the many tests that 
other folks have already done.  Many thanks to Sandisk and others for 
figuring this out as it's a pretty big deal!

Side note:  Very little tuning other than swapping the memory allocator 
and a couple of quick and dirty ceph tunables were set during these 
tests. It's quite possible that higher IOPS will be achieved as we 
really start digging into the cluster and learning what the bottlenecks are.

Thanks,
Mark
