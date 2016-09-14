From: Max Yehorov <myehorov@skytap.com>
Subject: librbd diff_iterate question
Date: Wed, 14 Sep 2016 12:13:14 -0700
Message-ID: <CAJDfisk8=HyE-Jf24vphowjeuJggcgRNu_O1eLpTLiEYO5-LkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38792 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756189AbcINTNq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Sep 2016 15:13:46 -0400
Received: by mail-wm0-f48.google.com with SMTP id 1so50012274wmz.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 12:13:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

according to code comments: diff_iterate2 returns the differences
between two versions of an image via a callback, which gets the offset
and length and a flag indicating whether the extent exists.

Now, there are two code paths to calculate diff, one that uses
fast-diff/obj-map and the other which asks osds. It appears that only
fast-diff code path can set "exists" flag to false in the
diff_iterate's callback. Is that the correct assumtion?

thanks!
