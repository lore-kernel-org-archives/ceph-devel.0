From: Mark Nelson <mnelson@redhat.com>
Subject: Re: wip-denc
Date: Wed, 14 Sep 2016 15:31:34 -0500
Message-ID: <586b1c87-1286-9b33-a7b4-b5aed07598d5@redhat.com>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756664AbcINUbh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 16:31:37 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDCB43F755
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 20:31:36 +0000 (UTC)
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

Alright, made it through a round of benchmarking without crashing this 
time.  This is wip-denc + 11059 + 11014 on 4 NVMe cards split into 16 
OSDs.  Need to add the additional memory reduction patches, but for now 
this gives us a bit of an idea where we are at. Scroll to the right for 
graphs.

https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZNi1aU1htRDRDekk

1) Basically sequential reads look bad, but we've known that for a while 
and we can look at it again once the dust settles.  We've never been 
great compared to filestore, but something took a turn for the worst 
earlier this summer.

2) Sequential writes are looking pretty great, and have been since july 
after a bitmap allocator fix.

3) Random read performance has dropped pretty significantly recently. 
Sage thinks this might be the sharding.

4) Small random write performance is about twice as fast, mostly due to 
the sharding, though I'd argue indirectly.  I'd argue this is really due 
to the reduction in bufferlist appends as we saw nearly the same 
improvement when we used the appender with the old code.  These tests 
continue to be CPU limited.

5) Sequential mixed read/write tests look pretty similar to the 7/28 
tests.  The difference vs jewel bluestore seems to primarily be the 
bitmap allocator, but other changes might be having an effect as well.

6) Random mixed read/write tests have improved since 7/28 with the 
sharding and encode/decode changes.  Performance is much higher for 
larger IOs and a little slower for 4K IOs, but it's fairly competitive 
in these tests.

>
> Thanks-
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
