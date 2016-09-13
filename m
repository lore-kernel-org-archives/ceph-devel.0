From: Mark Nelson <mnelson@redhat.com>
Subject: Re: wip-denc
Date: Tue, 13 Sep 2016 18:45:52 -0500
Message-ID: <a89da24e-7791-ef4a-acce-9f653eaac08e@redhat.com>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcIMXp4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 19:45:56 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E341B9AD9
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 23:45:55 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org



On 09/13/2016 04:17 PM, Sage Weil wrote:
> Hi everyone,
>
> Okay, I have a new wip-denc branch working and ready for some review:
>
> 	https://github.com/ceph/ceph/pull/11027
>
> Highlights:
>
> - This includes appender/iterator changes to buffer* to speed up
> encoding and decoding (fewer bounds checks, simpler structures).
>
> - Accordingly, classes/types using the new-style have different arguments
> types for encode/decode.  There is also a new bound_encode() method that
> is used to calculate how big of a buffer to preallocate.
>
> - Most of the important helpers for doing types have new versions that
> work with the new framework (e.g., the ENCODE_START macro has a
> new DENC_START counterpart).
>
> - There is also a mechanism that lets you define the bound_encode,
> encode, and decode methods all in one go using some template magic.  This
> only works for pretty simple types, but it is handy.  It looks like so:
>
>   struct foo_t {
>     uint32_t a, b;
>     ...
>     DENC(foo_t, v, p) {
>       DENC_START(1, 1, p);
>       denc(v.a, p);
>       denc(v.b, p);
>       ...
>       DENC_FINISH(p);
>     }
>   };
>   WRITE_CLASS_DENC(foo_t)
>
>
> - For new-style types, a new 'denc' function that is overload to do either
> bound_encode, encode, or decode (based on argument types) is defined.
> That means that
>
>   ::denc(v, p);
>
> will work for size_t& p, bufferptr::iterator& p, or
> bufferlist::contiguous_appender& p.  This facilitates the DENC definitions
> above.
>
> - There is glue to invoke new-style encode/decode when old-style encode()
> and decode() are invoked, provided a denc_traits<T> is defined.
>
> - Most of the common containers are there list, vector, set, map, pair,
> but others need to be converted.
>
> - Currently, we're a bit aggressive about using the new-style over the
> old-style when we have the change.  For example, if you have
>
>   vector<int32_t> foo;
>   ::encode(foo, bl);
>
> it will see that it knows how to do int32_t new-style and invoke the
> new-style vector<> code.  I think this is going to be a net win, since
> we avoid doing bounds checks on append for every element (and the
> bound_encode is O(1) for thees base types).  On the other hand, it is
> currently smart enough to not use new-style for individual integer
> types, like so
>
>   int32_t v;
>   ::encode(v, bl);
>
> although I suspect after the optimizer gets done with it the generated
> machine code is almost identical.
>
> - Most of the key bluestore types are converted over so that we can do
> some benchmarking.
>
> An overview is at the top of the new denc.h header here:
>
> 	https://github.com/liewegas/ceph/blob/wip-denc/src/include/denc.h#L55
>
> I think I've captured the best of Allen's, Varada's, and Sam's various
> approaches, but we'll see how it behaves.  Let me know what you think!

So far this is working pretty well!  It's not even crashing anymore. :D

Just recapping from IRC for ceph-devel: Overall append overhead is lower 
than it was before, but not as low as we got it in the old code by 
creating a single appender all the way from ENCODE_START to 
ENCODE_FINISH and (manually) estimating the memory to allocate across 
the whole thing.  On the other hand we are faster overall now with the 
extentmap sharding, so we're on the right track!  Here we're calling 
encode_some potentially many times in ExtentMap::update and creating a 
new appender for each encode_some call.  Not sure if we are flushing 
multiple times or only at the end, but buffer::list::append is still 
consuming a decent chunk of CPU, and encode_some itself is too. I'm 
suspicious of the c_str() calls and pbl->append(bufferptr(bp, 0, l) even 
though they aren't being explicitly singled out by perf.  In any event 
there's probably some tweaking to do here.

Beyond that I don't have much to report yet.  Rb_tree_increment in 
encode_spanning_blobs and BitMapAreaLeaf::child_check_n_lock are 
starting to show up as bigger % consumers than they used to, so that's 
good news.

FWIW, it looks like we are getting about a 1-4% performance improvement 
over master from this in my CPU limited case.  So far memory usage is 
still pretty high, with OSDs using about 5.3GB of RSS per OSD at the end 
of a 5 minute randwrite test.

Mark

>
> Thanks-
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
