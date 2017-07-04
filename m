From: Z Will <zhao6305@gmail.com>
Subject: ceph-mon leader election problem, should it be improved ?
Date: Tue, 4 Jul 2017 13:57:23 +0800
Message-ID: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36935 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdGDF5Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jul 2017 01:57:25 -0400
Received: by mail-it0-f51.google.com with SMTP id m84so66426348ita.0
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jul 2017 22:57:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Ceph Users <ceph-users@lists.ceph.com>, Sage Weil <sage@newdream.net>

Hi:
   I am testing ceph-mon brain split . I have read the code . If I
understand it right , I know it won't be brain split. But I think
there is still another problem. My ceph version is 0.94.10. And here
is my test detail :

3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
mon , and use iptables to block the communication between mon 0 and
mon 1. When the cluster is stable, start mon.1 .  I found the 3
monitors will all can not work well. They are all trying to call  new
leader  election . This means the cluster can't work anymore.

Here is my analysis. Because mon will always respond to leader
election message, so , in my test, communication between  mon.0 and
mon.1 is blocked , so mon.1 will always try to be leader, because it
will always see mon.2, and it should win over mon.2. Mon.0 should
always win over mon.2. But mon.2 will always responsd to the election
message issued by mon.1, so this loop will never end. Am I right ?

This should be a problem? Or is it  was just designed like this , and
should be handled by human ?
