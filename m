From: John Spray <john.spray@redhat.com>
Subject: Persistence of completed_requests in sessionmap (do we need it?)
Date: Tue, 03 Mar 2015 21:39:30 +0000
Message-ID: <54F62A12.8010104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092AbbCCVjd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Mar 2015 16:39:33 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t23LdWWI031476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 3 Mar 2015 16:39:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, zyan@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Zheng noticed on my new sessionmap code [1] that sessions weren't 
getting dirtied on trim_completed_requests.  I had missed that, because 
I was only updating the places that we already incremented the 
sessionmap version while modifying something.

I went and looked at how this worked in the existing code, and it 
appears that we don't actually bother persisting updates to the 
sessionmap if completed_requests is the only thing that changed.  We 
would *tend* to persist it as a consequence to other session updates 
like prealloc_inos, but if one is simply issuing lots of metadata 
updates to existing files in a loop, the sessionmap never gets written 
back (even when expiring log segments).

During replay, we rebuild completed_requests from EMetaBlob::replay, and 
we've made it this far without reliably persisting it in sessionmap, so 
I wonder if we ever needed to save this at all? Thoughts?

Cheers,
John

1. https://github.com/ceph/ceph/pull/3718
