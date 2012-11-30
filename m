From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: fix two memory leaks
Date: Fri, 30 Nov 2012 10:03:32 -0600
Message-ID: <50B8D8D4.9020703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:37363 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180Ab2K3QDf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 11:03:35 -0500
Received: by mail-ye0-f174.google.com with SMTP id m6so80646yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 08:03:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series fixes two memory leaks that occur whenever a "special"
(non I/O) osd request in rbd.

					-Alex

[PATCH 1/2] rbd: don't leak rbd_req on synchronous requests
[PATCH 2/2] rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
