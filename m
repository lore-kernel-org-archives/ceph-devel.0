From: Samuel Just <sjust@redhat.com>
Subject: Notes from a discussion a design to allow EC overwrites
Date: Thu, 12 Nov 2015 14:37:32 -0800
Message-ID: <CAN=+7FUAd-Cc0=1yCekY1QjQ2DJR7WYLLv2OhR_0H5qo5DNgkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34633 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbbKLWhd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Nov 2015 17:37:33 -0500
Received: by ioir85 with SMTP id r85so39744641ioi.1
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2015 14:37:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Samuels, Allen" <allen.samuels@sandisk.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Farnum, Gregory" <gfarnum@redhat.com>

I was present for a discussion about allowing EC overwrites and thought it
would be good to summarize it for the list:

Commit Protocol:
1) client sends write to primary
2) primary reads in partial stripes needed for partial stripe
overwrites from replicas
3) primary sends prepares to participating replicas and queues its own
prepare locally
4) once all prepares are complete, primary sends a commit to the client
5) primary sends applies to all participating replicas

When we get the prepare, we write out a temp object with the data to be
written.  On apply, we use an objectstore primitive to atomically move those
extents into the actual object.  The log entry contains the name/id for the
temp object so it can be applied on apply or removed on rollback.

Each log entry contains a list of the shard ids modified.  During peering, we
use the same protocol for choosing the authoritative log for the existing EC
pool, except that we first take the longest candidate log and use it to extend
shorter logs until they hit an entry they should have witnessed, but didn't.

Implicit in the above scheme is the fact that if an object is written, but a
particular shard isn't changed, the osd with that shard will have a copy of the
object with the correct data, but an out of date object_into (notably, the
version will be old).  To avoid this messing up the missing set during the log
scan on OSD start, we'll skip log entries we wouldn't have participated in (we
may not even choose to store them, see below).  This does generally pose a
challenge for maintaining prior_version.  It seems like it shouldn't be much of
a problem since rollbacks can only happen on prepared log entries which haven't
been applied, so log merging can never result in a divergent entry causing a
missing object.  I think we can get by without it then?

We can go further with the above and actually never persist a log entry on a
shard which it did not participate in.  As long as peering works correctly, the
union of the logs we got must have all entries.  The primary will need to keep
a complete copy in memory to manage dup op detection and recovery, however.

2) above can also be done much more efficiently.  Some codes will allow the
parity chunks to be reconstructed more efficiently, so some thought will
have to go into restructuring the plugin interface to allow more efficient
-Sam
