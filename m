From: Samuel Just <sjust@redhat.com>
Subject: Re: Scrub and collection_list() order
Date: Thu, 8 Sep 2016 15:35:51 -0700
Message-ID: <CAN=+7FUHda36vOv9jHanjGrKzMGCx_p1CMoqUa7v2cDS-xa9Jg@mail.gmail.com>
References: <798293d3-e4fb-9814-b305-aa264f2968ac@redhat.com> <alpine.DEB.2.11.1609082202530.10416@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36544 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbcIHWfy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 18:35:54 -0400
Received: by mail-qt0-f179.google.com with SMTP id l91so14409483qte.3
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 15:35:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609082202530.10416@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: David Zafman <dzafman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hmm, that's annoying!  I don't think we really want to change the sort
ordering for this.  David: how about we just keep a vector of
un-processed clone metadata (whatever _scrub looks at) until we hit
head?  We can still deep scrub each clone in turn without the head, we
just have to keep the metadata around until we finally come upon the
head/snapdir.
-Sam

On Thu, Sep 8, 2016 at 3:05 PM, Sage Weil <sweil@redhat.com> wrote:
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
>
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
