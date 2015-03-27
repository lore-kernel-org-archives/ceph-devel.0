From: Ning Yao <zay11022@gmail.com>
Subject: RBD Discard issue for Cache_tier
Date: Fri, 27 Mar 2015 17:28:23 +0800
Message-ID: <CALZt5jwGf2BADGSRYJY-9MB5pWHSKFOpWdjXZAZroWbwAuO+Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36211 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbC0J2Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 05:28:24 -0400
Received: by wgra20 with SMTP id a20so92404022wgr.3
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2015 02:28:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I use the kernel rbd with kernel 3.18 and open the discard option.
When I use the cache tier mode, the performance is ruined by
CEPH_OSD_OP_DELETE.

Since some one may delete a large file which is rarely used, the file
is always not in the Cache pool. So it will promote the object first
from the cold pool and then replace the object with an empty object.
After the empty object is flushed and evicted, the content is
eventually deleted.

But a large file causes lots of object promotion so that the Cache
pool's bandwidth is saturated. We might not need to promote a delete
the object when Calling can_skip_promote() and send a
CEPH_OSD_OP_DELETE op to cold pool from the Objecter interface, which
would be much better when deleting file occurs. Is that possible?

Regards
Ning Yao
