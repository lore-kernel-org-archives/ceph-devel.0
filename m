From: Elita Lobo <loboelita@gmail.com>
Subject: Detect memory leaks in ceph
Date: Wed, 28 Sep 2016 10:51:17 +0530
Message-ID: <CAA8xDw295OV5LoR4wwGixofoNmrTfgOsjbpw1RzyKMGRmqk=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:32974 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbcI1FVT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 01:21:19 -0400
Received: by mail-ua0-f173.google.com with SMTP id i25so28885700uab.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2016 22:21:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I am using ceph for a research project and was trying to implement a
new jerasure plugin. The code works perfectly when I try to put small
objects ( 16Mb files) in a single pg but breaks when I am trying to
put some really large object in a cluster having multiple pgs. I am
pretty sure its a memory leak but not sure how to detect it.

Can someone please suggest some tools that would help me  detect
memory leaks in ceph?

Thanking you,
Yours sincerely,
Elita Lobo
