From: Ning Yao <zay11022@gmail.com>
Subject: What should we do if ceph feature bit is all used?
Date: Thu, 18 May 2017 14:24:18 +0800
Message-ID: <CALZt5jyPyb8d0maz06LTguhC=++tzdKKY7fJ6DQHLkOS5amzDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37934 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbdERGYT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 02:24:19 -0400
Received: by mail-it0-f41.google.com with SMTP id e65so22360458ita.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 May 2017 23:24:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: onebeiniunai@163.com

Hi, Sage and all Cepher

I find that CEPH_FEATURE bit uses uint64_t and only 64 bits can be
used totally. However, it will be exhausted soon.  What should we do
then? Thanks


Regards
Ning Yao
