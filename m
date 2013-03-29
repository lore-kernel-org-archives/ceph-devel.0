From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: use op formatter for ceph_osdc_new_request()
Date: Fri, 29 Mar 2013 16:30:54 -0500
Message-ID: <5156080E.9040603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:56194 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066Ab3C2Va5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:30:57 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so689630iag.17
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:30:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The only place outside rbd that allocates an osd request
and then initializes the array of osd ops inside it is
ceph_osdc_new_request().  This series rearranges a little
code so that the new op formatting functions (osd_req_op_init()
and osd_req_op_extent_init()) can be used there.

					-Alex

[PATCH 1/4] libceph: pass offset and length out of calc_layout()
[PATCH 2/4] libceph: don't update op in calc_layout()
[PATCH 3/4] libceph: clean up ceph_osd_new_request()
[PATCH 4/4] libceph: use osd_req_op_extent_init()
