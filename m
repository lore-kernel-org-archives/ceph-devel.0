From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0]  rbd: layered writes
Date: Fri, 19 Apr 2013 17:46:59 -0500
Message-ID: <5171C963.2050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:39053 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933977Ab3DSWrC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 18:47:02 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so2631908iag.14
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 15:47:01 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ie7sm4968564igb.1.2013.04.19.15.47.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 15:47:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This set of patches culminates in providing layered
write functionality for rbd clone images.  Until the
feature bits get enabled, most of this code is not
yet activated.  But it has been tested and it's
ready for review.  The feature will be enabled soon,
after a few more things get cleaned up to prepare
for it.

					-Alex

[PATCH] libceph: fix two messenger bugs
    Two bugs, two improvements.

[PATCH] libceph: support pages for class request data
    This just defines a function that allows a page array
    to be specified for the data to be written by an
    object class method.

[PATCH 1/4] rbd: define separate read and write format funcs
[PATCH 2/4] rbd: encapsulate submission of image object requests
[PATCH 3/4] rbd: define zero_pages()
[PATCH 4/4] rbd: support page array image requests
    The first two of these are just cleanups.  The second two
    add some functionality to allow image requests to use
    page arrays for their object data.

[PATCH 1/2] rbd: implement full object parent reads
[PATCH 2/2] rbd: issue a copyup for layered writes
    These last two finally implement the layered copyup
    functionality.  The first is sort of a half step, to
    break up the review into smaller pieces.
