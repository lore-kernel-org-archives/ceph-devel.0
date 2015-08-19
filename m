From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 08:33:27 +0200
Message-ID: <55D42337.5080205@profihost.ag>
References: <55D409F0.3050802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:51993 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbHSGd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 02:33:29 -0400
In-Reply-To: <55D409F0.3050802@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


Thanks for sharing. Do those tests use jemalloc for fio too? Otherwise
librbd on client side is running with tcmalloc again.

Stefan

Am 19.08.2015 um 06:45 schrieb Mark Nelson:
> Hi Everyone,
> 
> One of the goals at the Ceph Hackathon last week was to examine how to
> improve Ceph Small IO performance.  Jian Zhang presented findings
> showing a dramatic improvement in small random IO performance when Ceph
> is used with jemalloc.  His results build upon Sandisk's original
> findings that the default thread cache values are a major bottleneck in
> TCMalloc 2.1.  To further verify these results, we sat down at the
> Hackathon and configured the new performance test cluster that Intel
> generously donated to the Ceph community laboratory to run through a
> variety of tests with different memory allocator configurations.  I've
> since written the results of those tests up in pdf form for folks who
> are interested.
> 
> The results are located here:
> 
> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing.pdf
> 
> I want to be clear that many other folks have done the heavy lifting
> here.  These results are simply a validation of the many tests that
> other folks have already done.  Many thanks to Sandisk and others for
> figuring this out as it's a pretty big deal!
> 
> Side note:  Very little tuning other than swapping the memory allocator
> and a couple of quick and dirty ceph tunables were set during these
> tests. It's quite possible that higher IOPS will be achieved as we
> really start digging into the cluster and learning what the bottlenecks
> are.
> 
> Thanks,
> Mark
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
