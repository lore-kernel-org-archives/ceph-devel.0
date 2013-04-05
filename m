From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/20] libceph: per-op osd request data
Date: Fri, 05 Apr 2013 08:57:29 -0500
Message-ID: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:54745 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161369Ab3DEN5b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 09:57:31 -0400
Received: by mail-ia0-f176.google.com with SMTP id i1so3186031iaa.21
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 06:57:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series of patches arranges for each op in an osd request
to define its own incoming and outgoing data.  Doing so allows
a single request to contain muliple ops which provide outgoing
data, and even allows a single op to supply more than one item
of data.

A bunch of the patches here are fairly trivial cleanups, done
as I was figuring out how to get things done.  But in the end
the changes involved are significant so I tried to do them
in methodical steps.

These patches (and the one I just posted) are available in the
branch "review/wip-3761-1" in the ceph-client git repository.

					-Alex

[PATCH 01/20] rbd: define inbound data size for method ops
    Whoops, this one's not directly related to the rest, I
    intended to post this one by itself.

[PATCH 02/20] libceph: compute incoming bytes once
[PATCH 03/20] libceph: define osd data initialization helpers
[PATCH 04/20] libceph: define a few more helpers
[PATCH 05/20] libceph: define ceph_osd_data_length()
[PATCH 06/20] libceph: a few more osd data cleanups
    Simple cleanups, and code encapsulation.

[PATCH 07/20] rbd: define rbd_osd_req_format_op()
[PATCH 08/20] libceph: keep source rather than message osd op array
    Store the source op array in the osd request structure.

[PATCH 09/20] libceph: rename data out field in osd request op
[PATCH 10/20] libceph: add data pointers in osd op structures
[PATCH 11/20] libceph: specify osd op by index in request
    Start defining op data in the op structure itself.

[PATCH 12/20] rbd: don't set data in rbd_osd_req_format_op()
[PATCH 13/20] rbd: separate initialization of osd data
[PATCH 14/20] rbd: rearrange some code for consistency
    Changes to rbd so it doesn't assume single op per request.

[PATCH 15/20] libceph: format class info at init time
    Don't wait until formatting the op to lay out the request
    information (class, method, and data).  Define a new data
    item in the CALL op structure to represent this.

[PATCH 16/20] libceph: move ceph_osdc_build_request()
[PATCH 17/20] libceph: set message data when building osd request
[PATCH 18/20] libceph: combine initializing and setting osd data
[PATCH 19/20] libceph: set the data pointers when encoding ops
[PATCH 20/20] libceph: kill off osd request r_data_in and r_data_out
    These last five (four really) finally make the switch over
    to using data item descriptions present in the ops to
    dictate what's used in osd request and response messages.
