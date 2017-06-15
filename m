From: John Spray <jspray@redhat.com>
Subject: Cluster log: hiding cluster map prints, decreasing audit log messages
Date: Thu, 15 Jun 2017 15:12:45 -0400
Message-ID: <CALe9h7cVUB-H8aeXGRFPFOeTe+nFyMZ=Obmqr4P527gmR7268A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38441 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdFOTNH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 15:13:07 -0400
Received: by mail-wm0-f44.google.com with SMTP id n195so7119336wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 12:13:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Some musings from me about the cluster log, interested in others' thoughts.

Audit log
=======

The audit logging is nice, but it has a couple of noticeable annoyances:
 - it crowds out real health messages, e.g. when using the new "log
last" command you may see mostly see audit log messages, especially if
a monitoring tool is polling some commands.
 - the messages themselves are ugly JSON dumps

We already have a separate channel for these, so it's easy for UIs to
split out the audit stuff (I just did this in the dashboad module),
but I think they're still consuming some number of the lines when we
fetch a set number of lines using "log last".

Maybe things like log last (and the internal buffering in the mon)
should keep N lines for each channel, rather than channels competing
for the space?  It might already be like that on some level, haven't
dug into the mon internals yet.

Cluster maps
===========

It is very nice for debugging that we can see updates to osdmap/fsmap
ticking by as the mon updates the state of the system.  However, it
kind of disrupts our ability to output clearly readable log messages
for ordinary users when things changed.

Maybe the cluster maps should be on a separate channel, like the audit logs are?

Of course, when we're hiding the low level cluster map prints away, we
need to at the same time make sure we're adding in the right high
level "OSD 123 went down" messages to replace where the "osdmap e456
..." lines currently give you the hint that something happened.


Cheers,
John
