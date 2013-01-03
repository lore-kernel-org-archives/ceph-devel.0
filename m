From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/2] rbd: only get snap context for write requests
Date: Thu, 03 Jan 2013 16:53:04 -0600
Message-ID: <50E60BD0.30408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35132 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab3ACWxH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 17:53:07 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so18910562iej.4
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 14:53:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series stops acquiring the snap context for read requests.

					-Alex

[PATCH REPOST 1/2] rbd: make exists flag atomic
[PATCH REPOST 2/2] rbd: only get snap context for write requests
