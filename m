From: Z Will <zhao6305@gmail.com>
Subject: should I use rocdsdb ?
Date: Fri, 2 Jun 2017 16:24:39 +0800
Message-ID: <CAGOEmcOu6MQtCCN1QEjkn1_o+kpyF+OUzk5jrKYVOsbGZ7nv5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35709 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdFBIZy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 04:25:54 -0400
Received: by mail-it0-f41.google.com with SMTP id m62so88412itc.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jun 2017 01:25:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@redhat.com, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

Hello gurus:
    My name is will . I have just study ceph and have a lot of
interest in it . We are using ceph 0.94.10. And I am tring to tune the
performance of ceph to satisfy our requirements. We are using it as
object store now. Even though I have tried some different
configuration.   But I still have  some questions about it .
    I wonder how much impact the performance of the omap kv database
have on cluster ?  Can I have some way to measure it ?

    I know rocksdb performs better than leveldb on fast device like
ssd . So I wonder If I put bucket index on ssd, and change the omap
kvdb to rocksdb . Will the performance be improved ? Has anyone tried
this ?

    Or I still use filestore . But I use EnhanceIO + ssd as filesystem
cache tier. And change the omap kv to rocksdb of all osds, will the
cluster performance be improved  ?  Has anyone tried this ?
