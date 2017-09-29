From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: ec overwrite issue
Date: Fri, 29 Sep 2017 18:02:17 +0800
Message-ID: <CANE=7sUPY=qoJSpprXc5QHo+3eiUbK=Qjp9MAE7Oze33Kg-sQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:44523 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdI2KCT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2017 06:02:19 -0400
Received: by mail-pf0-f175.google.com with SMTP id e1so528698pfk.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 03:02:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all

    I confuse the roll_forward logic in the PG::append_log. The
pg_log.roll_forward func may roll forward the all inflight
transactions which maybe not be completed by all shards.

    The comment also makes me wonder. so could anyone explain it in
detail. thanks.


  if (!transaction_applied) {
     /* We must be a backfill peer, so it's ok if we apply
      * out-of-turn since we won't be considered when
      * determining a min possible last_update.
      */
    pg_log.roll_forward(&handler);
  }

    /* We don't want to leave the rollforward artifacts around
     * here past last_backfill.  It's ok for the same reason as
     * above */
    if (transaction_applied &&
       p->soid > info.last_backfill) {
      pg_log.roll_forward(&handler);
    }

-- 
Regards,
Xinze Chi
