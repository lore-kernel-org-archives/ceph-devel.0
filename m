From: Nick Bartos <nick@pistoncloud.com>
Subject: "converting" btrfs osds to xfs?
Date: Tue, 8 May 2012 08:39:55 -0700
Message-ID: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50705 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab2EHPj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 May 2012 11:39:58 -0400
Received: by yenm10 with SMTP id m10so4957007yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 May 2012 08:39:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am considering converting some OSDs to xfs (currently running btrfs)
for stability reasons.  I have a couple of ideas for doing this, and
was hoping to get some comments:

Method #1:
1.  Check cluster health and make sure data on a specific OSD is
replicated elsewhere.
2.  Bring down the OSD
3.  Reformat it to xfs
4.  Restart OSD
5.  Repeat 1-4 until all btrfs OSDs have been converted.

Method #2:
1.  Take cluster offline.
2.  Copy the data off btrfs onto a separate disk
3.  Reformat it to xfs
4.  Copy data back
5.  Repeat 1-4 until all btrfs disks have been converted.
6.  Bring up cluster.

Obviously #1 seems much more appetizing, but unfortunately I can't
seem to find out how to verify that data on a specific OSD is
replicated elsewhere.  I could go off general cluster health, but that
seems more error prone.

Going with #2 would incur a large downtime, which I would like to
avoid.  Additionally, I am not completely certain which data must be
copied off and restored, as it seems some btrfs snapshots are done
which would not easily be migratable to xfs.

Which of these sounds better to other people?  Is there a method #3?
