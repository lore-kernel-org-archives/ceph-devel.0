From: Ken Dreyer <kdreyer@redhat.com>
Subject: renaming "radosgw" deb to "ceph-radosgw" post-luminous
Date: Mon, 17 Jul 2017 11:46:32 -0600
Message-ID: <CALqRxCy-=23VWgM7UjTUumuc2=sfQ_LK_tKnZueGNaiQZCZXsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34579 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdGQRqd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jul 2017 13:46:33 -0400
Received: by mail-ua0-f172.google.com with SMTP id z22so102935586uah.1
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jul 2017 10:46:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: ceph-ansible@lists.ceph.com

The debian and RPM packages are getting more aligned, although there
are a couple things that still differ.

One of the differences is the name of the RGW package. On RPM-based
distros it's "ceph-radosgw", on Debian-based it's "radosgw".

I plan to push a package rename for radosgw -> ceph-radosgw post-Luminous.

I've filed http://tracker.ceph.com/issues/20651 to track this. Are
there any other dependencies we should be aware of when we make this
package rename that I'm missing?

In particular I want to be sure there is enough time for ubuntu.com
and debian.org to pick up this rename downstream so that ceph.com
doesn't ship packages that differ in this regard.

- Ken
