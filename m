From: John Spray <jspray@redhat.com>
Subject: "Inherit members" on redmine subprojects
Date: Mon, 20 Nov 2017 12:36:33 +0000
Message-ID: <CALe9h7ffKQ9C86ovTh3oGwQgAVSo93u8fD_OwJ8YvgAUD83auw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:42800 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdKTMgy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Nov 2017 07:36:54 -0500
Received: by mail-wm0-f47.google.com with SMTP id 5so17358678wmk.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Nov 2017 04:36:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I just noticed that redmine has this option to have subprojects
inherit their permissions from the parent project.  It seems like a
sensible idea that if some has a role on the toplevel "Ceph" project
they'd have access to the subprojects too -- anybody remember a
historical reason we don't have this box ticked for most of the
subprojects?

John
