From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] ceph: cleanup ceph page vector functions
Date: Fri, 08 Feb 2013 10:31:03 -0600
Message-ID: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:49466 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946518Ab3BHQbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:31:07 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so4251340oag.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:31:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series does some cleanup related to some functions that
implement ceph page vectors.  Together, these resolve:
    http://tracker.ceph.com/issues/4053

					-Alex

[PATCH 1/5] ceph: remove a few bogus declarations
[PATCH 2/5] libceph: use void pointers in page vector functions
[PATCH 3/5] rbd: prevent bytes transferred overflow
[PATCH 4/5] rbd: ignore result of ceph_copy_from_page_vector()
[PATCH 5/5] libceph: drop return value from page vector copy
