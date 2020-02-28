From: Jeff Layton <jlayton@kernel.org>
Subject: unsafe list walking in __kick_flushing_caps?
Date: Fri, 28 Feb 2020 16:39:55 -0500
Message-ID: <4a4d32dc5c4a44cca4ed31bb66d9cfcb0b1092c7.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgB1VkC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:40:02 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ilya Dryomov <idryomov@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Zheng,

I've been going over the cap handling code, and noticed some sketchy
looking locking in __kick_flushing_caps that was added by this patch:


commit e4500b5e35c213e0f97be7cb69328c0877203a79
Author: Yan, Zheng <zyan@redhat.com>
Date:   Wed Jul 6 11:12:56 2016 +0800

    ceph: use list instead of rbtree to track cap flushes
    
    We don't have requirement of searching cap flush by TID. In most cases,
    we just need to know TID of the oldest cap flush. List is ideal for this
    usage.
    
    Signed-off-by: Yan, Zheng <zyan@redhat.com>

While walking ci->i_cap_flush_list, __kick_flushing_caps drops and
reacquires the i_ceph_lock on each iteration. It looks like
__kick_flushing_caps could (e.g.) race with a reply from the MDS that
removes the entry from the list. Is there something that prevents that
that I'm not seeing?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
