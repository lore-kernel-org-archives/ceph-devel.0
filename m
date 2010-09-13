From: Mag Gam <magawake@gmail.com>
Subject: Questions about ceph
Date: Mon, 13 Sep 2010 07:16:33 -0400
Message-ID: <AANLkTi=3RgYs8yE6Q+yPjEEsMvX5Bt-x9qK__WzMs_JW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38076 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0IMLQj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Sep 2010 07:16:39 -0400
Received: by gwj17 with SMTP id 17so1983488gwj.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Sep 2010 04:16:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

Do ceph clients need fuse module? or is the file system provided
natively thru the ceph module? Is the filesystem POSIX compliant? For
the underlying filesystem does it have to be BRTFS? We are a heavy XFS
and ext2 shop for performance.
We are very excited about this filesystem and we would like to start
using it and start contributing by benchmarking it and submitted any
bug reports to stabilize it for distributions.
