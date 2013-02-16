From: Alex Elder <elder@inktank.com>
Subject: Cleanup Patches
Date: Sat, 16 Feb 2013 10:23:55 -0600
Message-ID: <511FB29B.3060606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:35035 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab3BPQYD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:24:03 -0500
Received: by mail-qa0-f44.google.com with SMTP id bv4so728364qab.17
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:23:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm about to post several series that contain a bunch of
cleanups.  The motivation for this is to simplify some code
before setting out to refactor it, to eliminate any unneeded
complexity.

I've grouped them into smaller series though the patches in
a series may not appear to be logically connected.

These have all been tested together though, and were
applied in the sequence shown below.  They're available
in the branch "wip-osd-cleanup" on the ceph-client git
repository.

					-Alex

[PATCH] libceph: improve packing in struct ceph_osd_req_op

[PATCH 0/4] libceph: get rid of some unneeded function parameters
[PATCH 1/4] ceph: kill ceph_osdc_writepages() "nofail" parameter
[PATCH 2/4] ceph: kill ceph_osdc_writepages() "dosync" parameter
[PATCH 3/4] ceph: kill ceph_osdc_writepages() "flags" parameter
[PATCH 4/4] ceph: kill ceph_osdc_new_request() "num_reply"

[PATCH 0/3] libceph: a few miscellaneous cleanups
[PATCH 1/3] libceph: lock outside send_queued()
[PATCH 2/3] libdeph: don't export ceph_osdc_init() or
[PATCH 3/3] libceph: kill ceph_calc_raw_layout()

[PATCH 0/2] libceph: get rid of unused "one shot" event support
[PATCH 1/2] libceph: kill ceph_osdc_create_event() "one_shot"
[PATCH 2/2] libceph: kill ceph_osdc_wait_event()

[PATCH 0/3] libceph: update rados.h and related code
[PATCH 1/3] libceph: update rados.h
[PATCH 2/3] libceph: add ceph_osd_state_name()
[PATCH 3/3] libceph: update ceph_osd_op_name()

[PATCH 0/2] libceph: update osd_req_encode_op()
[PATCH 1/2] libceph: report defined but unsupported osd ops
[PATCH 2/2] libceph: remove dead code in osd_req_encode_op()

[PATCH 0/2] libceph: update ceph_fs.h and related code
[PATCH 1/2] libceph: update ceph_fs.h
[PATCH 2/2] libceph: update ceph_mds_state_name() and ceph_mds_op_name()

[PATCH] ceph: simplify ceph_sync_write() page_align

[PATCH] libceph: simplify data length calculation
