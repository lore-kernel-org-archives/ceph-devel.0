From: Alex Elder <elder@inktank.com>
Subject: Patch Backlog
Date: Mon, 31 Dec 2012 16:52:36 -0600
Message-ID: <50E21734.305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:58614 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab2LaWwg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 17:52:36 -0500
Received: by mail-ia0-f171.google.com with SMTP id k27so10870729iad.16
        for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 14:52:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The following patches are currently committed to the
ceph-client/testing branch but have not been reviewed.
(Well, two have; I marked them with "***" below.)

I'll repost them all for another chance at a review
in the next day or so.  (I've run out of time today.)

					-Alex

32ee823 libceph: reformat __reset_osd()
d00ab56 rbd: document rbd_spec structure
1c1e221 rbd: kill rbd_spec->image_name_len
17b40bd rbd: kill rbd_spec->image_id_len
643a911 rbd: use kmemdup()
966c4c4 ceph: define ceph_encode_8_safe()
bbafb1d rbd: define and use rbd_warn()
f84f83a rbd: add warning messages for missing arguments
151a20c rbd: add a warning in bio_chain_clone_range()
99485bd rbd: add warnings to rbd_dev_probe_update_spec()
2ce4745 rbd: standardize rbd_request variable names
307a8f2 rbd: standardize ceph_osd_request variable names
d129c15 rbd: be picky about osd request status type
5d8e059 rbd: encapsulate handling for a single request
1e64364 rbd: a little more cleanup of rbd_rq_fn()
f9ae366 rbd: end request on error in rbd_do_request() caller
001e8e7 rbd: make exists flag atomic
33fe3e0 rbd: only get snap context for write requests
ee6c009 rbd: separate layout init
f6e659a rbd: drop oid parameters from ceph_osdc_build_request()
e9eb323 rbd: drop snapid parameter from rbd_req_sync_read()
3b6f66e rbd: drop flags parameter from rbd_req_sync_exec()
e1546ee rbd: kill rbd_req_sync_op() snapc and snapid parameters
c09cade rbd: don't bother setting snapid in rbd_do_request()
04cbdda libceph: always allow trail in osd request
3dd703f libceph: kill op_needs_trail()
3a01434 libceph: pass length to ceph_osdc_build_request()
bd0d3cb libceph: pass length to ceph_calc_file_object_mapping()
aae30e3 libceph: drop snapid in ceph_calc_raw_layout()
dbeaa7d libceph: drop osdc from ceph_calc_raw_layout()
1c660b9 libceph: don't set flags in ceph_osdc_alloc_request()
826675c libceph: don't set pages or bio in ceph_osdc_alloc_request()
a38369d rbd: pass num_op with ops array
e224979 libceph: pass num_op with ops
da30c3e rbd: there is really only one op
88ef43e rbd: assume single op in a request
54d67dd rbd: kill ceph_osd_req_op->flags
66f5967 rbd: pull in ceph_calc_raw_layout()
8adec78 rbd: open code rbd_calc_raw_layout()
20ce1ab rbd: don't bother calculating file mapping
c5b060d rbd: use a common layout for each device
8d9dabc rbd: combine rbd sync watch/unwatch functions
adb8a03 rbd: don't leak rbd_req on synchronous requests
d9827c2 rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
d14c4ca rbd: don't assign extent info in rbd_do_request()
2ab08c4 rbd: don't assign extent info in rbd_req_sync_op()
fa41784 rbd: initialize off and len in rbd_create_rw_op()
94aa0b9 rbd: define generalized osd request op routines
deb0db2 rbd: move call osd op setup into rbd_osd_req_op_create()
e00478f rbd: move remaining osd op setup into rbd_osd_req_op_create()
7872443 rbd: assign watch request more directly

