From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] rbd: cleanup and plug leaks
Date: Fri, 26 Apr 2013 07:04:09 -0500
Message-ID: <517A6D39.80000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:49944 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab3DZMEK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 08:04:10 -0400
Received: by mail-ia0-f174.google.com with SMTP id h23so3551694iae.5
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 05:04:10 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id dy5sm2862038igc.1.2013.04.26.05.04.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 05:04:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(This series, and the patch I just posted, are available
in the "review/wip-rbd-cleanup" branch of the ceph-client
git repository.)

This series is one of several I expect to be posting that
are mostly small tweaks and polish to the rbd code.  I'm
doing a review of the whole thing with an eye toward
verifying error paths and finding memory leaks.  Along
the way I'm making small changes to improve overall
consistency and perhaps shore up some coding style issues.

					-Alex

[PATCH 1/6] rbd: fix leak of snapshots during initial probe
[PATCH 2/6] rbd: make snap_size order parameter optional
[PATCH 3/6] rbd: only update values on snap_info success
[PATCH 4/6] rbd: rename __rbd_add_snap_dev()
[PATCH 5/6] rbd: fix leak of format 2 snapshot names
[PATCH 6/6] rbd: use rbd_obj_method_sync() return value
