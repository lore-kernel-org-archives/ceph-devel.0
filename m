From: Alex Elder <elder@inktank.com>
Subject: OSD Data Read/Write Separation Patches
Date: Mon, 04 Mar 2013 12:05:18 -0600
Message-ID: <5134E25E.4030701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46069 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558Ab3CDSFT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:05:19 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so6628544iea.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:05:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

What follows are four series of patches that lead up to making
it clear exactly which data in an osd operation is outgoing
(being sent to an osd) and which is incoming (the result of
a read or object method call operation).  They build on each
other, with the results of one making the subsequent ones
possible (or at least easier to understand and verify).

The four series are:

[PATCH 0/3] libceph: a few cleanups
[PATCH 1/3] libceph: use (void *) for untyped data in osd ops
[PATCH 2/3] libceph: kill ceph_msg->pagelist_count
[PATCH 3/3] libceph: rename ceph_calc_object_layout()
    These are sort of miscellaneous cleanup, not directly
    related but fixed while I was working with nearby code.

[PATCH 0/3] libceph: simplify incoming message allocation
[PATCH 1/3] libceph: drop mutex while allocating a message
[PATCH 2/3] libceph: define mds_alloc_msg() method
[PATCH 3/3] libceph: no need for alignment for mds message
    This simplifies and localizes the code that allocates
    messages for incoming data.

[PATCH 0/3] ceph: assign message data fields consistently
[PATCH 1/3] ceph: use calc_pages_for() in start_read()
[PATCH 2/3] ceph: simplify ceph_sync_write() page_align calculation
[PATCH 3/3] libceph: don't assign page info in ceph_osdc_new_request()
    This allows the assignment of everything about the pages
    for holding data in an osd request to happen in consecutive
    lines of code, and such that it's done the same way throughout
    the ceph code.

[PATCH 0/3] libceph: distinguish osd request read and write data
[PATCH 1/3] libceph: separate osd request data info
[PATCH 2/3] libceph: distinguish page and bio requests
[PATCH 3/3] libceph: separate read and write data
    This encapsulates information about osd request data into a
    separate data structure, then defines separate instances
    of that structure for incoming and outgoing data.

These patches are available in branch "review/wip-rwsep" on
the ceph-client git repository.  Included before them are two
others I posted recently:

[PATCH] libceph: fix wrong opcode use in osd_req_encode_op()
[PATCH] libceph: complete lingering requests only once

					-Alex
