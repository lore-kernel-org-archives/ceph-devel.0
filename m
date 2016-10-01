From: Ning Yao <zay11022@gmail.com>
Subject: CRUSH algorithm and its debug method
Date: Sat, 1 Oct 2016 14:29:11 +0800
Message-ID: <CALZt5jytLeocqK7TY5MhLbimgiriL8Tr5WQneLSaPK32KP88vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33014 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbcJAG3M (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Oct 2016 02:29:12 -0400
Received: by mail-qk0-f177.google.com with SMTP id n189so52471714qke.0
        for <ceph-devel@vger.kernel.org>; Fri, 30 Sep 2016 23:29:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage

I find that several issues related to current CRUSH algorithm as below:

1. It is possible to select out the same collision and retry bucket in
a crush_choose_firstn() loop. (e.g.  when we set reweight to 0 or mark
osd out, it would be definitely rejected if it is selected. However,
when the second chance to select out another one based on the
different r', it is still possible to select out the same osd
previously rejected, right? And until a different one is selected
after several retries.).  I think we can record those rejected or
collision osds in the same loop so that the process can be converged
much faster?

2. Currently, the reweight params in crushmap is memoryless (e.g we
balance our data by reducing reweight, which will be lost after this
osd DOWN and OUT automatically. And we mark its IN again because
currently ceph osd in directly marks the reweight to 1.0 and out marks
the reweight to 0.0).  It is quite awkward when we use ceph osd
reweight-by-utilization to make data balance (If some osds down and
out, our previous effort is totally lost).   So I think marking osd
"in"  does not simply modify reweight to "1.0". Actually, we can
iteration the previous osdmap and find out the value of the reweight
or records it anywhere we can retrieve this value again?

3. Currently, there is no debug option in the mapping progress in
Mapper.c. dprintk is default disabled so that it will be hard to dig
into the algorithm if something unexpected result happens. I think we
can introduce the debug options and output the debug information when
we use "ceph osd map xxx xxx" so that it is much more easier to find
the shortness in current mapping process?

Regards
Ning Yao
