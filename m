From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Additional backport labels and process improvements
Date: Thu, 2 Nov 2017 09:16:02 -0700
Message-ID: <CAKPXa=Z3aXdwRz9OAniOLEpWkLtGUJHyLCTvm2y+n9u8PKXy7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:56678 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932971AbdKBQQE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 12:16:04 -0400
Received: by mail-ot0-f174.google.com with SMTP id i19so23183ote.13
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 09:16:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

When adding a important code or test fix to the master branch we have
'needs-backport' label,   can we add more labels that indicate what
branch it needs to be backported as well eg "needs-jewel-backport" ,
"needs-luminous-backport"

I have personally missed couple of test backports back to branches and
added labels would help query results right from the github interface
and make it easier for anyone to check if there are important
backports missing.

Also I am +1 on NOT creating a new tracker for every backport, this
seems redundant work, the original tracker can still be used with few
additional fields to indicate "fixed in master", "fixed in jewel" etc.

Thanks
