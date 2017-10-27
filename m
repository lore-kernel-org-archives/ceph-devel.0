From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: some issue about peering progress
Date: Fri, 27 Oct 2017 15:45:36 +0800
Message-ID: <CANE=7sWZ9sBTdqbNZ_UuUZ=K5UJDB=kZbrXh3u09dNaGeUzXRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:44241 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdJ0Hph (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Oct 2017 03:45:37 -0400
Received: by mail-pf0-f174.google.com with SMTP id x7so4391917pfa.1
        for <ceph-devel@vger.kernel.org>; Fri, 27 Oct 2017 00:45:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

     I confuse about the notify message during peering. Such as:

    epoch 1, primary osd do Pering , GetInfo and GetMissing, it
calling the func  proc_replica_log. in this func the last_complete and
last_update maybe reset.

    Before go to Activate. the OSDMap change (the new osdmap do not
lead to restart peering), the non-primary osd send the notify to
primary.

    When the primary receive the notify, Primary::react(const
MNotifyRec& notevt), so it call the func proc_replica_info.

    In the func, we update the pg info including last_complete and
last_update which modified in proc_replica_log.

    When the primary call the func activate, the primary osd  process
recovering based on pg info got by notify instead of proc_replica_log.

    so it is a bug?

-- 
Regards,
Xinze Chi
