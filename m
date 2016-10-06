From: Alfredo Deza <adeza@redhat.com>
Subject: new naming convention for building repos and binaries from branches
Date: Thu, 6 Oct 2016 11:43:59 -0400
Message-ID: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37817 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942060AbcJFPoB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 11:44:01 -0400
Received: by mail-wm0-f46.google.com with SMTP id b201so55242304wmb.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 08:44:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

The (current) behavior with gitbuilders is that it builds every commit
of every branch in Github.

With the new CI system, although we can cope with the demand as the
Ceph project grows in contributions, we are planning on only building
branches that really need to be built.

This keeps the whole system going as fast as possible (we are
currently getting full repositories in about 1 hour) and very
efficient.

We need to come up with a naming convention for branches to be built.
At the moment we are building everything and that is preventing us
from enabling other features in the system like all the other
"flavors" (e.g. tcmalloc).

Branch names for builds will need certain restrictions. Because the
system is based on HTTP components, no HTTP reserved chars can be used
(e.g. historic/libradosgw would be a no-go). Other invalid chars are:
& , ; ? = + $ :

We could keep the implicit convention for `wip-*` or maybe something similar?

Ideas welcomed :)
