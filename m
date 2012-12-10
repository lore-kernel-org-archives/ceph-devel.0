From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: four bug fixes
Date: Sun, 09 Dec 2012 18:33:41 -0600
Message-ID: <50C52DE5.9070602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56629 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2LJAlq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 19:41:46 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so6753044iec.41
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 16:41:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series includes two bug fixes that fix confirmed problems, and
two other changes that are technically fix bugs but which probably
won't cause any trouble.

					-Alex

[PATCH 1/6] libceph: avoid using freed osd in __kick_osd_requests()
[PATCH 2/6] libceph: register request before unregister linger
[PATCH 3/6] libceph: socket can close in any connection state
[PATCH 4/6] libceph: init osd->o_node in create_osd()
