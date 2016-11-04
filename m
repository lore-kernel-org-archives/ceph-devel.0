From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph-disk and /dev/dm-* permissions - race condition?
Date: Fri, 4 Nov 2016 10:51:45 -0400
Message-ID: <CAGbviv+bFfR=oC=XhYKB7zQBce3Ph59GALnhoKS_0e71z649mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34529 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934593AbcKDOvr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2016 10:51:47 -0400
Received: by mail-yw0-f177.google.com with SMTP id t125so89124783ywc.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2016 07:51:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

We are running 10.2.3 with encrypted OSDs and journals using the old
(i.e. non-Luks) keys and are seeing issues with the ceph-osd processes
after a reboot of a storage server.  Our data and journals are on
separate partitions on the same disk.

After a reboot, sometimes the OSDs fail to start because of
permissions problems.  The /dev/dm-* devices come back with
permissions set to "root:disk" sometimes instead of "ceph:ceph".
Weirder still is that sometimes the ceph-osd will start and work in
spite of the incorrect perrmissions (root:disk) and other times they
will fail and the logs show permissions errors when trying to access
the journals. Sometimes half of the /dev/dm- devices are "root:disk"
and others are "ceph:ceph".  There's no clear pattern, so that's what
leads me to think its a race condition in the ceph_disk "dmcrypt_map"
function.

Is there a known issue with ceph-disk and/or ceph-osd related to
timing of the encrypted devices being setup and the permissions
getting changed to the ceph processes can access them?

Wyllys Ingersoll
Keeper Technology, LLC
