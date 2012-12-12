From: Alex Elder <elder@inktank.com>
Subject: Updated Patch Backlog
Date: Wed, 12 Dec 2012 10:06:49 -0600
Message-ID: <50C8AB99.7030004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:49772 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab2LLQGv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 11:06:51 -0500
Received: by mail-ia0-f180.google.com with SMTP id t4so996673iag.11
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 08:06:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Below is a list of the patches I've posted in the last
six weeks or so.  Most of them are still in need of a
review.

I'll say what I said last time, there's not a lot of
magic in here, and if you can read C code you can offer
a review and I would love to hear from you.

If you think it looks correct, say so by responding
to the patch message (to the list) and provide your
"Reviewed-by" tag, which looks like:

    Reviewed-by: My Name <myname@mydomain.com>

And of course if you think there's something wrong, or
room for improvement, please say that too.

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

---  above were backlog as of 11/9/12; below are new since then

[PATCH 1/2] libceph: always allow trail in osd request
[PATCH 2/2] libceph: kill op_needs_trail()

[PATCH 1/4] libceph: pass length to ceph_osdc_build_request()
[PATCH 2/4] libceph: pass length to ceph_calc_file_object_mapping()
[PATCH 3/4] libceph: drop snapid in ceph_calc_raw_layout()
[PATCH 4/4] libceph: drop osdc from ceph_calc_raw_layout()

[PATCH 1/2] libceph: don't set flags in ceph_osdc_alloc_request()
[PATCH 2/2] libceph: don't set pages or bio in ceph_osdc_alloc_request()

[PATCH 1/4] rbd: pass num_op with ops array
[PATCH 2/4] libceph: pass num_op with ops
[PATCH 3/4] rbd: there is really only one op
[PATCH 4/4] rbd: assume single op in a request

[PATCH] rbd: kill ceph_osd_req_op->flags

[PATCH] rbd: combine rbd sync watch/unwatch functions

[PATCH 1/4] rbd: pull in ceph_calc_raw_layout()
[PATCH 2/4] rbd: open code rbd_calc_raw_layout()
[PATCH 3/4] rbd: don't bother calculating file mapping
[PATCH 4/4] rbd: use a common layout for each device

[PATCH] rbd: get rid of rbd_{get,put}_dev()
    (reviewed)

[PATCH, v2] rbd: do not allow remove of mounted-on image

[PATCH 1/6] rbd: don't assign extent info in rbd_do_request()
[PATCH 2/6] rbd: don't assign extent info in rbd_req_sync_op()
[PATCH 3/6] rbd: initialize off and len in rbd_create_rw_op()
[PATCH 4/6] rbd: define generalized osd request op routines
[PATCH 5/6] rbd: move call osd op setup into rbd_osd_req_op_create()
[PATCH 6/6] rbd: move remaining osd op setup into rbd_osd_req_op_create()

[PATCH] rbd: assign watch request more directly

[PATCH] ceph: don't reference req after put
    (reviewed)

[PATCH 1/2] rbd: don't leak rbd_req on synchronous requests
    (reviewed)
[PATCH 2/2] rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
    (reviewed)

[PATCH 1/4] libceph: avoid using freed osd in __kick_osd_requests()
[PATCH 2/4] libceph: register request before unregister linger
[PATCH 3/4] libceph: socket can close in any connection state
[PATCH 4/4] libceph: init osd->o_node in create_osd()

[PATCH] rbd: remove linger unconditionally

[PATCH] libceph: reformat __reset_osd()
