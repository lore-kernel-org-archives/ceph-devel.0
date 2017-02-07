From: Elita Lobo <loboelita@gmail.com>
Subject: Fwd: Disable Load balancing in ceph during repair
Date: Tue, 7 Feb 2017 19:10:25 +0530
Message-ID: <CAA8xDw3W8ujm3XZ=MxzPkDkx0OGmPRyLq5rZ+srQtDd-MHRvFQ@mail.gmail.com>
References: <CAA8xDw1g2-__B5riz9KXLJvGMtvP_Ykg9_rs_CrhAsFcwf-ymw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34210 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbdBGNk1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 08:40:27 -0500
Received: by mail-ua0-f179.google.com with SMTP id 35so84556294uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 05:40:26 -0800 (PST)
In-Reply-To: <CAA8xDw1g2-__B5riz9KXLJvGMtvP_Ykg9_rs_CrhAsFcwf-ymw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-community@ceph.com

Hi,

Is there a way to disable load balancing in ceph (in multiple pg case)
whenever an osd goes down?
Or can we atleast add a delay before load balancing happens?


I am trying to compute the no of erasures in each pg by using the
command "ceph pg dump" before and after an osd goes down. The
positions of some of the osds get changed due to load balancing.
Hence I am unable to get the correct no of erasures due to load
balancing happening.

Would be grateful if any of the ceph developers could help me figure
out a way to find the no of erasures in each pg.

Yours sincerely,
Elita Lobo
