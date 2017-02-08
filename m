From: John Spray <jspray@redhat.com>
Subject: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 12:26:09 +0000
Message-ID: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36750 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbdBHMfH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 07:35:07 -0500
Received: by mail-wm0-f41.google.com with SMTP id c85so195447147wmi.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 04:34:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

So I've just finished upgrading my home cluster OSDs to bluestore by
killing them one by one and then letting backfill happen to "new" OSDs
on the same drives.  Hooray!

One slightly awkward thing I ran into was that even though I had noout
set throughout, during the period between removing the old OSD and
adding the "new" one, some PGs would of course get remapped (and start
generating backfill IO to third party OSDs).  This does make sense
when you think about it (noout doesn't make the cluster magically
remember OSDs that have been removed), but is still an undesirable
behaviour.

A) Do we currently have a mechanism to tell the cluster "even though I
removed this OSD, don't go moving PGs around just yet"?  Should we add
one?
B) Was there a way for me to avoid this by e.g. skipping the "osd rm
X" and "osd crush rm osd.X" that I'm currently doing before adding the
new OSD that will take the old OSD's ID?

John
