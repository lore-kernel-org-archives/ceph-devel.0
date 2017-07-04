From: han vincent <hangzws@gmail.com>
Subject: Re: ceph-mon leader election problem, should it be improved ?
Date: Tue, 4 Jul 2017 14:35:03 +0800
Message-ID: <CANNfkuaBRZm6P0ejMomTUVy5NF=YBVZ8h8dHabCvxnaeP1bEwA@mail.gmail.com>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35683 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdGDGfE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jul 2017 02:35:04 -0400
Received: by mail-io0-f177.google.com with SMTP id h134so66880998iof.2
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jul 2017 23:35:04 -0700 (PDT)
In-Reply-To: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Will <zhao6305@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Users <ceph-users@lists.ceph.com>, Sage Weil <sage@newdream.net>

I think it is really a bug, and I tested it.
if the network between mon.0 and mon.1 is cut off, it is easy to reproduce.

            mon.0
                      \
                        \
                          \
                           \
mon.1 --------------   mon.2

mon.0 win the election between mon.0 and mon.2, while mon.1 win the
election between mon.1 and mon.2.
the network of mon.0 and mon.1 is cut off, there is no way to elect
the leader monitor.

2017-07-04 13:57 GMT+08:00 Z Will <zhao6305@gmail.com>:
> Hi:
>    I am testing ceph-mon brain split . I have read the code . If I
> understand it right , I know it won't be brain split. But I think
> there is still another problem. My ceph version is 0.94.10. And here
> is my test detail :
>
> 3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
> mon , and use iptables to block the communication between mon 0 and
> mon 1. When the cluster is stable, start mon.1 .  I found the 3
> monitors will all can not work well. They are all trying to call  new
> leader  election . This means the cluster can't work anymore.
>
> Here is my analysis. Because mon will always respond to leader
> election message, so , in my test, communication between  mon.0 and
> mon.1 is blocked , so mon.1 will always try to be leader, because it
> will always see mon.2, and it should win over mon.2. Mon.0 should
> always win over mon.2. But mon.2 will always responsd to the election
> message issued by mon.1, so this loop will never end. Am I right ?
>
> This should be a problem? Or is it  was just designed like this , and
> should be handled by human ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
