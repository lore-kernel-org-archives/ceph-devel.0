From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: snap context references
Date: Fri, 09 Nov 2012 21:05:23 -0600
Message-ID: <509DC473.805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39983 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2KJDFY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:05:24 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6882855iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:05:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

These two patches are related to how snapshot context
reference counting is handled in rbd_do_op().

					-Alex

[PATCH 1/2] rbd: fix reference leak in rbd_do_op()
[PATCH 2/2] rbd: only get snap context for write requests
