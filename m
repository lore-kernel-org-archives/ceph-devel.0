From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/2] rbd: simplify rbd_rq_fn()
Date: Thu, 03 Jan 2013 16:42:23 -0600
Message-ID: <50E6094F.9080101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:60886 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab3ACWm0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 17:42:26 -0500
Received: by mail-ia0-f169.google.com with SMTP id u20so6858318iag.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 14:42:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series pulls the core processing out of rbd_rq_fn(),
then simplifies the result a little further.

					-Alex

[PATCH REPOST 1/2] rbd: encapsulate handling for a single request
[PATCH REPOST 2/2] rbd: a little more cleanup of rbd_rq_fn()
