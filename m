From: John Spray <jspray@redhat.com>
Subject: blacklisting etc
Date: Wed, 22 Feb 2017 10:57:28 +0000
Message-ID: <CALe9h7c8YtA3YPUkwtOQzvqu-DTQpFXAHxvjUOdd-Ywx_9ccNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33193 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbdBVK5u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2017 05:57:50 -0500
Received: by mail-wm0-f48.google.com with SMTP id t18so34411813wmt.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2017 02:57:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I meant to mention yesterday, I have a branch with the
mds-obeys-blacklist behaviour here:
https://github.com/jcsp/ceph/tree/wip-17980

For the other side (blacklisting clients from the MDS), I also
remembered that we currently we have a precedent for special-casing an
mds->OSDMonitor operation, in the form of the MRemoveSnaps message.

I think the options we currently have for blacklisting clients from the MDS are:
 A) Add a new MBlacklist message a la MRemoveSnaps
 B) Send a MMonCommand and special case the auth on the mon side to
allow any mds.* entity to run "osd blacklist add" without needing the
usual caps
 C) Send a MMonCommand and ask users/scripts setting up Ceph to
explicitly include the mon cap to run the blacklist command.
 D) Piggy-back a list of clients to evict on MMDSBeacon, where the MDS
daemon would trim that list once it saw that the blacklist had been
updated to include those clients.

D is a bit circuitous, but I think it could be interesting as it would
let the mon exercise some discretion on whether to do the client
blacklisting or not, rather than giving the MDSs such power.

John
