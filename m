From: David Zafman <dzafman@redhat.com>
Subject: Scrub and collection_list() order
Date: Thu, 8 Sep 2016 14:58:22 -0700
Message-ID: <798293d3-e4fb-9814-b305-aa264f2968ac@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934195AbcIHV6h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 17:58:37 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15E8983F43
        for <ceph-devel@vger.kernel.org>; Thu,  8 Sep 2016 21:58:24 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@redhat.com" <sage@redhat.com>
Cc: 'ceph-devel' <ceph-devel@vger.kernel.org>


Sage,

Does any code depend on collection_list returning snapshots BEFORE 
head/snapdir?  I'm trying to improve scrub's overhead per 
osd_scrub_chunk_max of objects, but scrub for to do the snapshot 
consistency analysis it needs the head objects first.  Can we add a 
collection_list() that returns the objects in completely reverse order?  
Or can it be changed to return head/snapdir objects before the 
snapshots?  The current code has to ignore osd_scrub_chunk_max in order 
to find a natural boundary so that the scrub code can go in reverse 
order for that segment.

David

