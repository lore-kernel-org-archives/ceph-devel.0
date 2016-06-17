From: Gregory Farnum <gfarnum@redhat.com>
Subject: CephFS code deep dive
Date: Fri, 17 Jun 2016 14:03:32 -0700
Message-ID: <CAJ4mKGbSq3iTcwHvRdHSRGxR-1_CLgyEU+Te+Nqpc619Nd4Q-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36854 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcFQVDe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 17:03:34 -0400
Received: by mail-vk0-f47.google.com with SMTP id u64so131385136vkf.3
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 14:03:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I spent a few days this week discussing CephFS with some new
contributors working at Red Hat, and I managed to record some of it.
We decided to share the recordings publicly, but let me be clear about
what these are not:
*) These are not prepared. There are no slides; I say "um" a lot
*) These are not the word of god. I said untrue things and caught
it/got caught a few times, but probably still lied somewhere else that
wasn't noticed.
*) These are not user discussions or designed as an intro to CephFS.
If you aren't comfortable following the source code and trying to
relate it to concepts in Sage's thesis
(http://ceph.com/papers/weil-thesis.pdf) on your own, these won't help
you.

What these are, is about 8 hours of a fairly one-sided conversation
about the CephFS source code and some of its design.

All that said, the video links and an outline of their contents:

https://bluejeans.com/s/9QN_/
Chapter 1: The messenger/dispatcher model; how mknod works from the client side

https://bluejeans.com/s/9QO5/
Chapter 1: client-side structs: Inode, Dentry, Fh, MetaSession
server-side: MDS ranks versus daemons, and their major components; MDS
dispatch routing; handle_mds_map; Mutation/MDRequestRefs; the
beginnings of mknod; traversing the cache
Chapter 2: Selecting and acquiring locks; more mknod; bunches of
metadata projecting/logging code; some file cap handling

https://bluejeans.com/s/9QRO/
Unfortunately, starting from this point I no longer have video of the
terminal I was using to display code. Stuff will be a lot less useful
without that, but I think I still reference enough function names for
dedicated listeners to follow along. :)
Chapter 1: setattr code from both sides; file capabilities and
flushing from both sides; locks.c (our lock transitions)
Chapter 2: metadata on-disk storage; encoding functions
Chapter 3: unlink, from the client and server; leading into file
purging code (stray directories!); beginning of layouts and backtraces

https://bluejeans.com/s/9QTk/
again, no terminal content
Chapter 1: purging and backtraces finished; rename on both client and server
Chapter 2: This has got to be totally unintelligible rambling about
snapshots, since I gave up on displaying code and started drawing on a
whiteboard

If anybody does manage to watch these and get something out of them,
feel free to ask questions either here on the list or on #ceph-devel.
:)
-Greg
