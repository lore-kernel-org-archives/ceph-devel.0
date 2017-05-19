From: sheng qiu <herbert1984106@gmail.com>
Subject: rbd-nbd performance
Date: Fri, 19 May 2017 11:46:14 -0700
Message-ID: <CAB7xdimrZjvjOjTvoY7WrKB4AweDrQ1T6=YYY3QuPSGx0pbdWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34779 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755418AbdESSqQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 14:46:16 -0400
Received: by mail-ua0-f173.google.com with SMTP id u10so31101330uaf.1
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 11:46:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, j.huo@alibaba-inc.com, james.liu@alibaba-inc.com, ming.lin@alibaba-inc.com, sheng.qiu@alibaba-inc.com

Hi,

currently we are evaluating the performance of rbd-nbd module.
we found that the performance is much lower (only half) than directly
using rbd when there are multiple clients (fio jobs>=16).

we tried adding multi-connections support on rbd-nbd with newest nbd
driver, so that the nbd driver can create multiple io queues, and each
io queue is associated with one socket connection to talk to rbd-nbd
for request sending and response receiving.

however, this doesn't give us expected performance gain (~5%-10%). it
still has obvious gap with directly using rbd. We did a little hack by
responding the nbd device with success at rbd-nbd layer without
forwarding to ceph cluster. this gives us a hint about the overhead of
nbd device communications with rbd-nbd module, the latency is around
30us for single IO queue depth.

so we are considering if the nbd device import very little overhead,
and it's scalable locally, then what's the main issue stopping the
scalability of rbd-nbd sending requests to ceph cluster?

if anyone can give us a hint, it would much appreciated.

Thanks,
Sheng
