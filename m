From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: ceph performance call:  buffer
Date: Thu, 16 Oct 2014 14:00:32 -0400 (EDT)
Message-ID: <1071486299.106.1413482432334.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4737 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaJPSAj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Oct 2014 14:00:39 -0400
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id s9GI0YT0000606
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 14:00:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id C46603FC849D
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 14:00:34 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Casey Bodley <casey@cohortfs.com>

Hi Folks,

Per yesterday's Ceph performance call, we've pushed 2 wip branches for review and feedback to https://github.com/linuxbox2/linuxbox-ceph.git .

1. xio-v084-inline reorganizes ceph::buffer as a namespace, and (nearly) all of
buffer::hash, buffer::ptr and buffer::list as inline

2. xio-v084-inline-flat restores some raw encapsulation lost in the prior change,
then refactors buffer::raw to remove virtual methods

We've made some effort to measure the impact of the changes, but don't have
reliable data yet.  (It's possible that our initial impression of improvement from the inlining change was not accurate, but more likely we need better workload tests.)

In addition, we've been working on an experiment to refactor buffer::ptr and buffer::raw to use boost::intrusive::list, to unify the interfaces of the two types to permit interning buffer::raw directly on the containing list when there is no sharing, and a slab allocator for both types.  We plan to push a wip branch with these changes to when they've stabilized a bit more and/or we have real perf numbers.

Thanks,

Matt

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
