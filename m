From: zengran zhang <z13121369189@gmail.com>
Subject: crush problem in EC environment
Date: Wed, 10 May 2017 18:29:16 +0800
Message-ID: <CALi+v19s-0XZpteLX_6_HNjUTzsKLiFbvtaZFkjjm80yuuUk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35358 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdEJK3S (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 06:29:18 -0400
Received: by mail-it0-f46.google.com with SMTP id c15so21774785ith.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 03:29:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi cephers:
    recently,we found some pgs incomplete in our bluestore+ec
overwrite environment, we think it
is because the pg's acting set size below the min_size when some osd
failure out. we wonder know how to reslove the crush problem in EC
environment. thanks!

PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES
LOG  DISK_LOG STATE      STATE_STAMP                VERSION   REPORTED
UP                      UP_PRIMARY ACTING
ACTING_PRIMARY LAST_SCRUB SCRUB_STAMP                LAST_DEEP_SCRUB
DEEP_SCRUB_STAMP
4.4c          0                  0        0         0       0     0
0        0 incomplete 2017-05-10 15:51:16.592083       0'0    966:3
[2147483647,6,8,2147483647,1,9]          5
[2147483647,6,8,2147483647,1,9]              5   829'6744 2017-05-10
04:50:07.114874        725'4190 2017-05-06 05:47:25.286826
4.67          0                  0        0         0       0     0
3000     3000 incomplete 2017-05-10 15:51:16.512486  831'5439    966:4
 [6,2147483647,2147483647,5,8,4]          6
[6,2147483647,2147483647,5,8,4]              6   825'5292 2017-05-09
16:53:26.029346        696'5082 2017-05-04 00:28:50.459986

regards!
