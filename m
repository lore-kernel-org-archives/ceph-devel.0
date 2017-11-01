From: John Spray <jspray@redhat.com>
Subject: Does anything still use the separate ceph-qa-suite repo?
Date: Wed, 1 Nov 2017 22:56:53 +0000
Message-ID: <CALe9h7c+dYCK4uX4gEoEvRmWY=gjMe+gVx7KtSiwhCDKeiSHLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:49238 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbdKAW5P (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 18:57:15 -0400
Received: by mail-wr0-f181.google.com with SMTP id g90so3308897wrd.6
        for <ceph-devel@vger.kernel.org>; Wed, 01 Nov 2017 15:57:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I think all the old stable branches got their own merge into the
ceph.git qa/ directory, so is there anything out there that would
still want the separate repo at https://github.com/ceph/ceph-qa-suite
?

If not, it seems like it's been long enough to just go ahead and
remove this entirely now?  The value of keeping it around for
archaeology is probably less than the cost of it occasionally
confusing folks.

John
