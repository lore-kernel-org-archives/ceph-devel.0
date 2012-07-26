From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/7] rbd: more miscellaneous refactoring
Date: Thu, 26 Jul 2012 14:01:53 -0500
Message-ID: <50119421.1090702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46822 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab2GZTBz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:01:55 -0400
Received: by yhmm54 with SMTP id m54so2343744yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:01:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These patches consist of various refactoring that didn't fit
into any particular category.  Several involve changing function
prototypes to return a pointer, or return some other bit of
information, in order to simplify or constrain things.

Read their individual descriptions for better detail.

					-Alex

[PATCH 1/7] rbd: have __rbd_add_snap_dev() return a pointer
[PATCH 2/7] rbd: make rbd_create_rw_ops() return a pointer
[PATCH 3/7] rbd: pass null version pointer in add_snap()
[PATCH 4/7] rbd: always pass ops array to rbd_req_sync_op()
[PATCH 5/7] rbd: fixes in rbd_header_from_disk()
[PATCH 6/7] rbd: return obj version in __rbd_refresh_header()
[PATCH 7/7] rbd: create rbd_refresh_header()
