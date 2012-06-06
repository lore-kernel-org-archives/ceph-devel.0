From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/11] continued messenger-related changes
Date: Tue, 05 Jun 2012 22:24:47 -0500
Message-ID: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39387 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab2FFDYn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:24:43 -0400
Received: by yenm10 with SMTP id m10so4635568yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:24:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a series of 11 related patches but I've grouped them into
smaller sub-sets as follows.  A few of these were posted previously
but their changes--if any--were merely related to adjustments to
account for other patches inserted before them in the series.  Two
of them are being submitted on behalf of Sage Weil.

These patches can also be viewed here:
    https://github.com/ceph/ceph-client/commits/wip-messenger-review

					-Alex

[PATCH] libceph: osd_client: don't drop reply reference too early
    This fixes a potential bug found by inspection.

[PATCH] libceph: use con get/put ops from osd_client
    This fixes a possibly serious problem with reference counting
    that Sage found while reviewing my last series of patches.

[PATCH 1/2] libceph: embed ceph connection structure in mon_client
[PATCH 2/2] libceph: drop connection refcounting for mon_client
    These two rearrange how the ceph connection is represented in
    a mon_client structure, and make the referencing counting
    methods no-ops.

[PATCH 1/2] libceph: init monitor connection when opening
[PATCH 2/2] libceph: fully initialize connection in con_init()
    This finishes a small sub-series from before that did not get
    fully committed.  It unifies the way ceph connections are
    initialized so that ceph connection fields are manipulated by
    the messenger code, not the caller.

[PATCH] libceph: tweak ceph_alloc_msg()
    This is a standalone cleanup that aims to make the real purpose
    of this function a bit more obvious.

[PATCH 1/4] libceph: have messages point to their connection
[PATCH 2/4] libceph: have messages take a connection reference
[PATCH 3/4] libceph: make ceph_con_revoke() a msg operation
[PATCH 4/4] libceph: make ceph_con_revoke_message() a msg op
    These four patches make every message maintain a reference to
    the connection it is associated with.  Having this reference
    allows the revoke routines to be called with a message alone
    rather than having to supply a connection pointer as well.
