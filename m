From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: finish up basic format 2 support
Date: Tue, 09 Oct 2012 13:57:09 -0700
Message-ID: <50748FA5.4030508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40371 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab2JIU5M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 16:57:12 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5608193pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 13:57:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series includes updates for two patches posted previously.

					-Alex

[PATCH 1/4] rbd: define rbd_update_size()
     This is a simple addition so a bit of code used by both
     format 1 and 2 can be common rather than duplicated.
[PATCH 2/4, v2] rbd: define rbd_dev_v2_refresh()
     Updated to fetch the image size in addition to the snapshot
     context when refreshing.  The names of some functions no
     longer contain "snapc" to reflect this.
[PATCH 3/4] rbd: implement feature checks
     This ensures that images requiring features not supported
     by the local rbd client software are rejected.
[PATCH 4/4] rbd: activate v2 image support
     Same as before, and trivial.
