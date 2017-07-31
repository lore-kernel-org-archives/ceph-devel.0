From: qi Shi <m13913886148@gmail.com>
Subject: What's the difference between pg incomplete and pg inconsistent ?
Date: Mon, 31 Jul 2017 17:39:31 +0800
Message-ID: <CAN=xyVUcJUiTG8UnOS_bPiw1MProWROCNc4hKAqwEctFn5DgFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:38242 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdGaJjc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 05:39:32 -0400
Received: by mail-it0-f47.google.com with SMTP id h199so122369414ith.1
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jul 2017 02:39:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, "Ma, Jianpeng" <jianpeng.ma@intel.com>, Kefu Chai <tchaikov@gmail.com>

1, What causes pg incomplete ?
Is it because pg failed to select the authoritative log?

2, What causes pg inconsistent ?
When pg status is inconsistent, why don't peering but inconsistent ?

3, What's the difference between pg incomplete and pg inconsistent ?

Can you analyze it from pg state machine?


thanks !
