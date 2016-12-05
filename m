From: Sage Weil <sweil@redhat.com>
Subject: Re: raw rados listing with seek to marker
Date: Mon, 5 Dec 2016 14:40:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612051440090.2711@piezo.novalocal>
References: <CADRKj5Tv-NN8gCJgR-X2kCVtYzNJnS9r78FtaGZm6GrX3s2EuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbcLEOkb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Dec 2016 09:40:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7965E8F231
        for <ceph-devel@vger.kernel.org>; Mon,  5 Dec 2016 14:40:16 +0000 (UTC)
In-Reply-To: <CADRKj5Tv-NN8gCJgR-X2kCVtYzNJnS9r78FtaGZm6GrX3s2EuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "Just, Samuel" <sjust@redhat.com>, David Zafman <dzafman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 3 Dec 2016, Yehuda Sadeh-Weinraub wrote:
> rgw uses raw rados listing when doing certain operations. For example
> when listing metadata entries (these aren't being indexed). When doing
> a full metadata sync the rgw at the secondary zone sends a request to
> the master to get a list of all the metadata entries (of a specific
> section), so that it can build an internal index for these entries so
> that it can fetch them.
> One of the main issues here is that since the metadata listing relies
> on raw rados objects listing, the operation cannot be paged.
> I've looked at the nobjects listing code, and this is what I
> understand happening:
>  - we iterate through all the pgs in the pool, one by one and in order
>  - for each pg we're at we read a chunk of the next X (where X 1024)
> entries via rados pgls operation
>  - for each chunk rados returns a cookie, which is some kind of a
> descriptor that points at either the current, or the next chunk that
> can be used to fetch the next chunk
> 
> rados itself with the nobjects api provides some seek mechanism, but
> it's pretty rudimentary and only seeks by rounding down to the current
> pg. I was looking at introducing a marker for nobjects listing (see:
> https://github.com/yehudasa/ceph/commits/wip-18079), but there are a
> few points I'm not completely sure about:
>  - I was using cookie and current_pg as the marker, but that only
> points to the current chunk that was just read (but not necessarily
> consumed completely). Is there a way to generate a cookie that would
> point at any entry within the current chunk?

The real marker is this:

    collection_list_handle_t cookie;

in Objecter::NListContext, which is defined as

typedef hobject_t collection_list_handle_t;

In principle, we could use the hobject_t to iterater over the whole pool, 
but the mapping onto PGs is fragmented when sortbitwise isn't set, so we 
can't really remove this until we drop support for pre-jewel clusters and 
!sortbitwise in the client.

>  - Is entries order guaranteed within the chunk? E.g., if I know that
> the last cookie was C, and the last object we saw was O, can we
> request C again, and skip to object O and not miss any entries created
> before original operation started? (it is ok to miss on entries
> created after original operation started, as we're going to get these
> via separate log)

The OSD sets C either as hobject_t::get_max() (end of pg) or the next 
object that it didn't return as part of the result set.  If you are 
listing objects and return A,B,C and D is the 'next', and before you 
continue a C+1 is created, you'll "miss" that, but that's generally okay 
since it was creating during (not before) you were listing.

>  - is there any other field that we need to keep for the marker other
> than these two?

The hobject_t alone should be enough.  When you set the marker, just 
calculate current_pg from that.  That means that getting/setting the 
marker won't work properly for non-sortbitwise OSDs, but I think that's 
okay--starting with kraken we *require* that sortbitwise is set before 
allowing new OSDs to start, so a jewel is the last version that can ever 
have !sortbitwise.  You can put a check in rgw that verifies that the 
flag is set before starting...

>  - what to do with the old object listing api? the code internally
> defaults to using it, so if implementing seek only for nobjects it
> won't work by default. I'm not sure we want to implement it for the
> legacy listing infrastructure.

Hmm... I think we should implement it for the non-"n" variant too (I 
don't think it's necessarily legacy; users may be enumerating 
within a namespace).

sage
