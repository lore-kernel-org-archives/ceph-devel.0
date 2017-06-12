From: kefu chai <tchaikov@gmail.com>
Subject: constantly test failure in cephtool-test-mon.sh on jenkins
Date: Mon, 12 Jun 2017 20:42:49 +0800
Message-ID: <CAJE9aONqqunQU3L611wEgWWJnVH3M2n2PrQ6U4JG2urrQu2LKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35612 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbdFLMmv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 08:42:51 -0400
Received: by mail-vk0-f51.google.com with SMTP id 191so47307904vko.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 05:42:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi cephers,

as you might have already noticed. cephtool-test-mon.sh constantly
fails on jenkins. it's a known issue and is being tracked at
http://tracker.ceph.com/issues/20249.

so, if you have PR whose "make check" is red even after re-triggering
the job couple times, don't panic. it's very likely not your fault =)


-- 
Regards
Kefu Chai
