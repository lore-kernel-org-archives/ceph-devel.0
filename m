From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/7] rbd: drop unused parameters from functions
Date: Thu, 26 Jul 2012 13:46:14 -0500
Message-ID: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47164 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab2GZSqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:46:16 -0400
Received: by yenl2 with SMTP id l2so2319097yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:46:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All the patches in this series just drop unused parameters from
their functions.

					-Alex

[PATCH 1/7] rbd: snapc is unused in rbd_req_sync_read()
[PATCH 2/7] rbd: drop rbd_header_from_disk() gfp_flags parameter
[PATCH 3/7] rbd: drop rbd_dev parameter in snap functions
[PATCH 4/7] rbd: drop "object_name" from rbd_req_sync_watch()
[PATCH 5/7] rbd: drop "object_name" from rbd_req_sync_notify()
[PATCH 6/7] rbd: drop "object_name" from rbd_req_sync_notify_ack()
[PATCH 7/7] rbd: drop "object_name" from rbd_req_sync_unwatch()
