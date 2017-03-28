From: sw zhang <zhangsw1001@gmail.com>
Subject: RGW usage from public and private network
Date: Tue, 28 Mar 2017 11:37:58 +0800
Message-ID: <CAHjSqia7ADAUa+HsD50nzjHUeqqoc-xnDYDO0N14TVj5y97v_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34479 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbdC1DiA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Mar 2017 23:38:00 -0400
Received: by mail-qt0-f179.google.com with SMTP id n21so54415626qta.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Mar 2017 20:37:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda <yehuda@redhat.com>, Casey Bodley <cbodley@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, =?UTF-8?B?6YOt5Y2g5Lic?= <idealguo@gmail.com>

Hi~
  At present usage log doesn't reflect the difference of requests from
public or private network. But it's really useful to separate the two
kinds of requests in a production environment. For example, the cost
of these requests may be different. Any advice about this feature?

Sincerely,

Zhang Shaowen
