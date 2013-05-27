From: Alexandre Oliva <oliva@gnu.org>
Subject: cuttlefish ceph-fuse writes make for frequent inconsistent pgs
Date: Mon, 27 May 2013 17:34:08 -0300
Message-ID: <orzjvgi2m7.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:46993 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482Ab3E0UsP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 16:48:15 -0400
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r4RKYPtK008873
	for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 20:34:26 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've used ceph.ko for most of my cephfs operations these days, but I've
recently used a ceph-fuse mountpoint for a while, and results were odd:
a number of PGs were flagged as inconsistent upon their subsequent
scrub, and I could determine that all affected files had been written to
during the brief period in which I used the ceph-fuse mountpoint.

Although I had some 10 osd files go inconsistent out of perhaps a
thousand files written to, I only investigated closely what happened to
two of them.

One was a ~2KiB text file I'd rsynced into the ceph-fuse mountpoint.
The OSDs holding the 3 replicas of the PG in which the entire file ended
up had 4MiB files, instead of ~2KiB files.  The first ~2KiB correctly
held the file data on all 3 replicas, but the rest of the file was
random garbage, and it was different on each replica.  Most
inconsistencies I got were of this kind, and they could all be fixed by
truncating the file and writing it back.

The one exception to this rule was a torrent download of a DVD image of
a GNU/Linux-libre distribution.  A deep-scrub part-way through the
download identified an inconsistency, days after the file had been last
modified (the download was paused for unrelated reasons), and comparing
the inconsistent 4MiB file, I identified a small portion (less than 512
bytes) that was different random binary garbage in two of the replicas,
and base64-encoded junk in the other.  I presume this may have started
just like the first case above, with a small write to part of a new 4MiB
chunk, with the random junk in each part being overwritten as the
download progressed, leaving just a small portion of the torrent that
hadn't been downloaded yet, and that therefore remained with junk.


What strikes me as the oddest part of this picture is that, while this
behavior was triggered several times during a brief use of ceph-fuse, it
does not seem to happen with ceph.ko mounts.  Now, I don't see why the
osds should care what kind of client is sending write ops to them before
they send the newly-created file (or a small part thereof) to the
replicas, but since different behavior is observed, there must be some
difference, and that difference must be a bug, for either the master osd
is sending *different* junk to each of the replicas, or each replica is
receiving only part of the file and filling the rest of the file with
junk of its own making.  But only when the write came from ceph-fuse
and, even then, only for a small fraction of the writes.

An uninitialized buffer being partially overwritten by the small write,
on either side of each replication pair, would explain the random junk,
and perhaps even why each replica gets different random junk, but it
wouldn't explain why the heck several small files ended up taking up an
entire 4MiB chunk on the OSDs.

Thoughts?

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
