From: Muminul Islam Russell <misla011@fiu.edu>
Subject: Upgrading from firefly to Jewel
Date: Thu, 6 Oct 2016 12:04:31 -0700
Message-ID: <CAK=B8yZ_v8KONH1t6hbQbXtsuaizdRW=bq+WrJ+EM72wdPSHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33106 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933727AbcJFTEd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 15:04:33 -0400
Received: by mail-ua0-f172.google.com with SMTP id p102so26520328uap.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 12:04:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello cephers,

I know that upgrading from firefly to jewel is not recommended but I
wanted to give a try for my small cluster. I got it done with some
down time but failed with object gateway part.

Can anyone advise me if radosgw upgrade is possible from firefly to
jewel considering a lot of architectural changes between this two
LTS.?

Thanks,
Muminul
