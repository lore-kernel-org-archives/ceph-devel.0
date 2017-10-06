From: Alfredo Deza <adeza@redhat.com>
Subject: ceph-volume: migration and disk partition support
Date: Fri, 6 Oct 2017 12:56:03 -0400
Message-ID: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:49034 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdJFQ4F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Oct 2017 12:56:05 -0400
Received: by mail-wm0-f52.google.com with SMTP id i124so8654215wmf.3
        for <ceph-devel@vger.kernel.org>; Fri, 06 Oct 2017 09:56:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

Now that ceph-volume is part of the Luminous release, we've been able
to provide filestore support for LVM-based OSDs. We are making use of
LVM's powerful mechanisms to store metadata which allows the process
to no longer rely on UDEV and GPT labels (unlike ceph-disk).

Bluestore support should be the next step for `ceph-volume lvm`, and
while that is planned we are thinking of ways to improve the current
caveats (like OSDs not coming up) for clusters that have deployed OSDs
with ceph-disk.

--- New clusters ---
The `ceph-volume lvm` deployment is straightforward (currently
supported in ceph-ansible), but there isn't support for plain disks
(with partitions) currently, like there is with ceph-disk.

Is there a pressing interest in supporting plain disks with
partitions? Or only supporting LVM-based OSDs fine?

--- Existing clusters ---
Migration to ceph-volume, even with plain disk support means
re-creating the OSD from scratch, which would end up moving data.
There is no way to make a GPT/ceph-disk OSD become a ceph-volume one
without starting from scratch.

A temporary workaround would be to provide a way for existing OSDs to
be brought up without UDEV and ceph-disk, by creating logic in
ceph-volume that could load them with systemd directly. This wouldn't
make them lvm-based, nor it would mean there is direct support for
them, just a temporary workaround to make them start without UDEV and
ceph-disk.

I'm interested in what current users might look for here,: is it fine
to provide this workaround if the issues are that problematic? Or is
it OK to plan a migration towards ceph-volume OSDs?

-Alfredo
