From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 01:13:15 -0400 (EDT)
Message-ID: <1670246719.6192240.1439961195619.JavaMail.zimbra@redhat.com>
References: <55D409F0.3050802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:45940 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbbHSFNQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 01:13:16 -0400
In-Reply-To: <55D409F0.3050802@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thank you.
That's pretty interesting to me.

 Shinobu

----- Original Message -----
From: "Mark Nelson" <mnelson@redhat.com>
To: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Wednesday, August 19, 2015 1:45:36 PM
Subject: Ceph Hackathon: More Memory Allocator Testing

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
