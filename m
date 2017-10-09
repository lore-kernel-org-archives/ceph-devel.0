From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: deleting snapshots in batches?
Date: Mon, 9 Oct 2017 12:13:31 -0400
Message-ID: <CAGbvivLpWC=WUgmPA0q5Tt5wXF=1bx3kcAWP7drnYWfznBBUBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:43296 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbdJIQNe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Oct 2017 12:13:34 -0400
Received: by mail-lf0-f41.google.com with SMTP id a16so10466959lfk.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Oct 2017 09:13:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

We have a cluster (10.2.9 based) with a cephfs filesytem that has
4800+ snapshots. We want to delete most of the very old ones to get it
to a more manageable number (such as 0).  However, deleting even 1
snapshot right now takes up to a full 24 hours due to their age and
size. It would literally take 13 years to delete all of them at the
current pace.

Here is one snapshot directory statistics:

# file: cephfs/.snap/snapshot.2017-02-24_22_17_01-1487992621
ceph.dir.entries="3"
ceph.dir.files="0"
ceph.dir.rbytes="30500769204664"
ceph.dir.rctime="1504695439.09966088000"
ceph.dir.rentries="7802785"
ceph.dir.rfiles="7758691"
ceph.dir.rsubdirs="44094"
ceph.dir.subdirs="3"

There is a bug filed with details here: http://tracker.ceph.com/issues/21412

Im wondering if there is a faster, undocumented, "backdoor" way to
clean up our snapshot mess without destroying the entire filesystem
and recreating it.

-Wyllys Ingersoll
 Keeper Technology, LLC
