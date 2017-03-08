From: Martin Bukatovic <mbukatov@redhat.com>
Subject: Fwd: tendrl stragegy for ceph cluster map hierarchy
Date: Wed, 8 Mar 2017 11:20:46 +0100
Message-ID: <85cfd1d7-d808-69a4-4258-44acf8ae1be9@redhat.com>
References: <bf3c1e56-5355-7b68-69ac-e2082089542b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbdCHKVl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Mar 2017 05:21:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB56FC04BD48
        for <ceph-devel@vger.kernel.org>; Wed,  8 Mar 2017 10:20:50 +0000 (UTC)
In-Reply-To: <bf3c1e56-5355-7b68-69ac-e2082089542b@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: tendrl-devel@redhat.com

Dear Ceph community,

I'm trying to understand how ceph cluster hierarchy feature relates
and affects Tendrl project (http://tendrl.org/), which tries to
provide web UI and API for ceph (and gluster) management.

The problem is that my understanding is based solely on reading
Sage's thesis, documentation and playing around with toy sized
clusters. So I would definitely appreciated someone with better
understanding of ceph to check my thinking here. I'm forwarding
my tendrl post below.

Btw: Tendrl project definitely welcomes you to show your
opinions about tendrl plans/ides on tendrl-devel list :)

-- 
Martin Bukatovic
USM QE team

-------- Forwarded Message --------
Subject: tendrl stragegy for ceph cluster map hierarchy
Date: Wed, 8 Mar 2017 11:08:23 +0100
From: Martin Bukatovic <mbukatov@redhat.com>
Organization: Red Hat
To: tendrl-devel@redhat.com

Dear Tendrl community,

I recently reviewed chapter 5 "Data Distribution" from Sage's Ceph
thesis[1],
(since I try to improve my understanding of Ceph in general) and noticed the
importance of "cluster map hierarchy" (aka CRUSH Map Bucket Hierarchy[2]).

In short, it's a tree structure in which:

* nodes are called "buckets"
* leaf nodes represent OSDs
* inner (non leaf) nodes has a "bucket type", which influences efficiency
  and performance of cluster operations on OSDs and data stored there

Design of this structure is important for performance, planned usage
patterns,
cluster expansion and failure domains (which means that poorly designed
hierarchy could result in data loss which could be prevented if proper
design had been used instead).

Eg. one could define bucket node for each rack, which would make possible to
define crash rules to make sure that at least one replica is placed in
different rack to prevent data loss when particular rack is down/lost.
Without
proper cluster hierarchy, it's not possible to achieve that.

If you are not familiar with the concept and are working or interested in
features dealing with cluster import or creation, I would suggest to
definitely
check either mentioned chapter from the thesis or ceph documentation.

So the big question here is *how is Tendrl planning to work with this
feature*?

We definitely can't ignore this now. Tendrl needs to have a clear
strategy here
from the beginning as this is something which can't be added or changed
later
easily.

Since this is core low level feature, there is no particular use case JIRA
for it. That said handling of cluster hierarchy is imho core part of the
following JIRAs:

* TEN-2 Install Ceph 2.x Cluster
* TEN-4 Import a Ceph 2.x Cluster
* TEN-164 UX: Create Ceph Cluster Design
* TEN-190 Create Ceph cluster via UI

My opinion is that we need to be able at least:

* import any valid/supported cluster cluster with it's hierarchy, without
  breaking ceph or tendrl
* communicate clearly with tendrl admin user how the cluster hierarchy
created
  during ceph cluster creation would look like
* make it possible for admin to define cluster hierarchy manually if he
decides
  that what tendrl provides doesn't fit his needs
* design the tendrl architecture/code so that it's possible to add
additional
  cluster map setup features, validation later without significant
refactoring
  of tendrl code

[1] http://ceph.com/papers/weil-thesis.pdf (link temp. broken at the moment)
[2]
http://docs.ceph.com/docs/master/rados/operations/crush-map/#crush-map-bucket-hierarchy
[TEN-2] https://tendrl.atlassian.net/browse/TEN-2

