From: Sage Weil <sweil@redhat.com>
Subject: standup
Date: Wed, 8 Jun 2016 09:15:53 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606080911350.23732@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201AbcFHNP2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Jun 2016 09:15:28 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5295085543
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jun 2016 13:15:27 +0000 (UTC)
Received: from cpach (ovpn-112-33.phx2.redhat.com [10.3.112.33])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u58DFOUx017019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 8 Jun 2016 09:15:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'll miss the bluestore and core (and other) standups today.

Bluestore update:
- the csum pr is blocked behind wip-ctz, which is blocked behind lab 
infrastructure issues
- working on wip-bluestore-blobcache, which restructures our caching to be 
blob-based instead of object based.  This is a bit of a tradeoff and 
deserves some discussion.  On the one hand, doing it this way means that 
we preserve cache content across clone, which is nice.  On the other hand, 
it means that it is harder to invalidate cache content when it is obscured 
by another write.  I think that part is solveable, but it'll be a bit 
tricky.  A similar situation arises with pulling blobs that are partially 
obscured into cache.

	https://github.com/ceph/ceph/pull/9567

s
