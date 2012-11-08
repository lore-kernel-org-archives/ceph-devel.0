From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: clean up rbd_rq_fn()
Date: Thu, 08 Nov 2012 08:10:24 -0600
Message-ID: <509BBD50.3010102@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43657 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab2KHOKZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 09:10:25 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so1927335iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 06:10:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Some refactoring to improve readability.	-Alex

[PATCH 1/2] rbd: encapsulate handling for a single request
[PATCH 2/2] rbd: a little more cleanup of rbd_rq_fn()
