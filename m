From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] rbd: consolidate request operation creation
Date: Tue, 20 Nov 2012 13:52:42 -0600
Message-ID: <50ABDF8A.4080206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39615 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2KTTwr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 14:52:47 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4502529iay.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 11:52:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm working on getting data structures for every rbd image request
initialized in one place, and similarly getting all osd object
requests for rbd images initialized at once at well. This series
addresses an issue I bumped into while trying to do this, and
then goes a little further to implement the centralized op
initialization.

For read or write osd operations, their offset and length fields
as well as the operation's payload length field are assigned
fairly late, as the osd request is getting built up in
rbd_do_request().  This is sort of strange; all of the other
request types get all their fields assigned right after
their osd op structure gets created.

This series moves those late assignments for read and write
ops earlier, ultimately into the existing "create op" function.
It then creates a new function that fully initializes the
op with provided arguments for all op types.

We end up with a single function that fully initializes
osd ops of any type, as desired.

					-Alex

[PATCH 1/6] rbd: don't assign extent info in rbd_do_request()
[PATCH 2/6] rbd: don't assign extent info in rbd_req_sync_op()
[PATCH 3/6] rbd: initialize off and len in rbd_create_rw_op()
[PATCH 4/6] rbd: define generalized osd request op routines
[PATCH 5/6] rbd: move call osd op setup into rbd_osd_req_op_create()
[PATCH 6/6] rbd: move remaining osd op setup into rbd_osd_req_op_create()
