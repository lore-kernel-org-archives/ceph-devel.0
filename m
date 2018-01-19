From: Ugis <ugis22@gmail.com>
Subject: ghost degraded objects
Date: Fri, 19 Jan 2018 12:25:03 +0200
Message-ID: <CAE63xUN4+fzJFjEOwKU-gXjqk+=8=gugU97V2xA4fx9oBrwvUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:41793 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbeASKZF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jan 2018 05:25:05 -0500
Received: by mail-it0-f47.google.com with SMTP id b77so1632942itd.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jan 2018 02:25:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Hi,

Running Luminous 12.2.2, noticed strange behavior lately.
When for example setting "ceph osd out X" closer to the reballancing
end "degraded" objects still show up, but in "pgs:" section of ceph -s
no degraded pgs are still recovering, just ramapped and no degraded
pgs can be found in "ceph pg dump"

  health: HEALTH_WARN
            355767/30286841 objects misplaced (1.175%)
            Degraded data redundancy: 28/30286841 objects degraded
(0.000%), 96 pgs unclean

  services:
    ...
    osd: 38 osds: 38 up, 37 in; 96 remapped pgs

  data:
    pools:   19 pools, 4176 pgs
    objects: 9859k objects, 39358 GB
    usage:   114 TB used, 120 TB / 234 TB avail
    pgs:     28/30286841 objects degraded (0.000%)
             355767/30286841 objects misplaced (1.175%)
             4080 active+clean
             81   active+remapped+backfilling
             15   active+remapped+backfill_wait


Where those 28 degraded objects come from?

In such cases usually when backfilling is done degraded objects also
disappear, but normally degraded objects should fix before remapped
ones by priority.

Ugis
