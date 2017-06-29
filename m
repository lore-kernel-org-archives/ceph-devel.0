From: Mohamad Gebai <mgebai@suse.com>
Subject: Bug 19198: Double the memory caused by page alignment
Date: Thu, 29 Jun 2017 14:14:05 -0400
Message-ID: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39408 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbdF2SOV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 29 Jun 2017 14:14:21 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

The ticket http://tracker.ceph.com/issues/19198 says that Bluestore uses
twice as much memory than it should, and the description talks about
page alignment. By looking at the unit test in attachment (see
Bugzilla), I came to the conclusion that it is neither a Bluestore nor a
Ceph bug, but it's simply due to the allocation pattern. The unit test
that reproduces the bug does page-aligned allocations of 4KB blocs (a
page size) in a tight loop. What each allocation ends up doing is the
following:

1. Find the next page boundary because the user (caller of malloc) wants
a page-aligned allocation
2. Allocate the memory requested by the user (a whole page)
3. Keep metadata about that chunk of memory

We can see in this case two pages have been touched: one for the user
and, one for the metadata. Since this is in a tight loop, each iteration
skips a page that is almost completely empty in order to do have the
next allocation page-aligned. This is the worst case scenario, and makes
it seem like Bluestore uses "twice" the memory it should.

If the unit test was doing page-aligned allocation of 40KB, it would
seem like 10% more memory is used (10 pages for the data and one page
for the metadata). What this suggests is that there isn't a direct
solution for this "bug". Alternatively, if a the unit test did
allocations of a page and a half, it would seem like Bluestore uses 33%
more memory than it should.

If the page-aligned allocations are large, and if they are sparse (ie.
there are random smaller non-page-aligned allocations in between), the
heap is much less fragmented, and it won't seem like the memory is
wasted. Does that seem like a reasonable hypothesis or did I completely
misunderstand the bug report?

How this affects Bluestore is in buffer::create_page_aligned(). The
question is: what is the pattern that would cause bufferlist to create
page-aligned buffers that are only a page in size? It doesn't seem like
*any* usage of Bluestore causes this issue (played around with rados
bench without seeing the problem).

Note that the unit test attached in the ticket is deprecated.

Mohamad

