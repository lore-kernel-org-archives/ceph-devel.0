From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: drop some unnecessary function parameters
Date: Fri, 09 Nov 2012 21:41:26 -0600
Message-ID: <509DCCE6.5060009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58779 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab2KJDl0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:41:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6903123iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:41:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

These four patches drop some parameters that are not needed from
a number of functions.

					-Alex

[PATCH 1/4] rbd: drop oid parameters from ceph_osdc_build_request()
[PATCH 2/4] rbd: drop snapid parameter from rbd_req_sync_read()
[PATCH 3/4] rbd: drop flags parameter from rbd_req_sync_exec()
[PATCH 4/4] rbd: kill rbd_req_sync_op() snapc and snapid parameters
