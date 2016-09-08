From: David Zafman <dzafman@redhat.com>
Subject: Re: Scrub and collection_list() order
Date: Thu, 8 Sep 2016 15:47:38 -0700
Message-ID: <b6d40387-492c-cb10-1532-59b9b1528754@redhat.com>
References: <798293d3-e4fb-9814-b305-aa264f2968ac@redhat.com>
 <alpine.DEB.2.11.1609082202530.10416@piezo.us.to>
 <CAN=+7FUHda36vOv9jHanjGrKzMGCx_p1CMoqUa7v2cDS-xa9Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753815AbcIHWrk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 18:47:40 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 751E461E52
        for <ceph-devel@vger.kernel.org>; Thu,  8 Sep 2016 22:47:39 +0000 (UTC)
In-Reply-To: <CAN=+7FUHda36vOv9jHanjGrKzMGCx_p1CMoqUa7v2cDS-xa9Jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Sam,

     You know what.  Now that you mentioned that, I thought about the 
consistency of this checking.  If a new clone can appear between chunks 
where we've read the head object already and later come upon a new 
clone, this will produce a scrub error when there isn't one.

So we maybe need to find another way to improve performance because I 
claim that we need the head object and all clones as a single unit we 
retrieve from the replicas.

David

On 9/8/16 3:35 PM, Samuel Just wrote:
> Hmm, that's annoying!  I don't think we really want to change the sort
> ordering for this.  David: how about we just keep a vector of
> un-processed clone metadata (whatever _scrub looks at) until we hit
> head?  We can still deep scrub each clone in turn without the head, we
> just have to keep the metadata around until we finally come upon the
> head/snapdir.
> -Sam
>
> On Thu, Sep 8, 2016 at 3:05 PM, Sage Weil <sweil@redhat.com> wrote:
>> On Thu, 8 Sep 2016, David Zafman wrote:
>>> Sage,
>>>
>>> Does any code depend on collection_list returning snapshots BEFORE
>>> head/snapdir?  I'm trying to improve scrub's overhead per osd_scrub_chunk_max
>>> of objects, but scrub for to do the snapshot consistency analysis it needs the
>>> head objects first.  Can we add a collection_list() that returns the objects
>>> in completely reverse order?  Or can it be changed to return head/snapdir
>>> objects before the snapshots?  The current code has to ignore
>>> osd_scrub_chunk_max in order to find a natural boundary so that the scrub code
>>> can go in reverse order for that segment.
>> collection_list has to return objects in ghobject_t sort order, so it's
>> really bool operator<(const ghobject_t& l, const ghobject_t& r)'s fault
>> that snaps come first.  I don't think we can make it go backwards
>> efficiently given how rocksdb etc works.
>>
>> It might be possible to change the ghobject_t sort order, though, but I
>> suspect it'll require a clusterwide osdmap flag again, similar to the
>> sortbitwise thing we did earlier. Blech.
>>
>> How bad is the current workaround?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

