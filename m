From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/2] rbd: fix two leaks
Date: Fri, 04 Jan 2013 08:57:18 -0600
Message-ID: <50E6EDCE.8050608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40620 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab3ADO5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:57:19 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so19499531iea.7
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:57:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When certain special osd requests are processed, they have data
structures allocated that are not properly freed when the request
is completed.  This series fixes that.

					-Alex

[PATCH REPOST 1/2] rbd: don't leak rbd_req on synchronous requests
[PATCH REPOST 2/2] rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
