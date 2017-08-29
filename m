From: John Spray <jspray@redhat.com>
Subject: Commit messages + labels for mgr modules
Date: Tue, 29 Aug 2017 14:42:55 +0100
Message-ID: <CALe9h7fWg=E9napbLAQMBefOHZsbnBvzP16f-M72P469we4NDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:32974 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdH2NnR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 09:43:17 -0400
Received: by mail-wr0-f177.google.com with SMTP id k94so10377280wrc.0
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 06:43:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

mgr modules live in src/pybind/mgr/<module>, so we've had sort of a
mixture of styles in commit messages like "mgr: ", "mgr/<module>",
"pybind:", etc.

I'd like to standardize on "mgr/<module>:", even though it doesn't
strictly match the source code path.  Also, to always use the "mgr"
label rather than the pybind one.  Sound okay?

I guess we could also move the modules into mgr/modules or something
instead of pybind, but I think in that case I would still want to use
mgr/<module> to be nice and terse.

John
