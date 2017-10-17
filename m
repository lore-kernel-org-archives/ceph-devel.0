From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Wish list : automatic rebuild with hot swap osd ?
Date: Tue, 17 Oct 2017 23:06:47 +0200
Message-ID: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:59548 "EHLO smtp0.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760712AbdJQVNa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Oct 2017 17:13:30 -0400
Content-Language: fr-CH
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I wonder if it's possible to add to ceph the ability to rebuild a new disk automatically freshly added to a slot in replacement of a failed osd
disk.

I imagine something like adding a flag on disks (identified by-path for example or a way to have a deterministic access to the device) to be
auto-reconfigured if detected with no data after the same slot was marked as failed. Only disks identified "by-path" with an auto-rebuild flag
activated, and previously marked as failed, can run the auto-reconfiguration.

I know it should take some time to find the best way to implement that feature to avoid zapping a disk with data but that would be great to
improve maintainability.

Thanks,

-- 
Yoann Moulin
EPFL IC-IT
