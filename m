From: Alex Elder <elder@inktank.com>
Subject: More Messenger Patches
Date: Tue, 12 Mar 2013 20:01:33 -0500
Message-ID: <513FCFED.1080507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53125 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBBh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:01:37 -0400
Received: by mail-ob0-f180.google.com with SMTP id ef5so502736obb.11
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:01:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm about to post another set of patches.  As usual I've
tried to group them logically, and in this case there are
several single patches.

This series continues moving the messenger toward supporting
multiple chunks of data in a single message.  We need this
to support osd client requests which hold multiple osd
operations, having one (or even more than one) separate
pieces of data associated with each.  That in turn is
needed to support rbd layering.

Most of this process has been whittling away at the various
ways the messenger represents its data.  There were at one
time four distinct ways of representing it, and it was not
clear which were independent or how they interacted.  The
logic for handling incoming and outgoing messages was a
little complicated by the presence of these different ways
of representing things.

We now have a unified "ceph_msg_data_item" structure
that represents an abstract chunk of data, in one of
several possible formats.  The patches change the code
so data items are used for incoming data, then collapses
them all into a single data item.  In the process it
cleans up a bunch of structures and code that have
been superseded by the abstracted way of doing things.

These patches are available on the "review/wip-read-data-items"
branch of the ceph-client git repository.

					-Alex

[PATCH] libceph: drop pages parameter

[PATCH] libceph: no outbound zero data

[PATCH] libceph: record residual bytes for all message data types

[PATCH 0/4] libceph: use cursor for incoming data
[PATCH 1/4] libceph: use cursor for bio reads
[PATCH 2/4] libceph: kill ceph message bio_iter, bio_seg
[PATCH 3/4] libceph: use cursor for inbound data pages
[PATCH 4/4] libceph: get rid of read helpers

[PATCH] libceph: collapse all data items into one


[PATCH 0/4] libceph: get rid of ceph_msg_pos
[PATCH 1/4] libceph: use cursor resid for loop condition
[PATCH 2/4] libceph: kill most of ceph_msg_pos
[PATCH 3/4] libceph: kill last of ceph_msg_pos
[PATCH 4/4] libceph: use only ceph_msg_data_advance()

[PATCH] libceph: make message data be a pointer
