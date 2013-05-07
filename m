From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/7] rbd: use common code for probe and refresh
Date: Mon, 06 May 2013 20:51:02 -0500
Message-ID: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:49520 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab3EGBvF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:51:05 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so39732veb.39
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:51:04 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id q5sm19485180vdj.5.2013.05.06.18.51.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:51:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is some work I had nearly done a long time ago.  It didn't even
have a bug associated with it.  I resurrected it over the weekend
and ported it to the new code.

It's basically cleanup though.  For format 1 rbd images, when
probing an image, header information for it is read in and
translated directly into the rbd_dev->header structure.

For an image refresh, instead, we use a stack structure to
hold the translated header, and then in a second step we
copy that into rbd_dev->header.

This series gets rid of the local variable, and always just
puts things directly into rbd_dev->header.  It also simplifies
probe and refresh for both format 1 and format 2, using a
common rbd_dev_vX_header_info() function for both purposes.

This set of patches, as well as the two single patches
and series of six I just posted, are available in the
"review/wip-rbd-cleanup-1" branch of the ceph-client git
repository.

					-Alex

[PATCH 1/7] rbd: set the mapping size and features later
[PATCH 2/7] rbd: zero format 1 header structure earlier
[PATCH 3/7] rbd: refactor rbd_header_from_disk()
[PATCH 4/7] rbd: update in-core header directly
[PATCH 5/7] rbd: simplify rbd_dev_v1_probe()
[PATCH 6/7] rbd: get rid of trivial v1 header wrappers
[PATCH 7/7] rbd: define rbd_dev_v1_header_info()

