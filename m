From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Orphaned objects after deleting rbd images
Date: Wed, 21 Dec 2016 16:06:20 +0100
Message-ID: <CAPed3OHxy2r0RvPANMRwSAtxUsWEVDHtjHSD+dAeiYgrmTbv7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36284 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbcLUPGm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 10:06:42 -0500
Received: by mail-vk0-f46.google.com with SMTP id p9so150824951vkd.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2016 07:06:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I have a cluster used purely for storing rbd images.
I spent the last few days tracking down why the increase in storage
did not match what I imported, and found it was caused by this:

$ sudo rbd rm test-root
2016-12-21 14:46:38.479281 7fa1e17d8760 -1 librbd: Image uses
unsupported features: 48
Removing image: 100% complete...done.
$ echo $?
$ 0

Checking with rbd df before and after I noticed that only one object
was deleted (probably the header) and the total usage did not
decrease.

The scripts that I used only checked the return code of rbd so assumed
successful deletion.
Run them enough times and suddenly you're wondering where 100TB has gone...

A bit of background, the cluster runs Jewel, but the rbd client used
to delete these images was the one from Hammer.

I was wondering if this is a known issue?

Kind regards,

Ruben Kerkhof
