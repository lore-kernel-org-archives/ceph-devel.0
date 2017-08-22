From: kefu chai <tchaikov@gmail.com>
Subject: needs-backport label on github/ceph/ceph
Date: Tue, 22 Aug 2017 23:09:18 +0800
Message-ID: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36451 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdHVPJT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 11:09:19 -0400
Received: by mail-oi0-f48.google.com with SMTP id g131so188637464oic.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 08:09:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

i noticed that we have a new label named "needs-backport" [0]? could
you shed some light on how we are supposed to use it? i thought we
were going to cherry-pick all PRs with this label merged after the
luminous was forked. but seems we are still marking PRs should be
included by luminous with the "luminous" milestone. so i have no clues
now =(


cheers,

---
[0] https://github.com/ceph/ceph/pulls?q=label%3Aneeds-backport
