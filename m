From: Ning Yao <zay11022@gmail.com>
Subject: Lose allocation hint attribute after recovery or backfill
Date: Thu, 2 Jun 2016 19:01:48 +0800
Message-ID: <CALZt5jzdVMgZo7jxw9oxDJHUiQ72j1ubKN7=CP1cE7uX0+u+OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36424 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcFBLBu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 07:01:50 -0400
Received: by mail-wm0-f54.google.com with SMTP id n184so73954680wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 04:01:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage

Currently, allocation hint is set into filesystem fsxattr, like XFS.
Or directly assign to onode_t in Blustore and Kstore.
It works as expected normally.  However, if the cluster begins to
recovering or backfilling object. Those recovered object will lose
allocation hint fsxattr forever. This means if a cluster experienced
osd up/down flapping, then those kind of hot accessed object will not
have the allocation hint xattr any more.
As a result, those objects will not be fully written (1M/4M)
eventually become fragmented. This will also happen if an object is
truncated (become of enabling qume discard option).

Therefore, we may want to preserve the allocation hint fsxattr during
recovery, there are two alternatives to do this.
1. issue set_alloc_hint with the current object size during recovery, like
    t->set_alloc_hint(cid, oid,  expected_object_size, expected_object_size)
    but it would be a problem for us to retrieve the
expected_object_size. For a block image, it may be object_size in
image metadata.

2. So I would like to directly transfer the information of hint
fsxattr to the recovered object. Also, I find that a new param flags
will be used to indicated whether the data will be compressed.
So I propose a PR Like this:
https://github.com/ceph/ceph/pull/9452

I think the issue may not be related to BlueStore or KStore because of
the allocation hint attribute can be overwritten in later
set_allocation_hint Ops?



Regards
Ning Yao
