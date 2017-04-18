From: John Spray <jspray@redhat.com>
Subject: Smarter blacklisting?
Date: Tue, 18 Apr 2017 17:37:11 +0100
Message-ID: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38303 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbdDRQhd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Apr 2017 12:37:33 -0400
Received: by mail-wm0-f48.google.com with SMTP id r190so1881528wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 09:37:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Currently, when we add an address to the blacklist, we leave it in
there for a set period of time (24 minutes by default, which I suspect
might have been meant to be 24 hours), and then expire it.

Clearly there are two problems with that:
 * We leave things in the list for much longer than necessary most of
the time, when a blacklisted client/node comes back reasonably soon
after a restart
 * We are never 100% guaranteed that a long-halted client won't come
back after its blacklist entry has expired (e.g. a paused VM with
dirty pages, wakes up a day later and writes back to OSDs).

These mostly haven't been too much trouble in practice, but we may be
(optionally) doing a lot more blacklisting on cephfs systems soon[1],
and cephfs clients are perhaps more likely to be VMs than RBD hosts.

One thought is to have an alternative type of backlist entry that does
not have an expiration, but instead is automatically removed when we
see a client authenticate with the same auth id, from the same IP
address as the blacklist entry, but with a different nonce.

Flushing out any blacklist entries from a host that never came back
would be an administrative operation, or we could do it automatically
on a *super* long expiration time (like a month), and in other cases
like if the auth identity associated with the blacklist entry was
removed.

Any thoughts?

John

1. https://github.com/ceph/ceph/pull/14610
