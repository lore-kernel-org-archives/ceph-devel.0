From: Two Spirit <twospirit6905@gmail.com>
Subject: file in one file system is a directory in ceph
Date: Thu, 14 Sep 2017 14:00:42 -0700
Message-ID: <CAKRxpus4LRh_OyBJpy7KSn5n2L0HEVFzfpj5NywSS=zf8kbGWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:49140 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdINVAn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 17:00:43 -0400
Received: by mail-io0-f174.google.com with SMTP id n69so3762874ioi.5
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 14:00:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I was trying to track down a file that keeps showing up as a directory in ceph.

The user literally has a files called ".snap", and it tried to copy
into cephfs, and it kept complaining and kept reappearing as a
directory. delete the directory and recopy the .snap file. I found out
.snap is a special hidden ceph directory. the user is actually on a
project called "SNAP".

Is there anything that can be done about this? My priority is to the
user being able to name their files anything except certain well
understood special characters. There is already a little contention
between unix and windows filesystems eg ':', but nobody will know that
their underlying file system will be changed to ceph or if used for
backups systems and that the backup system can't properly copy their
file due to the name..nobody is expecting this limitation.

I, not know what the .snap was for, force deleted it, not realizing I
was removing possible user snapshots.

Feels wrong to tell a user they can't name their file .snap.

Just food for thought. Is this moveable out of band. I've used
snapshot software before -- even whole drive snapshots, and the
snapshots for the most part were hidden or explicitly visible from
mount. In unix, super fast snapshots can be made 'cp -lrp'
