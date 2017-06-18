From: Brad Hubbard <bhubbard@redhat.com>
Subject: Pecan dependency
Date: Mon, 19 Jun 2017 08:37:34 +1000
Message-ID: <CAF-wwdGBn4i=-jD7qKJAhmCL8_fEXiMNgc+z=9+4gj2FwA7RFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35148 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbdFRWhl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jun 2017 18:37:41 -0400
Received: by mail-pg0-f41.google.com with SMTP id 132so6795852pgb.2
        for <ceph-devel@vger.kernel.org>; Sun, 18 Jun 2017 15:37:41 -0700 (PDT)
Received: from rskikr.localdomain ([66.187.239.16])
        by smtp.gmail.com with ESMTPSA id r83sm16611370pfk.57.2017.06.18.15.37.38
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Jun 2017 15:37:39 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/20322 is caused by an unsatisfied pecan
dependency for the MGR restful module. Given the error message is rather cryptic
and not immediately relatable to a missing pecan module we should address this
in some way, shape, or fashion.

Willem reported this issue here,
https://www.spinics.net/lists/ceph-devel/msg37057.html and submitted a PR which
resolves the issue for FreeBSD by installing pecan with pip.

There are several approaches we could take, most of which provided by John Spray
in the tracker.

1. Make pecan a required dependency for ceph.

2. Test for the availability of the module in vstart and warn if it is not
available and/or disable the restful module parts.

3. Make the restful parts configurable within vstart and *disable* them by
default.

Which way would we like to jump?

-- 
Cheers,
Brad
