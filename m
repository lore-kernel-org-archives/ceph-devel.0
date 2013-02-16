From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: a few miscellaneous cleanups
Date: Sat, 16 Feb 2013 10:33:29 -0600
Message-ID: <511FB4D9.7050009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:55369 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab3BPQk1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:40:27 -0500
Received: by mail-qe0-f49.google.com with SMTP id 5so1864001qea.22
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:40:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These changes aren't all that closely related, but they all
are cleanups in the osd client.

					-Alex

[PATCH 1/3] libceph: lock outside send_queued()
[PATCH 2/3] libdeph: don't export ceph_osdc_init() or ceph_osdc_stop()
[PATCH 3/3] libceph: kill ceph_calc_raw_layout()
