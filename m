From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/5] rbd: drop some unneeded parameters
Date: Thu, 03 Jan 2013 17:17:09 -0600
Message-ID: <50E61175.7010103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61100 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3ACXRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:17:12 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so18737173iea.7
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:17:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series cleans up some parameter lists, eliminating parameters
that don't need to be used.

					-Alex

[PATCH REPOST 1/5] rbd: drop oid parameters from ceph_osdc_build_request()
[PATCH REPOST 2/5] rbd: drop snapid parameter from rbd_req_sync_read()
[PATCH REPOST 3/5] rbd: drop flags parameter from rbd_req_sync_exec()
[PATCH REPOST 4/5] rbd: kill rbd_req_sync_op() snapc and snapid parameters
[PATCH REPOST 5/5] rbd: don't bother setting snapid in rbd_do_request()
