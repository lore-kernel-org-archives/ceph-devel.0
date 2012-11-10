From: Alex Elder <elder@inktank.com>
Subject: Patch Backlog
Date: Fri, 09 Nov 2012 21:57:16 -0600
Message-ID: <509DD09C.4030506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42542 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab2KJD5O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:57:14 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6912729iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:57:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Below is the list of patches that I have posted in
the last week or so that have not yet been reviewed.

There is nothing very tricky about any of them, so if
you think you can take a look and give it your stamp of
approval (or offer suggestions for improvement) I'd
love to hear about it.  New people, here's your chance
to contribute!

Thanks.

					-Alex

[PATCH 1/5] rbd: document rbd_spec structure
[PATCH 2/5] rbd: kill rbd_spec->image_name_len
[PATCH 3/5] rbd: kill rbd_spec->image_id_len
[PATCH 4/5] rbd: don't use ENOTSUPP
[PATCH 5/5] rbd: use kmemdup()

[PATCH] ceph: define ceph_encode_8_safe()

[PATCH] rbd: fix ceph_pg_poolid_by_name()

[PATCH 1/4] rbd: define and use rbd_warn()
[PATCH 2/4] rbd: add warning messages for missing arguments
[PATCH 3/4] rbd: add a warning in bio_chain_clone_range()
[PATCH 4/4] rbd: add warnings to rbd_dev_probe_update_spec()

[PATCH 1/3] rbd: standardize rbd_request variable names
[PATCH 2/3] rbd: standardize ceph_osd_request variable names
[PATCH 3/3] rbd: be picky about osd request status type

[PATCH 1/2] rbd: encapsulate handling for a single request
[PATCH 2/2] rbd: a little more cleanup of rbd_rq_fn()

[PATCH] rbd: end request on error in rbd_do_request() caller

[PATCH 8/5] rbd: fix reference leak in rbd_do_op()
[PATCH 9/5] rbd: only get snap context for write requests

[PATCH] rbd: separate layout init

[PATCH 1/4] rbd: drop oid parameters from
[PATCH 2/4] rbd: drop snapid parameter from rbd_req_sync_read()
[PATCH 3/4] rbd: drop flags parameter from rbd_req_sync_exec()
[PATCH 4/4] rbd: kill rbd_req_sync_op() snapc and snapid

[PATCH] rbd: don't bother setting snapid in rbd_do_request()

[PATCH] rbd: get rid of RBD_MAX_SEG_NAME_LEN
