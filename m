From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/4] rbd: add warnings
Date: Thu, 03 Jan 2013 13:10:33 -0600
Message-ID: <50E5D7A9.6040101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63102 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab3ACTKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:10:36 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so18980549ieb.31
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:10:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series adds a compact way of generating standardized
warning messages in rbd, and then adds some code to issue
warnings in a few spots.

					-Alex

[PATCH REPOST 1/4] rbd: define and use rbd_warn()
[PATCH REPOST 2/4] rbd: add warning messages for missing arguments
[PATCH REPOST 3/4] rbd: add a warning in bio_chain_clone_range()
[PATCH REPOST 4/4] rbd: add warnings to rbd_dev_probe_update_spec()
