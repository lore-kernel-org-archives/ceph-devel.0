From: Gregory Farnum <gfarnum@redhat.com>
Subject: enabling shared ccache dirs in default builds
Date: Tue, 6 Dec 2016 16:09:04 -0800
Message-ID: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:32877 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcLGAJG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2016 19:09:06 -0500
Received: by mail-io0-f181.google.com with SMTP id j65so683608368iof.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2016 16:09:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The default (or at least, ./do_cmake.sh-setup) Ceph build makes use of
cmake. This is nice for speeding up builds, but as the amount of disk
space increases it really explodes disk usage on dev boxes. As of
today, a Ceph repo with build artifacts is ~30GB, and my ccache
directory is ~32GB.

For me and many of the other Red Hat devs, that's a significant
fraction of the 256GB available on our (shared box) home-dir SSDs, and
I don't think there's *too* much advantage to be gained by giving each
dev their own ccache dir. If anybody has expertise configuring ccache
and wants to tweak our build scripts to make setting that up easy,
it'd be cool — I started in on the ccache man page and it doesn't look
too hard but I've never configured any of it. Created a ticket at
http://tracker.ceph.com/issues/18160
-Greg
