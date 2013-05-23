From: Milosz Tanski <milosz@adfin.com>
Subject: Fscache support for Ceph
Date: Thu, 23 May 2013 17:48:28 -0400
Message-ID: <CANP1eJHjpUJ1ZFszAy=ZsAvZKpPDFMHjNj7JRRUhV88yuH0dyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:56800 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759551Ab3EWVs3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 17:48:29 -0400
Received: by mail-we0-f175.google.com with SMTP id p60so2427436wes.34
        for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 14:48:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, linux-cachefs@redhat.com

This is my first at adding fscache support for the Ceph Linux module.

My motivation for doing this work was speedup our distributed database
that uses the Ceph filesystem as a backing store. By far more of the
workload that our application is doing is read only and latency is our
biggest challenge. Being able to cache frequently used blocks on the
SSD drives that our machines use dramatically speeds up our query
setup time when we're fetching multiple compressed indexes and then
navigating the block tree.

The branch containing the two patches is here:
https://bitbucket.org/adfin/linux-fs.git in the forceph branch.

If you want to review it in your browser here is the bitbucket url:
https://bitbucket.org/adfin/linux-fs/commits/branch/forceph

I've tested this both in mainline and in the branch that features
upcoming fscache changes. The patches are broken into two pieces.

01 - Setups the facility for fscache in it's independent files
02 - Enables fscache in the ceph filesystem and adds a new configuration option

The patches will follow in the new few emails as well.

Future wise; there's some new work being done to add write-back
caching to fscache & NFS. When that's done I'd like to integrated the
Ceph fscache implementation. From the benchmarks of the author of that
it seams like it has much the same benefit for write to NFS as bcache
does.

I'd like to get this into ceph, and I'm looking for feedback.

Thanks,
- Milosz
