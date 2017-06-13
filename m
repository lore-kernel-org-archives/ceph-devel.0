From: Z Will <zhao6305@gmail.com>
Subject: ceph durability calculation and test method
Date: Tue, 13 Jun 2017 17:37:57 +0800
Message-ID: <CAGOEmcMq7yo=5FVjsQKzk1TqMH-hPiL-Eu01q9kKC17G==sCDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34053 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdFMJh7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 05:37:59 -0400
Received: by mail-io0-f171.google.com with SMTP id i7so69949783ioe.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 02:37:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hi all :
     I have some questions about the durability of ceph.  I am trying
to mesure the durability of ceph .I konw it should be related with
host and disk failing probability, failing detection time, when to
trigger the recover and the recovery time .  I use it with multiple
replication, say k replication. If I have N hosts, R racks, O osds per
host, ignoring the swich, how should I define the failure probability
of disk and host ? I think they should be independent, and should be
time-dependent . I google it , but find little thing about it . I see
AWS says it delivers 99.999999999% durability. How this is claimed ?
And  can I design some test method to prove the durability ? Or just
let it run long enough time and make the statistics ?
