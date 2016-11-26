From: John Spray <jspray@redhat.com>
Subject: "exe" ceph-mds processes
Date: Sat, 26 Nov 2016 01:58:02 +0000
Message-ID: <CALe9h7fort-NWax8LUXMB1gGycvUXNundNzdbzVaypcpQWEC6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33565 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbcKZB6Y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Nov 2016 20:58:24 -0500
Received: by mail-qt0-f173.google.com with SMTP id p16so78631716qta.0
        for <ceph-devel@vger.kernel.org>; Fri, 25 Nov 2016 17:58:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>

Since 66a122025 we've respawned MDSs using /proc/self/exe to avoid
issues if argv[0] was no longer there, but I've only just realised
that this leads to the respawned daemons not showing up as "ceph-mds"
in the process list any more, they're just "exe".

I guess we could:
 * Switch the logic to try resolving argv[0] and only use
proc/self/exe if we can't find argv[0]?
 * Create a link to /proc/self/exe named ceph-mds, and exec that?

Any thoughts?

John
