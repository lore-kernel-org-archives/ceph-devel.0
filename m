From: Samuel Just <sjust@redhat.com>
Subject: wip-enc-dec
Date: Thu, 18 Aug 2016 09:43:10 -0700
Message-ID: <CAN=+7FW+csmLcFGUPNabFMwvHHy0HWKWhX+bMzpa8_cYiCjSxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36114 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbcHSBS6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Aug 2016 21:18:58 -0400
Received: by mail-qt0-f172.google.com with SMTP id 52so4915711qtq.3
        for <ceph-devel@vger.kernel.org>; Thu, 18 Aug 2016 18:18:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Samuels, Allen" <allen.samuels@sandisk.com>, "Kari, Varada" <varada.kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Is there a reason not to put this new machinery directly into
encoding.h?  The new machinery seems to be sufficient to implement the
existing ::encode and ::decode types and should be compatible, right?
With the containers, we can use template trickery to also forward the
new functions when present in the mapped types.  That would let us
gradually adapt the code base.
-Sam
