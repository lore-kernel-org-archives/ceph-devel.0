From: Travis Rhoden <trhoden@gmail.com>
Subject: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 11:51:23 -0400
Message-ID: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62742 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758850Ab2INPvo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 11:51:44 -0400
Received: by qcro28 with SMTP id o28so2901919qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 08:51:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello folks,

On a running Ceph cluster using XFS for the OSD's, is it safe to
defrag the OSD devices while the system is live?

I did a quick check of one device:

xfs_db -c frag -r /dev/sdd
actual 637596, ideal 144935, fragmentation factor 77.27%

I've only been running on these particular machines for a couple of
weeks.  I am thinking of putting in a cron task that defrags disks
every week or as needed (on a rolling schedule).

While I'm talking about XFS...  I know that RBD's use a default object
size of 4MB.  I've stuck with that so far..  Would it be beneficial to
mount XFS with -o allocsize=4M ?  What is the object size that gets
used for non-RBD cases -- i.e. just dumping objects into data pool?

Thanks,

 - Travis
