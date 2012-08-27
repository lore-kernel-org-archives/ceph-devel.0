From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Transforming a bufferlist iterator into new bufferlist
Date: Mon, 27 Aug 2012 12:33:03 -0700
Message-ID: <CAPrxi590uJZWYpcWb-uhNucH57_AcSEepbGi-0M9o5zQPf=ZvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34025 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab2H0TdE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 15:33:04 -0400
Received: by ialo24 with SMTP id o24so8932925ial.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 12:33:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have a bufferlist use case that I can't quite resolve. I'm packing
up a struct and a blob, but not sure how to seek to the beginning of
the blob correctly during decode:

1. Setup bufferlist

  /* add header */
  struct header hdr;
  ::encode(hdr, bl);

  /* add payload blob */
  bl.append(buf, len);

2. Later in decode ...

  /* get header */
  bufferlist::iterator it = in.begin();
  ::decode(hdr, it);

  **problem: Want to get a bufferlist for the payload, which is
presumably exactly where the iterator now points. How should that
transformation happen with zero-copy?

Thanks,
Noah
