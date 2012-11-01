From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: improve warnings
Date: Thu, 01 Nov 2012 10:24:09 -0500
Message-ID: <50929419.6020302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35202 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761860Ab2KAPYM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 11:24:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3721446iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 08:24:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series adds a utility function rbd_warn() that will
provide a central and unified way to generate warning messages
from rbd.  It then fleshes out some warning messages in a
few areas.  There is more to be done, but for now I'm just
getting the mechanism and these initial uses of it in place.

					-Alex

[PATCH 1/4] rbd: define and use rbd_warn()
[PATCH 2/4] rbd: add warning messages for missing arguments
[PATCH 3/4] rbd: add a warning in bio_chain_clone_range()
[PATCH 4/4] rbd: add warnings to rbd_dev_probe_update_spec()
