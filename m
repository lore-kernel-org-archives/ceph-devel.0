From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/6] rbd: consolidate osd request setup
Date: Fri, 04 Jan 2013 09:03:59 -0600
Message-ID: <50E6EF5F.9080200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:38311 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741Ab3ADPEB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 10:04:01 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so19707406iea.24
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 07:04:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series consolidates and encapsulates the setup of all
osd requests into a single function which takes variable
arguments appropriate for the type of request.  The result
groups together common code idioms and I think makes the
spots that build these messages a little easier to read.

					-Alex

[PATCH REPOST 1/6] rbd: don't assign extent info in rbd_do_request()
[PATCH REPOST 2/6] rbd: don't assign extent info in rbd_req_sync_op()
[PATCH REPOST 3/6] rbd: initialize off and len in rbd_create_rw_op()
[PATCH REPOST 4/6] rbd: define generalized osd request op routines
[PATCH REPOST 5/6] rbd: move call osd op setup into rbd_osd_req_op_create()
[PATCH REPOST 6/6] rbd: move remaining osd op setup into
rbd_osd_req_op_create()
