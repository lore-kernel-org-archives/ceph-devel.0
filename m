From: Sage Weil <sweil@redhat.com>
Subject: wip-denc
Date: Tue, 13 Sep 2016 21:17:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754521AbcIMVRV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 17:17:21 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 436394E4D5
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 21:17:21 +0000 (UTC)
Received: from ovpn-112-101.phx2.redhat.com (ovpn-112-101.phx2.redhat.com [10.3.112.101])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8DLHJxs023017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 17:17:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

Okay, I have a new wip-denc branch working and ready for some review:

	https://github.com/ceph/ceph/pull/11027

Highlights:

- This includes appender/iterator changes to buffer* to speed up 
encoding and decoding (fewer bounds checks, simpler structures).

- Accordingly, classes/types using the new-style have different arguments 
types for encode/decode.  There is also a new bound_encode() method that 
is used to calculate how big of a buffer to preallocate.

- Most of the important helpers for doing types have new versions that 
work with the new framework (e.g., the ENCODE_START macro has a 
new DENC_START counterpart).

- There is also a mechanism that lets you define the bound_encode, 
encode, and decode methods all in one go using some template magic.  This 
only works for pretty simple types, but it is handy.  It looks like so:

  struct foo_t {
    uint32_t a, b;
    ...
    DENC(foo_t, v, p) {
      DENC_START(1, 1, p);
      denc(v.a, p);
      denc(v.b, p);
      ...
      DENC_FINISH(p);
    }
  };
  WRITE_CLASS_DENC(foo_t)
  

- For new-style types, a new 'denc' function that is overload to do either 
bound_encode, encode, or decode (based on argument types) is defined.  
That means that

  ::denc(v, p);

will work for size_t& p, bufferptr::iterator& p, or 
bufferlist::contiguous_appender& p.  This facilitates the DENC definitions 
above.

- There is glue to invoke new-style encode/decode when old-style encode() 
and decode() are invoked, provided a denc_traits<T> is defined.

- Most of the common containers are there list, vector, set, map, pair, 
but others need to be converted.

- Currently, we're a bit aggressive about using the new-style over the 
old-style when we have the change.  For example, if you have 

  vector<int32_t> foo;
  ::encode(foo, bl);

it will see that it knows how to do int32_t new-style and invoke the 
new-style vector<> code.  I think this is going to be a net win, since 
we avoid doing bounds checks on append for every element (and the 
bound_encode is O(1) for thees base types).  On the other hand, it is 
currently smart enough to not use new-style for individual integer 
types, like so

  int32_t v;
  ::encode(v, bl);

although I suspect after the optimizer gets done with it the generated 
machine code is almost identical.

- Most of the key bluestore types are converted over so that we can do 
some benchmarking.

An overview is at the top of the new denc.h header here:

	https://github.com/liewegas/ceph/blob/wip-denc/src/include/denc.h#L55

I think I've captured the best of Allen's, Varada's, and Sam's various 
approaches, but we'll see how it behaves.  Let me know what you think!

Thanks-
sage

