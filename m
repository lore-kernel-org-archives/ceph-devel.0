From: John Spray <jspray@redhat.com>
Subject: RADOS: Deleting all objects in a namespace
Date: Tue, 23 May 2017 14:09:27 +0100
Message-ID: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34944 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762917AbdEWNJu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 09:09:50 -0400
Received: by mail-wm0-f43.google.com with SMTP id b84so24135644wmh.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 06:09:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Soon, we'll probably be letting multiple CephFS filesystems use the
same data and metadata pools, where the filesystems are separated by
rados namespace.

When removing filesystems, in the interests of robustness and speed,
I'd like to be able to delete all objects in a namespace -- otherwise
we would have to rely on a "rm -rf" and then some new code to
explicitly enumerate and delete all metadata objects for that
filesystem.

I'm pondering whether this should just be a process that happens via
normal client interfaces (where mon/mgr would be the client), or
whether it would be feasible/desirable to implement something inside
the OSD.  Obviously the OSD ultimately has to do the same underlying
enumeration, but at least it doesn't have to thrash through the whole
request/response cycle for deleting each object individually -- might
enable it to throttle internally in the OSD based on how busy it knows
itself to be, rather than having the client apply some arbitrary "only
issue N deletions at once" type limit that might make the deletion
process unecessarily slow.

I have a feeling we must have talked about this at some point but my
memory is failing me...

John
