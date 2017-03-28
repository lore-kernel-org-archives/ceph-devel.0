From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: some question about ceph qa case
Date: Tue, 28 Mar 2017 17:14:00 +0800
Message-ID: <CANE=7sUCuyDjq61wPZsEGt_XcpTHv96L-aUpsdUoy_vcJBYx4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34142 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755006AbdC1JWm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Mar 2017 05:22:42 -0400
Received: by mail-oi0-f51.google.com with SMTP id o67so25934171oib.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Mar 2017 02:22:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

     Recently, I read some qa case.  I confuse about pg move case.

     In teuthology log, I see the log "Moving pg 1.3 from osd.1 to
osd.5". In this case, maybe the lastest data is in osd.1. After move
the pg to osd.5, the lastest data is in osd.5.

     But in peering process, we get pg info from osd.1 instead of
osd.5 base on osdmap. It would be wrong, right? Do I ignore some
important info?

     Could anyone explain the pg move case in detail?

-- 
Regards,
Xinze Chi
