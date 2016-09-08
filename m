From: David Zafman <dzafman@redhat.com>
Subject: Re: Scrub and collection_list() order
Date: Thu, 8 Sep 2016 15:41:37 -0700
Message-ID: <ffdb5eab-e8f6-90e0-0d31-a9622f9aa9b3@redhat.com>
References: <798293d3-e4fb-9814-b305-aa264f2968ac@redhat.com>
 <alpine.DEB.2.11.1609082202530.10416@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbcIHWli (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 18:41:38 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DE574E4E7
        for <ceph-devel@vger.kernel.org>; Thu,  8 Sep 2016 22:41:38 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1609082202530.10416@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: 'ceph-devel' <ceph-devel@vger.kernel.org>


Sage,


     The current workaround is bad because if an object has many clones 
we have to ignore the osd_scrub_chunk_max and find a chunk that includes 
the head object for those clones.  Then the analysis code processes that 
chunk in reverse order.  We think that this behavior is the long 
standing cause of performance issues during deep scrub in RBD 
environments with lots of clones.    An object with N clones will chunk 
at least the N+1 objects no matter what the value of osd_scrub_chunk_max.

   I have the analysis code modified to handle smaller arbitrary chunks 
(state is saved between chunks) but that can only work if the objects 
arrive in reverse order since it still requires the head objects first.

David


On 9/8/16 3:05 PM, Sage Weil wrote:
> On Thu, 8 Sep 2016, David Zafman wrote:
>> Sage,
>>
>> Does any code depend on collection_list returning snapshots BEFORE
>> head/snapdir?  I'm trying to improve scrub's overhead per osd_scrub_chunk_max
>> of objects, but scrub for to do the snapshot consistency analysis it needs the
>> head objects first.  Can we add a collection_list() that returns the objects
>> in completely reverse order?  Or can it be changed to return head/snapdir
>> objects before the snapshots?  The current code has to ignore
>> osd_scrub_chunk_max in order to find a natural boundary so that the scrub code
>> can go in reverse order for that segment.
> collection_list has to return objects in ghobject_t sort order, so it's
> really bool operator<(const ghobject_t& l, const ghobject_t& r)'s fault
> that snaps come first.  I don't think we can make it go backwards
> efficiently given how rocksdb etc works.
>
> It might be possible to change the ghobject_t sort order, though, but I
> suspect it'll require a clusterwide osdmap flag again, similar to the
> sortbitwise thing we did earlier. Blech.
>
> How bad is the current workaround?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

