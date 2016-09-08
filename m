From: Sage Weil <sweil@redhat.com>
Subject: Re: Scrub and collection_list() order
Date: Thu, 8 Sep 2016 22:05:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609082202530.10416@piezo.us.to>
References: <798293d3-e4fb-9814-b305-aa264f2968ac@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932233AbcIHWFL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 18:05:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DE67800AF
        for <ceph-devel@vger.kernel.org>; Thu,  8 Sep 2016 22:05:11 +0000 (UTC)
In-Reply-To: <798293d3-e4fb-9814-b305-aa264f2968ac@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: 'ceph-devel' <ceph-devel@vger.kernel.org>

On Thu, 8 Sep 2016, David Zafman wrote:
> Sage,
> 
> Does any code depend on collection_list returning snapshots BEFORE
> head/snapdir?  I'm trying to improve scrub's overhead per osd_scrub_chunk_max
> of objects, but scrub for to do the snapshot consistency analysis it needs the
> head objects first.  Can we add a collection_list() that returns the objects
> in completely reverse order?  Or can it be changed to return head/snapdir
> objects before the snapshots?  The current code has to ignore
> osd_scrub_chunk_max in order to find a natural boundary so that the scrub code
> can go in reverse order for that segment.

collection_list has to return objects in ghobject_t sort order, so it's 
really bool operator<(const ghobject_t& l, const ghobject_t& r)'s fault 
that snaps come first.  I don't think we can make it go backwards 
efficiently given how rocksdb etc works.

It might be possible to change the ghobject_t sort order, though, but I 
suspect it'll require a clusterwide osdmap flag again, similar to the 
sortbitwise thing we did earlier. Blech.

How bad is the current workaround?

sage
